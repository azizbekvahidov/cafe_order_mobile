import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../config/globals.dart' as globals;

class ProductCard extends StatelessWidget {
  final product;
  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(left: 10, bottom: 10),
      child: InkWell(
        onTap: () {
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
                      fit: product["product"]["image"] != null
                          ? BoxFit.cover
                          : BoxFit.contain,
                      child: product["product"]["image"] != null
                          ? Image.network(product["product"]["image"])
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
                        product["product"]["name_uz"],
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
                            "${product["product"]["price"]}",
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
