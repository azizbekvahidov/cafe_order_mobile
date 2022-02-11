import 'package:auto_size_text/auto_size_text.dart';
import 'package:cafe_mostbyte/bloc/order/order_bloc.dart';
import 'package:cafe_mostbyte/components/order_footer.dart';
import 'package:cafe_mostbyte/models/expense.dart';
import 'package:cafe_mostbyte/models/order.dart';
import 'package:cafe_mostbyte/components/order_row.dart';
import 'package:flutter/material.dart';
import '../../config/globals.dart' as globals;

_ModeratorExpenseCardState moderatorExpenseCardPageState =
    _ModeratorExpenseCardState();

class ModeratorExpenseCard extends StatefulWidget {
  var appbarSize;
  ModeratorExpenseCard({required this.appbarSize, Key? key}) : super(key: key);

  @override
  _ModeratorExpenseCardState createState() {
    moderatorExpenseCardPageState = _ModeratorExpenseCardState();
    return moderatorExpenseCardPageState;
  }
}

class _ModeratorExpenseCardState extends State<ModeratorExpenseCard> {
  ScrollController _checkController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    return Positioned(
        top: 30,
        right: 0,
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(left: BorderSide(width: 1, color: Colors.black))),
          width: dWidth * 0.27,
          height: dHeight - widget.appbarSize - 200,
          child: SingleChildScrollView(
              controller: _checkController,
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
                    child: Column(
                      children: [
                        if (globals.currentExpense != null)
                          for (Order item in globals.currentExpense!.order)
                            OrderRow(
                              orderRow: item,
                              plus: () {}, //plusCnt,
                              minus: () {}, //minusCnt,
                              customVal: () {}, //setDefaultVal,
                            )
                      ],
                    ),
                  )
                ],
              )),
        ));
  }
}
