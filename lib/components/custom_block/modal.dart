import 'dart:async';

import 'package:flutter/material.dart';
import '../../config/globals.dart' as globals;

class Modal {
  Widget child;
  double heightIndex;
  BuildContext ctx;
  BuildContext? dialogContext;
  Modal({
    this.dialogContext,
    required this.ctx,
    required this.child,
    this.heightIndex = 0.6,
    Key? key,
  });
  var res;
  customDialog() {
    // BuildContext dialogContext;
    return showGeneralDialog(
        context: ctx,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(ctx).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          dialogContext = buildContext;
          return Center(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.white,
              ),
              width: MediaQuery.of(ctx).size.width,
              height: MediaQuery.of(ctx).size.height * heightIndex,
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(ctx).size.height * 0.03),
              child: child,
            ),
          );
        }).then((value) {
      res = value;
    });
  }

  Future modalDialog() async {
    // BuildContext dialogContext;
    return showGeneralDialog(
        context: ctx,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(ctx).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          dialogContext = buildContext;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.transparent,
            ),
            width: MediaQuery.of(ctx).size.width,
            // height: MediaQuery.of(ctx).size.height * 0.1,
            child: child,
          );
        }).then((value) {
      res = value;
    });
  }

  close() {
    Navigator.pop(dialogContext!, true);
  }

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
                                res = val;
                                Navigator.pop(ctx, val);
                              },
                              autofocus: true,
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
}
