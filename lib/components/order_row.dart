import 'package:cafe_mostbyte/components/expense_card.dart';
import 'package:cafe_mostbyte/models/order.dart';
import 'package:flutter/material.dart';
import '../config/globals.dart' as globals;
import 'package:auto_size_text/auto_size_text.dart';
import '../services/helper.dart' as helper;

class OrderRow extends StatefulWidget {
  Order? orderRow;
  Function? plus;
  Function? minus;
  Function? customVal;

  OrderRow({
    this.orderRow,
    this.plus,
    this.minus,
    this.customVal,
    Key? key,
  }) : super(key: key);

  @override
  _OrderRowState createState() => _OrderRowState();
}

class _OrderRowState extends State<OrderRow> {
  TextEditingController cntController = new TextEditingController();
  customValDialog(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var dWidth = MediaQuery.of(context).size.width;
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Container(
            padding: EdgeInsets.only(
                top: 100, left: dWidth * 0.2, right: dWidth * 0.2),
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              width: MediaQuery.of(context).size.width,
              height: 50, //MediaQuery.of(context).size.height * 0.5,
              child: Container(
                padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                // width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Color(0xffF5F6F9),
                  borderRadius: BorderRadius.circular(22.5),
                  border: Border.all(
                    color: Color.fromRGBO(178, 183, 208, 0.5),
                    style: BorderStyle.solid,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    FocusScope(
                      child: Focus(
                        onFocusChange: (focus) {
                          // widget.streetNode.requestFocus();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: (mediaQuery.size.width -
                                  mediaQuery.padding.left -
                                  mediaQuery.padding.right) *
                              0.5,
                          margin: EdgeInsets.only(top: 20),
                          child: Scaffold(
                            backgroundColor: Colors.transparent,
                            body: TextField(
                              onSubmitted: (val) {
                                setState(() {
                                  var orderRow = globals.currentExpense!.order
                                      .where((element) {
                                    return element.product_id ==
                                        widget.orderRow!.product_id;
                                  });
                                  if (orderRow.length != 0) {
                                    orderRow.first.amount =
                                        double.parse(cntController.text);
                                  }
                                });
                                cntController.text = "";
                                Navigator.pop(context);
                              },
                              autofocus: true,
                              controller: cntController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration.collapsed(
                                hintText: "",
                                hintStyle: TextStyle(
                                    fontFamily: globals.font, fontSize: 28),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        expenseCardPageState.setState(() {
                          globals.currentExpense!.order.removeWhere((element) =>
                              element.product_id ==
                                  widget.orderRow!.product_id &&
                              element.type == widget.orderRow!.type);
                        });

                        var orderState = globals.orderState.where((element) {
                          return element.product_id ==
                                  widget.orderRow!.product.id &&
                              element.type == widget.orderRow!.type;
                        });
                        if (orderState.length != 0) {
                          orderState.first.amount = widget.orderRow!.amount *
                              -orderState.first.amount;
                        } else {
                          Order newOrder = Order(
                            amount: widget.orderRow!.amount * -1,
                            product_id: widget.orderRow!.product.id,
                            type: widget.orderRow!.type,
                            product: widget.orderRow!.product,
                          );
                          globals.orderState.add(newOrder);
                        }
                        helper.calculateTotalSum();
                      },
                      child: Center(
                        child: Icon(
                          Icons.close,
                          color: Theme.of(context).indicatorColor,
                        ),
                      ),
                    ),
                    AutoSizeText(
                      "${widget.orderRow!.product.name}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: globals.font,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "${widget.orderRow!.product.price}",
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
                  child: InkWell(
                    onTap: () {
                      // customValDialog(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // InkWell(
                        //   onTap: () => widget.minus(widget.orderRow),
                        //   child: Container(
                        //     padding:
                        //         EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                        //     child: SvgPicture.asset(
                        //       "assets/img/minus.svg",
                        //       height: 16,
                        //       color: globals.mainColor,
                        //     ),
                        //   ),
                        // ),
                        Text(
                          "${widget.orderRow!.amount}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: globals.font,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                        // InkWell(
                        //   onTap: () => widget.plus(widget.orderRow),
                        //   child: Container(
                        //     padding:
                        //         EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                        //     child: SvgPicture.asset(
                        //       "assets/img/plus.svg",
                        //       height: 16,
                        //       color: globals.mainColor,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 2,
                child: Text(
                  "${widget.orderRow!.product.price * widget.orderRow!.amount}",
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
