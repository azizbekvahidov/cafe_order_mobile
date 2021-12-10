import 'package:auto_size_text/auto_size_text.dart';
import 'package:cafe_mostbyte/components/expense_card.dart';
import 'package:cafe_mostbyte/models/menu_item.dart';
import 'package:cafe_mostbyte/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../config/globals.dart' as globals;

class ProductCard extends StatelessWidget {
  MenuItem data;
  ProductCard({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(left: 10, bottom: 10),
      child: InkWell(
        onTap: () {
          expenseCardPageState.setState(() {
            var orderRow = globals.currentExpense!.order.where((element) {
              return element.product_id == data.product.id;
            });
            if (orderRow.length != 0) {
              orderRow.first.amount += 1;
            } else {
              Order newOrderRow = Order(
                amount: 1,
                product_id: data.product.id,
                type: data.type,
                product: data.product,
              );
              globals.currentExpense!.order.add(newOrderRow);
            }
          });
          // addToOrder(product);
          // addToOrderChange(product);
        },
        child: Container(
          width: dWidth * 0.13,
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 1, color: globals.mainColor))
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
                  height: 100,
                  width: dWidth * 0.185,
                  // color: Colors.grey,
                  child: FittedBox(
                      fit: data.product.image != null
                          ? BoxFit.cover
                          : BoxFit.contain,
                      child: data.product.image != null
                          ? Image.network(data.product.image!)
                          : SvgPicture.asset(
                              "assets/img/no-photo.svg",
                              height: 40,
                              color: globals.thirdColor,
                            )),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: Container(
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
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
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
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
