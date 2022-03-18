import 'dart:ui';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SecondaryButton extends StatefulWidget {
  String text;
  Function() action;
  final Color? colour;
  SecondaryButton({
    required this.text,
    required this.action,
    @required this.colour,
    Key? key,
  }) : super(key: key);

  @override
  _SecondaryButtonState createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    var dWidth = MediaQuery.of(context).size.width;
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
              primary: Theme.of(context).backgroundColor,
              textStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
                fontFeatures: [
                  FontFeature.enable("pnum"),
                  FontFeature.enable("lnum")
                ],
              ),
            ),
            onPressed: widget.action,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              width: dWidth,
              child: Text(widget.text),
            ),
          ),
        ],
      ),
    );
  }
}
