import 'package:cafe_mostbyte/components/custom_block/adding_btn.dart';
import 'package:cafe_mostbyte/components/custom_block/modal.dart';
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
                    onTap: () async {
                      var modal = Modal(
                          ctx: context,
                          child: AddingBtn(
                            data: widget.orderRow!,
                          ),
                          heightIndex: 0.3);
                      var res = await modal.customDialog();
                      // print(res.runtimeType);
                      // if (res != "0") {
                      //   setState(() {
                      //     var orderRow =
                      //         globals.currentExpense!.order.where((element) {
                      //       return element.product_id ==
                      //           widget.orderRow!.product_id;
                      //     });
                      //     if (orderRow.length != 0) {
                      //       orderRow.first.amount = double.parse(res);
                      //     }
                      //   });
                      // } else {
                      //   expenseCardPageState.setState(() {
                      //     globals.currentExpense!.order.removeWhere((element) {
                      //       return element.product_id ==
                      //           widget.orderRow!.product_id;
                      //     });
                      //   });
                      // }
                      helper.calculateTotalSum();
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
