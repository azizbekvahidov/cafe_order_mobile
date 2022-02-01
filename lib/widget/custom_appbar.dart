import 'package:cafe_mostbyte/bloc/app_status.dart';
import 'package:cafe_mostbyte/bloc/auth/authentificate.dart/authentificate_event.dart';
import 'package:cafe_mostbyte/bloc/auth/authentificate.dart/authentification_bloc.dart';
import 'package:cafe_mostbyte/bloc/auth/authentificate.dart/authentification_state.dart';
import 'package:cafe_mostbyte/components/custom_block/modal.dart';
import 'package:cafe_mostbyte/screen/auth/auth.dart';
import 'package:cafe_mostbyte/screen/bot_order_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return AppBar(
      elevation: 1,
      iconTheme: IconThemeData(color: globals.mainColor),
      backgroundColor: Colors.white,
      title: BlocListener<AuthenticationBloc, AuthentifacionState>(
        listener: (context, state) {
          var appStatus = state.appStatus;
          if (appStatus is AppLoggedOutStatus) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (BuildContext ctx) {
              return Auth();
            }), (route) => true);
          }
          // TODO: implement listener
        },
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => widget.searchFunc!(),
                child: Container(
                  child: SvgPicture.asset(
                    "assets/img/loupe.svg",
                    color: globals.mainColor,
                  ),
                ),
              ),
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
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (BuildContext ctx) {
                          return BotOrderScreen();
                        }));
                        // var modal = Modal(
                        //     ctx: context,
                        //     child: DeliveryBotModal(),
                        //     heightIndex: 0.8);
                        // await modal.customDialog();
                        // if (modal.res) {
                        //   // context
                        //   //     .read<ExpenseBloc>()
                        //   //     .add(ExpenseTakeaway());
                        // }
                      },
                      child: SvgPicture.asset(
                        "assets/img/chatbot.svg",
                        height: 40,
                      ),
                    ),
                    Positioned(
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
                  ],
                ),
              ),
              Row(
                children: [
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
                                SvgPicture.asset(
                                  "assets/img/lock.svg",
                                  color: globals.mainColor,
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
