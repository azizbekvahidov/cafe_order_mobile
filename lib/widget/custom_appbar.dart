import '../screen/mian_screen.dart';
// import './network_status.dart';
import 'package:flutter/material.dart';
import '../config/globals.dart' as globals;
import 'package:flutter_svg/svg.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool? centerTitle;
  final Color? backgroundColor;
  final Color? textColor;
  Function? searchFunc;
  CustomAppbar(
      {this.title = "",
      this.centerTitle,
      this.backgroundColor,
      this.textColor,
      this.searchFunc,
      Key? key})
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
    print(globals.isServerConnection);
    return AppBar(
      elevation: 1,
      iconTheme: IconThemeData(color: globals.mainColor),
      backgroundColor: Colors.white,
      title: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            globals.isOrder
                ? InkWell(
                    onTap: () => widget.searchFunc!(),
                    child: Container(
                      child: SvgPicture.asset(
                        "assets/img/loupe.svg",
                        color: globals.mainColor,
                      ),
                    ),
                  )
                : Container(),
            Container(
              child: Text(
                widget.title!,
                style: TextStyle(
                    fontFamily: globals.font,
                    fontSize: 18,
                    color: globals.mainColor),
              ),
            ),
            Row(
              children: [
                globals.isLogin
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            globals.isLogin = false;
                            globals.isOrder = false;
                            globals.code = "";
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (BuildContext ctx) {
                              return MainScreen();
                            }), (route) => false);
                          });
                        },
                        child: Row(
                          children: [
                            Text(globals.userData!.name,
                                style: Theme.of(context).textTheme.bodyText1),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                            ),
                            SvgPicture.asset(
                              "assets/img/lock.svg",
                              color: globals.mainColor,
                            )
                          ],
                        ),
                      )
                    : Container(),
                globals.isServerConnection
                    ? Container(
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
                      )
                    : Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: globals.thirdColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(11),
                            color: Colors.red),
                      ),

                // Container(
                //   margin: EdgeInsets.only(left: 10),
                //   width: 16,
                //   height: 16,
                //   decoration: BoxDecoration(
                //       border: Border.all(
                //         color: globals.thirdColor,
                //         width: 1,
                //       ),
                //       borderRadius: BorderRadius.circular(11),
                //       color: Color(0xff29FF3F)),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
