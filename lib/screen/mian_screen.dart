import './table_screen.dart';
import '../widget/custon_appbar.dart';
import '../widget/login_btn.dart';
import '../globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:requests/requests.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool firstCircle = false;
  bool secondCircle = false;
  bool thirdCircle = false;
  bool fourthCircle = false;
  String code = "";

  checkCode() {
    if (globals.code.length == 0) {
      setState(() {
        firstCircle = false;
        secondCircle = false;
        thirdCircle = false;
        fourthCircle = false;
      });
    } else if (globals.code.length == 1) {
      setState(() {
        firstCircle = true;
        secondCircle = false;
        thirdCircle = false;
        fourthCircle = false;
      });
    } else if (globals.code.length == 2) {
      setState(() {
        firstCircle = true;
        secondCircle = true;
        thirdCircle = false;
        fourthCircle = false;
      });
    } else if (globals.code.length == 3) {
      setState(() {
        firstCircle = true;
        secondCircle = true;
        thirdCircle = true;
        fourthCircle = false;
      });
    } else if (globals.code.length == 4) {
      setState(() {
        firstCircle = true;
        secondCircle = true;
        thirdCircle = true;
        fourthCircle = true;
      });
      singin();
    }
  }

  getTable() async {
    try {
      var url = '${globals.apiLink}tables';
      var response = await Requests.get(
        url,
      );
      if (response.statusCode == 200) {
        globals.tables = response.json();
      } else {
        dynamic json = response.json();
      }
      url = '${globals.apiLink}department';
      response = await Requests.get(
        url,
      );
      if (response.statusCode == 200) {
        globals.department = response.json();
      } else {
        dynamic json = response.json();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    getTable();
  }

  singin() async {
    try {
      Map body = {
        "pass": globals.code,
      };
      var res = await Requests.post(globals.apiLink + "login", body: body);
      if (res.statusCode == 200) {
        globals.userData = res.json();
        globals.code = "";
        globals.isLogin = true;
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext ctx) {
          return TableScreen();
        }));
      } else if (res.statusCode == 204) {
        clearCode();
      } else {
        clearCode();
      }
    } catch (e) {
      clearCode();
    }
  }

  addCode(String index) {
    if (globals.code.length != 4) {
      globals.code += index;
    }
    checkCode();
  }

  clearCode() {
    globals.code = "";
    checkCode();
  }

  deleteCode() {
    globals.code = globals.code.substring(0, globals.code.length - 1);
    checkCode();
  }

  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    var appbar = CustomAppbar();
    return Scaffold(
      appBar: appbar,
      body: Container(
        height: dHeight - appbar.preferredSize.height,
        width: dWidth,
        alignment: Alignment.center,
        child: Center(
            child: Container(
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.only(top: 20),
                  child: SvgPicture.asset(
                    "assets/img/logo-cafe.svg",
                    height: 100,
                  )),
              Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(2, 2), // changes position of shadow
                            ),
                          ],
                          // border: Border.all(
                          //   color: globals.thirdColor,
                          //   width: 1,
                          // ),
                          borderRadius: BorderRadius.circular(11),
                          color:
                              firstCircle ? globals.thirdColor : Colors.white),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(2, 2), // changes position of shadow
                            ),
                          ],
                          // border: Border.all(
                          //   color: globals.thirdColor,
                          //   width: 1,
                          // ),
                          borderRadius: BorderRadius.circular(11),
                          color:
                              secondCircle ? globals.thirdColor : Colors.white),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(2, 2), // changes position of shadow
                            ),
                          ],
                          // border: Border.all(
                          //   color: globals.thirdColor,
                          //   width: 1,
                          // ),
                          borderRadius: BorderRadius.circular(11),
                          color:
                              thirdCircle ? globals.thirdColor : Colors.white),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(2, 2), // changes position of shadow
                            ),
                          ],
                          // border: Border.all(
                          //   color: globals.thirdColor,
                          //   width: 1,
                          // ),
                          borderRadius: BorderRadius.circular(11),
                          color:
                              fourthCircle ? globals.thirdColor : Colors.white),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginBtn(
                    onTapBtn: addCode,
                    txt: "1",
                    color: globals.mainColor,
                  ),
                  LoginBtn(
                    onTapBtn: addCode,
                    txt: "2",
                    color: globals.mainColor,
                    left: 22,
                  ),
                  LoginBtn(
                    onTapBtn: addCode,
                    txt: "3",
                    color: globals.mainColor,
                    left: 22,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginBtn(
                    onTapBtn: addCode,
                    txt: "4",
                    color: globals.mainColor,
                    top: 16,
                  ),
                  LoginBtn(
                    onTapBtn: addCode,
                    txt: "5",
                    color: globals.mainColor,
                    left: 22,
                    top: 16,
                  ),
                  LoginBtn(
                    onTapBtn: addCode,
                    txt: "6",
                    color: globals.mainColor,
                    left: 22,
                    top: 16,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginBtn(
                    onTapBtn: addCode,
                    txt: "7",
                    color: globals.mainColor,
                    top: 16,
                  ),
                  LoginBtn(
                    onTapBtn: addCode,
                    txt: "8",
                    color: globals.mainColor,
                    left: 22,
                    top: 16,
                  ),
                  LoginBtn(
                    onTapBtn: addCode,
                    txt: "9",
                    color: globals.mainColor,
                    left: 22,
                    top: 16,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginBtn(
                    onTapBtn: clearCode,
                    img: "assets/img/bin.svg",
                    color: globals.secondaryColor,
                    top: 16,
                  ),
                  LoginBtn(
                    onTapBtn: addCode,
                    txt: "0",
                    color: globals.mainColor,
                    left: 22,
                    top: 16,
                  ),
                  LoginBtn(
                    onTapBtn: deleteCode,
                    img: "assets/img/clear.svg",
                    color: globals.secondaryColor,
                    left: 22,
                    top: 16,
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
