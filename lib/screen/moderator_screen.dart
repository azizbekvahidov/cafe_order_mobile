import 'package:cafe_mostbyte/bloc/order/order_bloc.dart';
import 'package:cafe_mostbyte/components/custom_block/custom_drawer.dart';
import 'package:cafe_mostbyte/components/expense_card.dart';
import 'package:cafe_mostbyte/components/menu_list.dart';
import 'package:cafe_mostbyte/components/moderator/moderator_expense_card.dart';
import 'package:cafe_mostbyte/components/moderator/moderator_footer.dart';
import 'package:cafe_mostbyte/components/moderator/moderator_head.dart';
import 'package:cafe_mostbyte/components/order_footer.dart';
import 'package:cafe_mostbyte/components/search.dart';
import 'package:cafe_mostbyte/components/tabs.dart';
import 'package:cafe_mostbyte/widget/custom_appbar.dart';
import "package:flutter/material.dart";
import '../config/globals.dart' as globals;

class ModeratorScreen extends StatefulWidget {
  ModeratorScreen({Key? key}) : super(key: key);

  @override
  State<ModeratorScreen> createState() => _ModeratorScreenState();
}

class _ModeratorScreenState extends State<ModeratorScreen> {
  bool _isSearch = false;
  void searchProd() {
    setState(() {
      _isSearch = !_isSearch;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await orderBloc.fetchCategory();
    await orderBloc.fetchExpenses(id: globals.filial);
  }

  List<dynamic> _order = [];
  @override
  Widget build(BuildContext context) {
    var appbar = CustomAppbar(
        // searchFunc: searchProd,
        );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Stack(
          children: [
            ModeratorHead(),
            MenuList(appbarSize: appbar.preferredSize.height),
            ModeratorExpenseCard(
                order: _order, appbarSize: appbar.preferredSize.height),
            _isSearch
                ? Search(
                    isSearch: _isSearch,
                    appbarSize: appbar.preferredSize.height)
                : Container(),
            ModeratorFooter(),
          ],
        ),
      ),
      drawer: CustomDrawer(),
    );
  }
}
