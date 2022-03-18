import 'dart:ui';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainButton extends StatefulWidget {
  String text;
  Function() action;
  final Color colour;
  final Color? textColor;
  MainButton({
    required this.text,
    required this.action,
    required this.colour,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  _MainButtonState createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: widget.colour,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: widget.textColor ?? Colors.white,
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
            onPressed: widget.action,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              alignment: Alignment.center,
              // width: dWidth,
              child: Text(widget.text),
            ),
          ),
        ],
      ),
    );
  }
}
