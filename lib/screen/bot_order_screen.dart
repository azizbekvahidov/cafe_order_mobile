import 'package:cafe_mostbyte/bloc/app_status.dart';
import 'package:cafe_mostbyte/bloc/auth/authentificate.dart/authentificate_event.dart';
import 'package:cafe_mostbyte/bloc/auth/authentificate.dart/authentification_bloc.dart';
import 'package:cafe_mostbyte/bloc/auth/authentificate.dart/authentification_state.dart';
import 'package:cafe_mostbyte/bloc/bot_expense/bot_expense_bloc.dart';
import 'package:cafe_mostbyte/bloc/bot_expense/bot_expense_event.dart';
import 'package:cafe_mostbyte/bloc/bot_expense/bot_expense_repository.dart';
import 'package:cafe_mostbyte/bloc/bot_expense/bot_expense_state.dart';
import 'package:cafe_mostbyte/bloc/bot_order.dart/bot_order_bloc.dart';
import 'package:cafe_mostbyte/bloc/form_submission_status.dart';
import 'package:cafe_mostbyte/models/delivery_bot.dart';
import 'package:cafe_mostbyte/screen/auth/auth.dart';
import 'package:cafe_mostbyte/screen/moderator_screen.dart';
import 'package:cafe_mostbyte/screen/order_screen.dart';
import 'package:cafe_mostbyte/services/print_service.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../config/globals.dart' as globals;
import '../services/helper.dart' as helper;

class BotOrderScreen extends StatefulWidget {
  BotOrderScreen({Key? key}) : super(key: key);

  @override
  State<BotOrderScreen> createState() => _BotOrderScreenState();
}

class _BotOrderScreenState extends State<BotOrderScreen> {
  @override
  void initState() {
    super.initState();
    if (globals.userData!.role.role == 'moderator') {
      globals.filial = 0;
      globals.currentExpense = null;
      globals.currentExpenseSum = 0;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  PrintService print = new PrintService();
  @override
  Widget build(BuildContext context) {
    botOrderBloc.fetchApproveOrders(id: globals.filial);
    var dWidth = MediaQuery.of(context).size.width;
    var dHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
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
          },
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container(
                //   child: Text(
                //     widget.title!,
                //     style: TextStyle(
                //         fontFamily: globals.font,
                //         fontSize: 18,
                //         color: globals.mainColor),
                //   ),
                // ),
                Container(
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (BuildContext ctx) {
                            return globals.userData!.role.role == 'moderator'
                                ? ModeratorScreen()
                                : OrderScreen();
                          }), (route) => false);
                        },
                        child: Icon(
                          MaterialIcons.food_bank,
                          size: 40,
                        ),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                  ),
                                  Icon(MaterialCommunityIcons.lock_outline,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                      size: 35)
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
      ),
      body: RepositoryProvider(
        create: (context) => BotExpenseRepository(),
        child: BlocProvider(
          create: (context) =>
              BotExpenseBloc(repo: context.read<BotExpenseRepository>()),
          child: BlocListener<BotExpenseBloc, BotExpenseState>(
            listener: (context, state) async {
              var formStatus = state.formStatus;
              if (formStatus is SubmissionSuccess) {
                botOrderBloc.fetchApproveOrders(id: globals.filial);
                if (globals.currentExpense != null) {
                  if (globals.orderState != null) {
                    await print.checkPrint(
                        printData: globals.orderState,
                        order_type: globals.currentExpense!.order_type);
                    globals.orderState = null;
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (BuildContext ctx) {
                      return OrderScreen();
                    }), (route) => false);
                  } else {
                    if (globals.userData!.role.role == 'moderator') {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (BuildContext ctx) {
                        return ModeratorScreen();
                      }), (route) => false);
                    }
                  }
                }
                context.read<BotExpenseBloc>().add(BotExpenseInitialized());
              } else if (formStatus is SubmissionFailed) {
                helper.getToast("Что то пошло не так", context);
              }
            },
            child: StreamBuilder(
              stream: botOrderBloc.botOrderApproveList,
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  List expenses = snapshot.data as List;

                  return Container(
                    width: dWidth,
                    height: dHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          alignment: Alignment.topCenter,
                          width: dWidth,
                          child: Wrap(
                            children: [
                              for (DeliveryBot _expense in expenses)
                                InkWell(
                                  onTap: () async {
                                    if (globals.userData!.role.role ==
                                        'moderator') {
                                      context
                                          .read<BotExpenseBloc>()
                                          .add(AddData(data: _expense));
                                      context
                                          .read<BotExpenseBloc>()
                                          .add(AddExpense());
                                    } else {
                                      if (await confirm(context,
                                          content: Text("Добавить заказ?"),
                                          textCancel: Text("Нет"),
                                          textOK: Text("Да"),
                                          title: Text(""))) {
                                        context
                                            .read<BotExpenseBloc>()
                                            .add(AddData(data: _expense));
                                        context
                                            .read<BotExpenseBloc>()
                                            .add(AddToExpense());
                                      }
                                    }
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 2),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      width: dWidth * 0.21,
                                      height: 100,
                                      child: Center(
                                          child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Icon(
                                              (_expense.order_type == "booking")
                                                  ? Fontisto.shopping_store
                                                  : ((_expense.order_type ==
                                                          'take')
                                                      ? MaterialIcons.food_bank
                                                      : MaterialCommunityIcons
                                                          .truck_delivery),
                                              size: 20,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondaryContainer,
                                            ),
                                          ),
                                          Container(
                                            width: dWidth * 0.15,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Имя: ${_expense.name}",
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .indicatorColor,
                                                  ),
                                                ),
                                                Text(
                                                  "Телефон: ${_expense.phone}",
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .indicatorColor,
                                                  ),
                                                ),
                                                Text(
                                                  _expense.address != null
                                                      ? "Адрес: ${_expense.address}"
                                                      : "",
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .indicatorColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ))),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
