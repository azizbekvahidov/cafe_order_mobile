import 'dart:convert';

import 'package:cafe_mostbyte/bloc/order/order_bloc.dart';
import 'package:cafe_mostbyte/components/custom_block/custom_drawer.dart';
import 'package:cafe_mostbyte/components/expense_card.dart';
import 'package:cafe_mostbyte/components/menu_list.dart';
import 'package:cafe_mostbyte/components/order_footer.dart';
import 'package:cafe_mostbyte/components/product_card.dart';
import 'package:cafe_mostbyte/components/search.dart';
import 'package:cafe_mostbyte/components/tabs.dart';
import 'package:cafe_mostbyte/services/network_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../print.dart';
import './mian_screen.dart';
import '../widget/custom_appbar.dart';
import '../widget/order_row.dart';
import 'package:flutter/material.dart';
import '../config/globals.dart' as globals;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';

_OrderScreenState? orderScreenState;

class OrderScreen extends StatefulWidget {
  final int? tableId;
  final int? expenseId;
  final String? tableName;
  OrderScreen({this.tableId, this.expenseId, this.tableName, Key? key})
      : super(key: key);

  @override
  _OrderScreenState createState() {
    orderScreenState = _OrderScreenState();
    return orderScreenState!;
  }
}

class _OrderScreenState extends State<OrderScreen> {
  bool _showReciept = true;
  final formatter = new NumberFormat("# ### ###");
  String orderStatus = "create";
  Map<String, dynamic>? expense_data;
  List<dynamic> _products = [];
  var connect = new NetworkService();
  var _categories;
  List<dynamic> _order = [];
  List<dynamic> _orderChange = [];
  bool sendRequest = false;

  double? totalSum;
  getTotal() {
    double sum = 0;

    _order.forEach((element) {
      // sum += element["price"] * element["cnt"];
    });
    return sum + (sum / 100 * int.parse(globals.settings!.percent));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    if (widget.expenseId != null) {
      orderStatus = "update";
    }
  }

  @override
  void dispose() {
    globals.currentExpenseId = 0;
    super.dispose();
  }

  loadData() async {
    await orderBloc.fetchCategory();
    await orderBloc.fetchExpenses(id: globals.filial);
  }

