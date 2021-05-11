import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';

class OrderRow extends StatefulWidget {
  Map orderRow;
  Function plus;
  Function minus;
  Function customVal;

  OrderRow({
    this.orderRow,
    this.plus,
    this.minus,
    this.customVal,
    Key key,
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
            padding: EdgeInsets.only(top: 100, left: 20, right: 20),
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              width: MediaQuery.of(context).size.width,
              height: 50, //MediaQuery.of(context).size.height * 0.5,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
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
                          width: (mediaQuery.size.width -
                                  mediaQuery.padding.left -
                                  mediaQuery.padding.right) *
                              0.74,
                          margin: EdgeInsets.only(top: 20),
                          child: Scaffold(
                            backgroundColor: Colors.transparent,
                            body: TextField(
                              onSubmitted: (val) {
                                widget.customVal(
                                    widget.orderRow, double.parse(val));
                                Navigator.of(context).pop();
                                cntController.text = "";
                              },
                              autofocus: true,
                              controller: cntController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration.collapsed(
                                hintText: "",
                                hintStyle: TextStyle(
                                    fontFamily: globals.font, fontSize: 18),
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
                  child: InkWell(
                    onTap: () {
                      customValDialog(context);
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
                          "${widget.orderRow["cnt"]}",
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
