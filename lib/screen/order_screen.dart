import 'package:cafe_order/widget/custon_appbar.dart';
import 'package:cafe_order/widget/order_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cafe_order/globals.dart' as globals;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';

class OrderScreen extends StatefulWidget {
  final int tableId;
  OrderScreen({this.tableId, Key key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool _showReciept = false;
  final formatter = new NumberFormat("# ### ###");
  List<dynamic> _menu = [
    {"id": 1, "name": "вторые блюда из говядины"},
    {"id": 2, "name": "вторые блюда из говядины на мангале"}
  ];

  List<dynamic> _products = [
    {
      "id": 1,
      "name": "Узбекистан марочный конякУзбекистан марочный коняк",
      "price": 2000000,
      "image":
          "https://media-cdn.tripadvisor.com/media/photo-s/03/dc/e3/6d/dish-fine-burger-bistro.jpg"
    },
    {
      "id": 2,
      "name": "Куриные сосиски на мангале	",
      "price": 14000,
      "image":
          "https://media-cdn.tripadvisor.com/media/photo-s/03/dc/e3/6d/dish-fine-burger-bistro.jpg"
    },
    {
      "id": 3,
      "name": "Узбекистан марочный коняк ",
      "price": 70000,
      "image":
          "https://media-cdn.tripadvisor.com/media/photo-s/03/dc/e3/6d/dish-fine-burger-bistro.jpg"
    },
    {
      "id": 4,
      "name": "Крылышки в мед-томатном соусе",
      "price": 44000,
      "image":
          "https://media-cdn.tripadvisor.com/media/photo-s/03/dc/e3/6d/dish-fine-burger-bistro.jpg"
    },
    {
      "id": 5,
      "name": "Узбекистан марочный конякУзбекистан  коняк",
      "price": 20000,
      "image":
          "https://media-cdn.tripadvisor.com/media/photo-s/03/dc/e3/6d/dish-fine-burger-bistro.jpg"
    },
    {
      "id": 6,
      "name": "Узбекистан марочный конякУзбекистан марочный коняк",
      "price": 2000000,
      "image":
          "https://media-cdn.tripadvisor.com/media/photo-s/03/dc/e3/6d/dish-fine-burger-bistro.jpg"
    },
    {
      "id": 7,
      "name": "Куриные сосиски на мангале	",
      "price": 14000,
      "image":
          "https://media-cdn.tripadvisor.com/media/photo-s/03/dc/e3/6d/dish-fine-burger-bistro.jpg"
    },
    {
      "id": 8,
      "name": "Узбекистан марочный коняк ",
      "price": 70000,
      "image":
          "https://media-cdn.tripadvisor.com/media/photo-s/03/dc/e3/6d/dish-fine-burger-bistro.jpg"
    },
    {
      "id": 9,
      "name": "Крылышки в мед-томатном соусе",
      "price": 44000,
      "image":
          "https://media-cdn.tripadvisor.com/media/photo-s/03/dc/e3/6d/dish-fine-burger-bistro.jpg"
    },
    {
      "id": 10,
      "name": "Узбекистан марочный конякУзбекистан  коняк",
      "price": 20000,
      "image":
          "https://media-cdn.tripadvisor.com/media/photo-s/03/dc/e3/6d/dish-fine-burger-bistro.jpg"
    },
    {
      "id": 11,
      "name": "Узбекистан марочный конякУзбекистан марочный коняк",
      "price": 2000000,
      "image":
          "https://media-cdn.tripadvisor.com/media/photo-s/03/dc/e3/6d/dish-fine-burger-bistro.jpg"
    },
    {
      "id": 2,
      "name": "Куриные сосиски на мангале	",
      "price": 14000,
      "image":
          "https://media-cdn.tripadvisor.com/media/photo-s/03/dc/e3/6d/dish-fine-burger-bistro.jpg"
    },
    {
      "id": 3,
      "name": "Узбекистан марочный коняк ",
      "price": 70000,
      "image":
          "https://media-cdn.tripadvisor.com/media/photo-s/03/dc/e3/6d/dish-fine-burger-bistro.jpg"
    },
    {
      "id": 4,
      "name": "Крылышки в мед-томатном соусе",
      "price": 44000,
      "image":
          "https://media-cdn.tripadvisor.com/media/photo-s/03/dc/e3/6d/dish-fine-burger-bistro.jpg"
    },
    {
      "id": 15,
      "name": "Узбекистан марочный конякУзбекистан  коняк",
      "price": 20000,
      "image":
          "https://media-cdn.tripadvisor.com/media/photo-s/03/dc/e3/6d/dish-fine-burger-bistro.jpg"
    },
  ];

  void plusCnt(item) {
    setState(() {
      item["cnt"]++;
      globals.totalSum = globals.getTotal();
    });
  }

  void minusCnt(item) {
    setState(() {
      item["cnt"]--;
      globals.totalSum = globals.getTotal();
    });
  }

  TextEditingController searchController = TextEditingController();
  bool _isSearch = false;
  void searchProd() {
    setState(() {
      _isSearch = !_isSearch;
    });
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
                height: dHeight - appbar.preferredSize.height - 200,
                child: GridView.builder(
                    padding: EdgeInsets.all(0),
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 1.6,
                    ),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          try {
                            var item = globals.orders.firstWhere(
                                (element) =>
                                    element["id"] == _products[index]["id"],
                                orElse: () => {});

                            if (item.isEmpty) {
                              Map<String, dynamic> temp = {
                                "id": _products[index]["id"],
                                "name": _products[index]["name"],
                                "price": _products[index]["price"],
                                "cnt": 1,
                              };
                              setState(() {
                                globals.orders.add(temp);
                                globals.totalSum = globals.getTotal();
                              });
                            } else {
                              setState(() {
                                item["cnt"]++;
                                globals.totalSum = globals.getTotal();
                              });
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: 10, left: index % 2 == 0 ? 0 : 10),
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
                                  height: dWidth / 2 / 1.6 - 40,
                                  width: dWidth,
                                  child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.network(
                                          _products[index]["image"])),
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
                      height: dHeight - appbar.preferredSize.height - 200,
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
                                itemCount: globals.orders.length,
                                itemBuilder: (content, index) {
                                  return OrderRow(
                                    orderRow: globals.orders[index],
                                    plus: plusCnt,
                                    minus: minusCnt,
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
                      height: dHeight - appbar.preferredSize.height - 200,
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
                            child: TextField(
                              autofocus: true,
                              controller: searchController,
                              decoration: InputDecoration.collapsed(
                                hintText: "",
                                hintStyle: TextStyle(
                                    fontFamily: globals.font, fontSize: 18),
                              ),
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
                      InkWell(
                        onTap: () {
                          setState(() {
                            _showReciept = !_showReciept;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xffffffff),
                                globals.fourthColor,
                              ],
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(_showReciept
                                ? "assets/img/down-arrow.svg"
                                : "assets/img/up-arrow.svg"),
                          ),
                        ),
                      ),
                      Divider(
                        endIndent: 0,
                        indent: 0,
                        thickness: 1,
                        height: 10,
                        color: globals.mainColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            "Итого:",
                            style: TextStyle(
                              fontFamily: globals.font,
                              fontSize: 20,
                            ),
                          ),
                          AutoSizeText(
                            "${globals.totalSum = globals.getTotal()}",
                            style: TextStyle(
                              fontFamily: globals.font,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
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
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ListView.builder(
            itemCount: _menu.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(2, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(
                      _menu[index]["name"],
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
