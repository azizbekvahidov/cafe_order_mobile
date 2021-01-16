import 'package:flutter/material.dart';
import 'package:cafe_order/globals.dart' as globals;
import 'package:flutter_svg/svg.dart';

class LoginBtn extends StatelessWidget {
  final String txt;
  final Color color;
  final double top;
  final double bottom;
  final double left;
  final double right;
  final img;
  final Function onTapBtn;

  const LoginBtn(
      {this.onTapBtn,
      this.img,
      this.top = 0,
      this.bottom = 0,
      this.left = 0,
      this.right = 0,
      this.color,
      this.txt,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (img == null) {
          onTapBtn(txt);
        } else {
          onTapBtn();
        }
      },
      child: Container(
        margin:
            EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),
        width: 58,
        height: 59,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: img == null
              ? Text(
                  txt,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: globals.font,
                  ),
                )
              : SvgPicture.asset(img),
        ),
      ),
    );
  }
}