  getOrderStruct() async {
    try {
      var response = await connect
          .get('${globals.apiLink}/order-struct/${widget.expenseId}');
      orderScreenState!.setState(() {});
      globals.isServerConnection = true;
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        expense_data = res["expense"];
        if (res["dish"].length != 0) {
          res["dish"].forEach((item) {
            var temp = {
              "id": "dish_${item["id"]}",
              "name": item["name"],
              "price": item["price"],
              "cnt": item["cnt"],
              "department_id": item["department_id"],
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
              "department_id": item["department_id"],
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
              "department_id": item["department_id"],
            };
            _order.add(temp);
          });
        }
        setState(() {});
      } else {
        dynamic res = json.decode(response.body);
      }
    } catch (e) {
      globals.isServerConnection = false;
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
      var prod = _order.firstWhere((element) => element["id"] == item["id"],
          orElse: () => {});
      if (!hasProd.isEmpty && hasProd["cnt"] != 0) {
        if ((prod["cnt"] - hasProd["cnt"]) <= cnt) {
          addToOrderChange(item, cnt: cnt - (item["cnt"] - hasProd["cnt"]));
          addToOrder(item, cnt: cnt);
          setState(() {
            totalSum = getTotal();
          });
        } else {
          print("fuck off");
        }
      } else {
        if (item["cnt"] <= cnt) {
          addToOrderChange(item, cnt: cnt - prod["cnt"]);
          addToOrder(item, cnt: cnt);
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

  Future<bool> checkPrint() async {
    try {
      var response = await connect
          .get('${globals.apiLink}/checkPrint/${widget.expenseId}');

      globals.isServerConnection = true;
      orderScreenState!.setState(() {});
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return false;
      }
    } catch (e) {
      globals.isServerConnection = false;
      return false;
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

  void getProdByCategory(id) async {
    _showReciept = false;
    _isSearch = false;

    try {
      Map<String, String> headers = {};
      var response = await connect.get('${globals.apiLink}/prod-list/$id');
      orderScreenState!.setState(() {});
      globals.isServerConnection = true;
      if (response.statusCode == 200) {
        _products = [];
        var menu = json.decode(response.body);
        if (menu["dish"].length != 0) {
          menu["dish"].forEach((val) {
            var temp = {
              "id": "dish_${val["id"]}",
              "name": val["name"],
              "price": val["price"],
              "image": null,
              "department_id": val["department_id"],
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
              "image": null,
              "department_id": val["department_id"],
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
              "image": null,
              "department_id": val["department_id"],
            };
            _products.add(temp);
          });
        }
        setState(() {});
        Navigator.of(context).pop();
      }
    } catch (e) {
      globals.isServerConnection = false;
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

  quit() {
    setState(() {
      globals.isLogin = false;
      globals.isOrder = false;
      globals.code = "";
    });
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext ctx) {
      return MainScreen();
    }), (route) => false);
  }

  void addToOrderChange(prod, {cnt = null}) {
    try {
      var item = _orderChange.firstWhere(
          (element) => element["id"] == prod["id"],
          orElse: () => {});

      if (item.isEmpty) {
        Map<String, dynamic> temp = {
          "id": "${prod["id"]}",
          "name": "${prod["name"]}",
          "price": prod["price"],
          "cnt": cnt == null ? 1 : cnt,
          "department_id": prod["department_id"],
        };
        setState(() {
          _orderChange.add(temp);
          totalSum = getTotal();
        });
      } else {
        setState(() {
          if (cnt == null)
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

  void addToOrder(prod, {cnt = null}) {
    try {
      var item = _order.firstWhere((element) => element["id"] == prod["id"],
          orElse: () => {});

      if (item.isEmpty) {
        Map<String, dynamic> temp = {
          "id": "${prod["id"]}",
          "name": "${prod["name"]}",
          "price": prod["price"],
          "cnt": cnt == null ? 1 : cnt,
          "department_id": prod["department_id"],
        };
        setState(() {
          _order.add(temp);
          totalSum = getTotal();
        });
      } else {
        setState(() {
          if (cnt == null)
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

  // sendPrint() async {
  //   try {
  //     Map<String, dynamic> data = {
  //       "table": widget.tableName,
  //       "emp": globals.userData!.name,
  //       "departments": globals.userData!.department,
  //       "data": _orderChange
  //     };
  //     var response = await connect.post('${globals.apiLink}/print', body: data);
  //     orderScreenState!.setState(() {});
  //     globals.isServerConnection = true;
  //     if (response.statusCode == 200) {
  //       var res = json.decode(response);
  //       // return json;
  //     }
  //   } catch (e) {
  //     globals.isServerConnection = false;
  //     print(e);
  //   }
  // }

  final Print prints = new Print();
  addProduct() async {
    try {
      if (!sendRequest) {
        sendRequest = true;
        var response;
        Map<String, String> headers = {};
        if (widget.expenseId == null) {
          Map<String, dynamic> data = {
            "table": widget.tableId,
            "employee_id": globals.userData!.id,
            "expSum": totalSum,
            "params": _orderChange,
            "all_prods": _order,
          };
          print(_orderChange);
          if (!_orderChange.isEmpty) {
            Map<String, dynamic> temp = {
              "table_name": widget.tableName,
              "employee_name": globals.userData!.name
            };

            response = await connect.post('${globals.apiLink}/create-order',
                body: data);
            orderScreenState!.setState(() {});
            globals.isServerConnection = true;
            if (response.statusCode == 200) {
              // sendPrint();

              // prints.testPrint("192.168.1.200", context, "check",
              //     {"expense": temp, "order": _orderChange});
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (BuildContext ctx) {
                return MainScreen();
              }), (route) => false);
            }
          } else {
            quit();
          }
        } else {
          Map<String, dynamic> data = {
            "table": widget.tableId,
            "employee_id": globals.userData!.id,
            "expSum": totalSum,
            "params": _orderChange,
            "all_prods": _order,
          };
          if (!_orderChange.isEmpty) {
            response = await connect.post(
                '${globals.apiLink}/update-order/${widget.expenseId}',
                body: data);
            if (response["statusCode"] == 200) {
              // sendPrint();
              // prints.testPrint("192.168.1.200", context, "check",
              //     {"expense": expense_data, "order": _orderChange});
              quit();
            }
          } else {
            quit();
          }
        }
      }
    } catch (e) {
      globals.isServerConnection = false;
      print(e);
      sendRequest = false;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Tabs(),
            MenuList(appbarSize: appbar.preferredSize.height),
            ExpenseCard(order: _order, appbarSize: appbar.preferredSize.height),
            _isSearch
                ? Search(
                    isSearch: _isSearch,
                    appbarSize: appbar.preferredSize.height)
                : Container(),
            OrderFooter(),
          ],
        ),
      ),
      drawer: CustomDrawer(),
    );
  }
}
