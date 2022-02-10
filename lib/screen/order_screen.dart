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

import './mian_screen.dart';
import '../widget/custom_appbar.dart';
import '../components/order_row.dart';
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

  TextEditingController searchController = TextEditingController();
  bool _isSearch = false;
  void searchProd() {
    setState(() {
      _isSearch = !_isSearch;
    });
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
