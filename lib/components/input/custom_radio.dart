import 'dart:ui';

import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  final List<Map> data;
  String result;
  Function? onClick;
  CustomRadio({
    required this.data,
    required this.result,
    this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  bool _isClicked = false;

  void radioAction(index) {
    setState(() {
      widget.result = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.only(bottom: 24),
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 0.7,
          ),
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                  right: (index % 2 == 0) ? 8 : 0,
                  left: (index % 2 != 0) ? 8 : 0,
                  bottom: 16),
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.result == widget.data[index]["index"]
                              ? Theme.of(context).bottomAppBarColor
                              : Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: widget.result == widget.data[index]["index"]
                            ? Colors.white
                            : Theme.of(context).buttonColor,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600,
                          fontFeatures: [
                            FontFeature.enable("pnum"),
                            FontFeature.enable("lnum")
                          ],
                        ),
                      ),
                      onPressed: () {
                        widget.onClick!(widget.data[index]["index"]);
                        radioAction(widget.data[index]["index"]);
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        // width: dWidth,
                        child: Text(widget.data[index]["value"]),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
