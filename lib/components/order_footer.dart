import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../config/globals.dart' as globals;

_OrderFooterState orderFooterPageState = _OrderFooterState();

class OrderFooter extends StatefulWidget {
  OrderFooter({Key? key}) : super(key: key);

  @override
  _OrderFooterState createState() {
    orderFooterPageState = _OrderFooterState();
    return orderFooterPageState;
  }
}

class _OrderFooterState extends State<OrderFooter> {
  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    return Positioned(
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
                  Row(children: [
                    AutoSizeText(
                      "Итого: ",
                      style: TextStyle(
                        fontFamily: globals.font,
                        fontSize: 20,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    AutoSizeText(
                      "${globals.currentExpenseSum}",
                      style: TextStyle(
                        fontFamily: globals.font,
                        fontSize: 24,
                      ),
                    ),
                  ]),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // addProduct();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                    onTap: () async {
                      // var res = await checkPrint();
                      // if (res == true) {
                      //   prints.testPrint(
                      //       globals.settings!.printer,
                      //       context,
                      //       "reciept",
                      //       {"expense": expense_data, "order": _order});
                      // } else {
                      //   print("no print enymore");
                      // }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        ),
                        color: globals.fourthColor,
                      ),
                      child: Row(
                        children: [SvgPicture.asset("assets/img/print.svg")],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
