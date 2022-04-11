import 'package:auto_size_text/auto_size_text.dart';
import 'package:cafe_mostbyte/components/expense_card.dart';
import 'package:cafe_mostbyte/components/moderator/moderator_expense_card.dart';
import 'package:cafe_mostbyte/components/tabs.dart';
import 'package:cafe_mostbyte/models/menu_item.dart';
import 'package:cafe_mostbyte/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../config/globals.dart' as globals;
import '../services/helper.dart' as helper;

class ProductCard extends StatelessWidget {
  MenuItem data;
  ProductCard({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      child: InkWell(
        onTap: () {
          if (globals.currentExpense != null) {
            if (expenseCardPageState.mounted)
              expenseCardPageState.setState(() {
                Order order =
                    globals.currentExpense!.order.firstWhere((element) {
                  return element.product_id == data.product.id &&
                      element.type == data.type;
                }, orElse: () {
                  return Order(
                    amount: 0,
                    product_id: data.product.id,
                    type: data.type,
                    product: data.product,
                  );
                });
                if (order.amount == 0) {
                  order.amount += 1;
                  globals.currentExpense!.order.add(order);
                } else {
                  order.amount += 1;
                }
                tabsState.setState(() {
                  globals.currentExpenseChange = true;
                });
              });
            if (moderatorExpenseCardPageState.mounted)
              moderatorExpenseCardPageState.setState(() {
                Order order =
                    globals.currentExpense!.order.firstWhere((element) {
                  return element.product_id == data.product.id &&
                      element.type == data.type;
                }, orElse: () {
                  return Order(
                    amount: 0,
                    product_id: data.product.id,
                    type: data.type,
                    product: data.product,
                  );
                });
                if (order.amount == 0) {
                  order.amount += 1;
                  globals.currentExpense!.order.add(order);
                } else {
                  order.amount += 1;
                }
              });
            helper.generateCheck(
                data: data.product, type: data.type, amount: 1);

            helper.calculateTotalSum();
          } else {
            helper.getToast("Выберите или создайте счет", context);
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: dWidth * 0.13,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: globals.mainColor)),
              // border: Border.all(width: 1, color: Colors.black),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: globals.fourthColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        border: Border.all(
                          color: globals.fourthColor,
                          width: 1,
                        )),
                    height: dHeight * 0.2,
                    width: dWidth * 0.185,
                    // color: Colors.grey,
                    child: FittedBox(
                        alignment: Alignment(10, 0),
                        fit: data.product.image != null
                            ? BoxFit.fitWidth
                            : BoxFit.contain,
                        child: data.product.image != null
                            ? Image.network(data.product.image!)
                            : Icon(
                                MaterialCommunityIcons.image_off_outline,
                                size: 40,
                                color: globals.thirdColor,
                              )),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: dWidth / 2 / 1.6 - (dWidth / 2 / 1.6 - 40),
                  width: dWidth / 2 - 20,
                  child: AutoSizeText(
                    data.product.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: globals.font,
                      fontSize: 7,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: globals.mainColor,
                      ),
                      child: Center(
                        child: AutoSizeText(
                          "${data.product.price}",
                          style: TextStyle(
                            fontFamily: globals.font,
                            color: globals.fourthColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
