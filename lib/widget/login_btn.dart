import 'package:flutter/material.dart';
import '../config/globals.dart' as globals;
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
    return Container(
      margin:
          EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),
      child: InkWell(
        onTap: () {
          if (img == null) {
            onTapBtn(txt);
          } else {
            onTapBtn();
          }
        },
        child: Container(
          width: 58,
          height: 59,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(2, 2), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            // border: Border.all(
            //   width: 1,
            //   color: globals.mainColor,
            // ),
          ),
          child: Center(
            child: img == null
                ? Text(
                    txt,
                    style: TextStyle(
                      color: globals.mainColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: globals.font,
                    ),
                  )
                : SvgPicture.asset(
                    img,
                    color: globals.secondaryColor,
                  ),
          ),
        ),
      ),
    );
  }
}
