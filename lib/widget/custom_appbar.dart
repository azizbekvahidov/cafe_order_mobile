import 'dart:async';

import 'package:cafe_mostbyte/bloc/app_status.dart';
import 'package:cafe_mostbyte/bloc/auth/authentificate.dart/authentificate_event.dart';
import 'package:cafe_mostbyte/bloc/auth/authentificate.dart/authentification_bloc.dart';
import 'package:cafe_mostbyte/bloc/auth/authentificate.dart/authentification_state.dart';
import 'package:cafe_mostbyte/bloc/bot_order.dart/bot_order_bloc.dart';
import 'package:cafe_mostbyte/screen/auth/auth.dart';
import 'package:cafe_mostbyte/screen/bot_order_screen.dart';
import 'package:cafe_mostbyte/services/print_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

// import './network_status.dart';
import 'package:flutter/material.dart';
import '../config/globals.dart' as globals;
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
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
  PrintService print = new PrintService();
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      // do something or call a function
      botOrderBloc.fetchBotOrders(id: globals.filial);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    botOrderBloc.fetchBotOrders(id: globals.filial);
    return BlocListener<AuthenticationBloc, AuthentifacionState>(
      listener: (context, state) async {
        var appStatus = state.appStatus;
        if (appStatus is AppLoggedOutStatus) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext ctx) {
            return Auth();
          }), (route) => true);
          globals.currentExpenseSum = 0;
          globals.currentExpense = null;
        }
        if (state.appStatus is ChangeClosed) {
          Future.delayed(Duration(milliseconds: 2250)).then((_) async {
            await print.changePrint();
            globals.tempChange = null;
            globals.tempChangeSum = null;
            return null;
          });
        }
      },
      child: AppBar(
        actions: [
          BlocBuilder<AuthenticationBloc, AuthentifacionState>(
              builder: (context, state) {
            return PopupMenuButton<int>(
                itemBuilder: (context) => [
                      // PopupMenuItem<int>(
                      //   onTap: () async {
                      //     context.read<AuthenticationBloc>().add(GetChange());
                      //     Future.delayed(Duration(milliseconds: 2250))
                      //         .then((_) async {
                      //       await print.changePrint();

                      //       return null;
                      //     });
                      //   },
                      //   value: 0,
                      //   child: Text("Распечатать смену"),
                      // ),
                      PopupMenuItem<int>(
                          onTap: () {
                            context
                                .read<AuthenticationBloc>()
                                .add(CloseChange());
                            context.read<AuthenticationBloc>().add(LoggedOut());
                          },
                          value: 0,
                          child: Text("Закрыть смену"))
                    ]);
          })
        ],
        elevation: 1,
        iconTheme: IconThemeData(color: globals.mainColor),
        backgroundColor: Colors.white,
        title: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // InkWell(
              //   onTap: () => widget.searchFunc!(),
              //   child: Container(
              //     child: new Icon(
              //       MaterialCommunityIcons.text_box_search_outline,
              //       // FontAwesomeIcons.search,
              //       size: 35,
              //     ),
              //     // SvgPicture.asset(
              //     //   "assets/img/loupe.svg",
              //     //   color: globals.mainColor,
              //     // ),
              //   ),
              // ),
              Container(
                child: Text(
                  widget.title!,
                  style: TextStyle(
                      fontFamily: globals.font,
                      fontSize: 18,
                      color: globals.mainColor),
                ),
              ),
              Container(
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        globals.currentExpense = null;
                        globals.orderState = null;
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (BuildContext ctx) {
                          return BotOrderScreen();
                        }));
                        _timer!.cancel();
                      },
                      child: Icon(MaterialCommunityIcons.robot, size: 35),
                      //     SvgPicture.asset(
                      //   "assets/img/chatbot.svg",
                      //   height: 40,
                      // ),
                    ),
                    StreamBuilder(
                      stream: botOrderBloc.botOrderList,
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData) {
                          List botOrder = snapshot.data as List;

                          return (botOrder.length != 0)
                              ? Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ))
                              : Container();
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: InkWell(
                      child: Icon(
                        MaterialCommunityIcons.restart,
                        size: 40,
                      ),
                      onTap: () {
                        Phoenix.rebirth(context);
                      },
                    ),
                  ),
                  globals.isAuth
                      ? BlocBuilder<AuthenticationBloc, AuthentifacionState>(
                          builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                context
                                    .read<AuthenticationBloc>()
                                    .add(LoggedOut());
                              });
                            },
                            child: Row(
                              children: [
                                Text(globals.userData!.name,
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                ),
                                Icon(
                                  MaterialCommunityIcons.lock_outline,
                                  size: 35,
                                )
                              ],
                            ),
                          );
                        })
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
      ),
    );
  }
}
