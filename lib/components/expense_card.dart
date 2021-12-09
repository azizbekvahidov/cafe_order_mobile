import 'package:auto_size_text/auto_size_text.dart';
import 'package:cafe_mostbyte/widget/order_row.dart';
import 'package:flutter/material.dart';
import '../config/globals.dart' as globals;

class ExpenseCard extends StatefulWidget {
  List order;
  ExpenseCard({required this.order, Key? key}) : super(key: key);

  @override
  _ExpenseCardState createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    return Column(
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
            // height: dHeight - appbar.preferredSize.height - 235,
            child: Container()
            // ListView.builder(
            //     itemCount: widget.order.length,
            //     itemBuilder: (content, index) {
            //       return OrderRow(
            //         orderRow: widget.order[index],
            //         plus: () {}, //plusCnt,
            //         minus: () {}, //minusCnt,
            //         customVal: () {}, //setDefaultVal,
            //       );
            //     }),
            )
      ],
    );
  }
}
