import 'dart:convert';

import 'package:cafe_order/print.dart';
import 'package:cafe_order/screen/mian_screen.dart';
import 'package:cafe_order/widget/custon_appbar.dart';
import 'package:cafe_order/widget/order_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cafe_order/globals.dart' as globals;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:requests/requests.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';

class OrderScreen extends StatefulWidget {
  final int tableId;
  final int expenseId;
  OrderScreen({this.tableId, this.expenseId, Key key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool _showReciept = false;
  final formatter = new NumberFormat("# ### ###");
  String orderStatus = "create";
  List<dynamic> _products = [];

  List<dynamic> _order = [];
  List<dynamic> _orderChange = [];

  double totalSum;
  getTotal() {
    double sum = 0;

    _order.forEach((element) {
      sum += element["price"] * element["cnt"];
    });
    return sum + (sum / 100 * globals.userData['percent']);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderStruct();

    if (widget.expenseId != null) {
      orderStatus = "update";
    }
  }

  getOrderStruct() async {
    try {
      var url = '${globals.apiLink}order-struct/${widget.expenseId}';
      var response = await Requests.get(
        url,
      );
      if (response.statusCode == 200) {
        var res = response.json();
        if (res["dish"].length != 0) {
          res["dish"].forEach((item) {
            var temp = {
              "id": "dish_${item["id"]}",
              "name": item["name"],
              "price": item["price"],
              "cnt": item["cnt"],
            };
            _order.add(temp);
          });
        }
        if (res["stuff"].length != 0) {
          res["stuff"].forEach((item) {
            var temp = {
              "id": "stuff_${item["id"]}",
              "name": item["name"],
              "price": item["price"],
              "cnt": item["cnt"],
            };
            _order.add(temp);
          });
        }
        if (res["product"].length != 0) {
          res["product"].forEach((item) {
            var temp = {
              "id": "product_${item["id"]}",
              "name": item["name"],
              "price": item["price"],
              "cnt": item["cnt"],
            };
            _order.add(temp);
          });
        }
        setState(() {});
      } else {
        dynamic json = response.json();
      }
    } catch (e) {
      print(e);
    }
  }

  void plusCnt(item) {
    setState(() {
      item["cnt"]++;
      totalSum = getTotal();
    });
    addToOrderChange(item);
  }

  void setDefaultVal(item, cnt) {
    try {
      var hasProd = _orderChange.firstWhere(
          (element) => element["id"] == item["id"],
          orElse: () => {});
      if (!hasProd.isEmpty && hasProd["cnt"] != 0) {
        if (hasProd["cnt"] < cnt) {
          addToOrder(item, cnt: cnt);
          addToOrderChange(item, cnt: cnt - (item["cnt"] - hasProd["cnt"]));
          setState(() {
            totalSum = getTotal();
          });
        } else {
          print("fuck off");
        }
      } else {
        if (item["cnt"] < cnt) {
          addToOrder(item, cnt: cnt);
          addToOrderChange(item, cnt: cnt - (item["cnt"] - hasProd["cnt"]));
          setState(() {
            totalSum = getTotal();
          });
        } else {
          print("fuck off");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void minusCnt(item) {
    try {
      var hasProd = _orderChange.firstWhere(
          (element) => element["id"] == item["id"],
          orElse: () => {});
      if (!hasProd.isEmpty && hasProd["cnt"] != 0) {
        var minVal = (item["cnt"] - hasProd["cnt"]);
        var res = item["cnt"] - 1;
        if (res >= minVal) {
          setState(() {
            item["cnt"]--;
            totalSum = getTotal();
          });
          hasProd["cnt"]--;
        } else {
          print("fuck off");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future getCategory() async {
    try {
      var url = '${globals.apiLink}categories';
      var response = await Requests.get(
        url,
      );
      if (response.statusCode == 200) {
        return response.json();
      } else {
        dynamic json = response.json();
      }
    } catch (e) {
      print(e);
    }
  }

  void getProdByCategory(id) async {
    _showReciept = false;
    _isSearch = false;

    try {
      var res = await Requests.get("${globals.apiLink}prod-list/$id");
      if (res.statusCode == 200) {
        _products = [];
        var menu = res.json();
        if (menu["dish"].length != 0) {
          menu["dish"].forEach((val) {
            var temp = {
              "id": "dish_${val["id"]}",
              "name": val["name"],
              "price": val["price"],
              "image": null
            };
            _products.add(temp);
          });
        }
        if (menu["stuff"].length != 0) {
          menu["stuff"].forEach((val) {
            var temp = {
              "id": "stuff_${val["id"]}",
              "name": val["name"],
              "price": val["price"],
              "image": null
            };
            _products.add(temp);
          });
        }
        if (menu["product"].length != 0) {
          menu["product"].forEach((val) {
            var temp = {
              "id": "product_${val["id"]}",
              "name": val["name"],
              "price": val["price"],
              "image": null
            };
            _products.add(temp);
          });
        }
        setState(() {});
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e);
    }
  }

  TextEditingController searchController = TextEditingController();
  bool _isSearch = false;
  void searchProd() {
    setState(() {
      _isSearch = !_isSearch;
    });
  }

  void addToOrderChange(prod, {cnt = 0}) {
    try {
      var item = _orderChange.firstWhere(
          (element) => element["id"] == prod["id"],
          orElse: () => {});

      if (item.isEmpty) {
        Map<String, dynamic> temp = {
          "id": "${prod["id"]}",
          "name": "${prod["name"]}",
          "price": prod["price"],
          "cnt": cnt == 0 ? 1 : cnt,
        };
        setState(() {
          _orderChange.add(temp);
          totalSum = getTotal();
        });
      } else {
        setState(() {
          if (cnt == 0)
            item["cnt"]++;
          else
            item["cnt"] = cnt;
          totalSum = getTotal();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void addToOrder(prod, {cnt = 0}) {
    try {
      var item = _order.firstWhere((element) => element["id"] == prod["id"],
          orElse: () => {});

      if (item.isEmpty) {
        Map<String, dynamic> temp = {
          "id": "${prod["id"]}",
          "name": "${prod["name"]}",
          "price": prod["price"],
          "cnt": cnt == 0 ? 1 : cnt,
        };
        setState(() {
          _order.add(temp);
          totalSum = getTotal();
        });
      } else {
        setState(() {
          if (cnt == 0)
            item["cnt"]++;
          else
            item["cnt"] = cnt;
          totalSum = getTotal();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  searchProducts(String value) async {
    try {
      var url = '${globals.apiLink}search-prod?q=$value';
      var response = await Requests.get(
        url,
      );
      if (response.statusCode == 200) {
        var json = response.json();
        return json;
      }
    } catch (e) {
      print(e);
    }
  }

  final Print prints = new Print();
  addProduct() async {
    try {
      if (widget.expenseId == null) {
        var url = '${globals.apiLink}create-order';
        Map<String, dynamic> data = {
          "table": widget.tableId,
          "employee_id": globals.userData["employee_id"],
          "expSum": totalSum,
          "params": _orderChange,
        };
        if (!_orderChange.isEmpty) {
          var response = await Requests.post(url,
              body: data, bodyEncoding: RequestBodyEncoding.JSON);
          if (response.statusCode == 200) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (BuildContext ctx) {
              return MainScreen();
            }), (route) => false);
          }
        } else {
          prints.testPrint("192.168.1.200", context);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext ctx) {
            return MainScreen();
          }), (route) => false);
        }
      } else {
        var url = '${globals.apiLink}update-order/${widget.expenseId}';
        Map<String, dynamic> data = {
          "table": widget.tableId,
          "employee_id": globals.userData["employee_id"],
          "expSum": totalSum,
          "params": _orderChange,
        };
        if (!_orderChange.isEmpty) {
          var response = await Requests.post(url,
              body: data, bodyEncoding: RequestBodyEncoding.JSON);
          if (response.statusCode == 200) {
            prints.testPrint("192.168.1.200", context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (BuildContext ctx) {
              return MainScreen();
            }), (route) => false);
          }
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext ctx) {
            return MainScreen();
          }), (route) => false);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    var appbar = CustomAppbar(
      searchFunc: searchProd,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: dWidth - 40,
                height: dHeight - appbar.preferredSize.height - 150,
                child: GridView.builder(
                    padding: EdgeInsets.all(0),
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 1.6,
                    ),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                            bottom: 10, left: index % 2 == 0 ? 0 : 10),
                        child: InkWell(
                          onTap: () {
                            addToOrder(_products[index]);
                            addToOrderChange(_products[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: globals.mainColor))
                                // border: Border.all(width: 1, color: Colors.black),
                                ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: globals.fourthColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          color: globals.fourthColor,
                                          width: 1,
                                        )),
                                    height: dWidth / 2 / 1.6 - 40,
                                    width: dWidth,
                                    // color: Colors.grey,
                                    child: FittedBox(
                                        fit: _products[index]["image"] != null
                                            ? BoxFit.cover
                                            : BoxFit.contain,
                                        child: _products[index]["image"] != null
                                            ? Image.network(
                                                _products[index]["image"])
                                            : SvgPicture.asset(
                                                "assets/img/no-photo.svg",
                                                height: 40,
                                                color: globals.thirdColor,
                                              )),
                                  ),
                                ),
                                Positioned(
                                    top: 5,
                                    right: 5,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: globals.mainColor,
                                      ),
                                      child: AutoSizeText(
                                        "${_products[index]["price"]}",
                                        style: TextStyle(
                                          fontFamily: globals.font,
                                          color: globals.fourthColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                                Positioned(
                                  bottom: 5,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: dWidth / 2 / 1.6 -
                                        (dWidth / 2 / 1.6 - 40),
                                    width: dWidth / 2 - 20,
                                    child: AutoSizeText(
                                      _products[index]["name"],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: globals.font,
                                        fontSize: 7,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            _showReciept
                ? Positioned(
                    top: 0,
                    child: Container(
                      color: Colors.white,
                      width: dWidth - 40,
                      height: dHeight - appbar.preferredSize.height - 150,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: AutoSizeText(
                                  "Наименование",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: globals.font,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Цена",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: globals.font,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Кол-во",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: globals.font,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Сумма",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: globals.font,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: globals.mainColor,
                            thickness: 1,
                          ),
                          Container(
                            height: dHeight - appbar.preferredSize.height - 235,
                            child: ListView.builder(
                                itemCount: _order.length,
                                itemBuilder: (content, index) {
                                  return OrderRow(
                                    orderRow: _order[index],
                                    plus: plusCnt,
                                    minus: minusCnt,
                                    customVal: setDefaultVal,
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(),
            _isSearch
                ? Positioned(
                    top: 0,
                    child: Container(
                      color: Colors.white,
                      width: dWidth - 40,
                      height: dHeight - appbar.preferredSize.height - 150,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: globals.mainColor,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            child: TypeAheadField(
                              addWidth: 30,
                              offsetLeft: 10,
                              textFieldConfiguration: TextFieldConfiguration(
                                // onSubmitted: (value) {
                                //   Navigator.pop(context, false);
                                // },
                                // controller: searchAddressController,
                                autofocus: true,
                                decoration: InputDecoration.collapsed(
                                  hintText: "".tr().toString(),
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(fontSize: 18),
                                ),
                              ),

                              suggestionsCallback: (pattern) async {
                                return await searchProducts(pattern);
                              },
                              hideOnEmpty: true,
                              // suggestionsBoxController:
                              //     suggestionsBoxController,
                              itemBuilder: (context, suggestion) {
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${suggestion['name']}"),
                                          Text("${suggestion['price']}"),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: 0,
                                    ),
                                  ],
                                );
                              },
                              suggestionsBoxDecoration:
                                  SuggestionsBoxDecoration(offsetX: -10.0),
                              onSuggestionSelected: (suggestion) {
                                addToOrder(suggestion);
                                setState(() {
                                  _isSearch = false;
                                });
                              },
                              noItemsFoundBuilder: (context) {
                                return Text("not_found".tr().toString());
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(),
            Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.only(bottom: 5),
                  width: dWidth - 40,
                  child: Column(
                    children: [
                      Divider(
                        endIndent: 0,
                        indent: 0,
                        thickness: 1,
                        height: 10,
                        color: globals.mainColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            "Итого: +${globals.userData["percent"]}%",
                            style: TextStyle(
                              fontFamily: globals.font,
                              fontSize: 20,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _showReciept = !_showReciept;
                              });
                            },
                            child: Row(children: [
                              SvgPicture.asset(
                                _showReciept
                                    ? "assets/img/eye.svg"
                                    : "assets/img/visibility.svg",
                                height: _showReciept ? 15 : 24,
                              ),
                              Padding(padding: EdgeInsets.only(left: 5)),
                              AutoSizeText(
                                "${totalSum = getTotal()}",
                                style: TextStyle(
                                  fontFamily: globals.font,
                                  fontSize: 24,
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              addProduct();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                color: globals.fourthColor,
                              ),
                              child: Row(
                                children: [
                                  AutoSizeText(
                                    "Отправить на кухню",
                                    style: TextStyle(
                                        fontFamily: globals.font, fontSize: 16),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  SvgPicture.asset("assets/img/receipt.svg")
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                color: globals.fourthColor,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/img/print.svg")
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: FutureBuilder(
              future: getCategory(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 7),
                            child: InkWell(
                              onTap: () {
                                getProdByCategory(
                                    snapshot.data[index]["type_id"]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  // border:
                                  //     Border.all(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.7),
                                      spreadRadius: 0,
                                      blurRadius: 5,
                                      offset: Offset(
                                          2, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                margin: EdgeInsets.symmetric(vertical: 5),
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text(
                                    snapshot.data[index]["name"],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Container();
              }),
        ),
      ),
    );
  }
}
