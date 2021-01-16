import 'package:flutter/material.dart';
import 'package:cafe_order/globals.dart' as globals;
import 'package:flutter_svg/svg.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Color backgroundColor;
  final Color textColor;
  CustomAppbar(
      {this.title,
      this.centerTitle,
      this.backgroundColor,
      this.textColor,
      Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppbarState createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            globals.isLogin ? Container() : Container(),
            Row(
              children: [
                globals.isLogin
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            globals.isLogin = false;
                            globals.code = "";
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              globals.authName,
                              style: TextStyle(
                                  fontFamily: globals.font,
                                  fontSize: 28,
                                  color: Colors.white),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                            ),
                            SvgPicture.asset("assets/img/lock.svg")
                          ],
                        ),
                      )
                    : Container(),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: globals.thirdColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(11),
                      color: Color(0xff29FF3F)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
