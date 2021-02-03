import 'package:flutter/material.dart';
import 'package:cafe_order/globals.dart' as globals;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';

class OrderRow extends StatefulWidget {
  Map orderRow;
  Function plus;
  Function minus;

  OrderRow({
    this.orderRow,
    this.plus,
    this.minus,
    Key key,
  }) : super(key: key);

  @override
  _OrderRowState createState() => _OrderRowState();
}

class _OrderRowState extends State<OrderRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 6,
                child: AutoSizeText(
                  "${widget.orderRow["name"]}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: globals.font,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "${widget.orderRow["price"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: globals.font,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => widget.minus(widget.orderRow),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                          child: SvgPicture.asset(
                            "assets/img/minus.svg",
                            height: 16,
                            color: globals.mainColor,
                          ),
                        ),
                      ),
                      Text(
                        "${widget.orderRow["cnt"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: globals.font,
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                        ),
                      ),
                      InkWell(
                        onTap: () => widget.plus(widget.orderRow),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                          child: SvgPicture.asset(
                            "assets/img/plus.svg",
                            height: 16,
                            color: globals.mainColor,
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 2,
                child: Text(
                  "${widget.orderRow["price"] * widget.orderRow["cnt"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: globals.font,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: globals.thirdColor,
          )
        ],
      ),
    );
  }
}
