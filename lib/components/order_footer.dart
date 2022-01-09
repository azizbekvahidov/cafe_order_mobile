import 'package:auto_size_text/auto_size_text.dart';
import 'package:cafe_mostbyte/bloc/expense/expense_bloc.dart';
import 'package:cafe_mostbyte/bloc/expense/expense_event.dart';
import 'package:cafe_mostbyte/bloc/expense/expense_repository.dart';
import 'package:cafe_mostbyte/bloc/expense/expense_state.dart';
import 'package:cafe_mostbyte/bloc/form_submission_status.dart';
import 'package:cafe_mostbyte/bloc/order/order_bloc.dart';
import 'package:cafe_mostbyte/components/button/main_button.dart';
import 'package:cafe_mostbyte/components/custom_block/avans_modal.dart';
import 'package:cafe_mostbyte/components/custom_block/debt_modal.dart';
import 'package:cafe_mostbyte/components/custom_block/modal.dart';
import 'package:cafe_mostbyte/components/custom_block/terminal_modal.dart';
import 'package:cafe_mostbyte/components/expense_card.dart';
import 'package:cafe_mostbyte/services/print_service.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../config/globals.dart' as globals;
import '../services/helper.dart' as helper;

_OrderFooterState orderFooterPageState = _OrderFooterState();

class OrderFooter extends StatefulWidget {
  OrderFooter({Key? key}) : super(key: key);

  @override
  _OrderFooterState createState() {
    orderFooterPageState = _OrderFooterState();
    return orderFooterPageState;
  }
}

class _OrderFooterState extends State<OrderFooter> {
  PrintService print = new PrintService();
  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    return RepositoryProvider(
      create: (context) => ExpenseRepository(),
      child: BlocProvider(
        create: (context) =>
            ExpenseBloc(repo: context.read<ExpenseRepository>()),
        child: BlocListener<ExpenseBloc, ExpenseState>(
          listener: (context, state) async {
            var formStatus = state.formStatus;
            if (formStatus is SubmissionSuccess) {
              orderBloc.fetchExpenses(id: globals.filial);
              orderBloc.fetchExpense(id: globals.currentExpenseId);

              if (globals.orderState != null) {
                await print.startPrinter(printData: globals.orderState);
                globals.orderState = null;
              }
              expenseCardPageState.setState(() {});
              orderFooterPageState.setState(() {});
              context.read<ExpenseBloc>().add(ExpenseInitialized());
            } else if (formStatus is SubmissionFailed) {
              helper.getToast("Что то пошло не так", context);
            }
            // TODO: implement listener
          },
          child: Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(bottom: 5),
                width: dWidth - 40,
                child: Column(
                  children: [
                    Divider(
                      endIndent: 0,
                      indent: 0,
                      thickness: 1,
                      height: 10,
                      color: globals.mainColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BlocBuilder<ExpenseBloc, ExpenseState>(
                          builder: (context, state) {
                            return InkWell(
                              onTap: () {
                                context
                                    .read<ExpenseBloc>()
                                    .add(ExpenseUpdate());
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                  color: globals.fourthColor,
                                ),
                                child: Row(
                                  children: [
                                    AutoSizeText(
                                      "Отправить на кухню",
                                      style: TextStyle(
                                          fontFamily: globals.font,
                                          fontSize: 16),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 10)),
                                    SvgPicture.asset("assets/img/receipt.svg")
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Row(children: [
                          AutoSizeText(
                            "Итого: ",
                            style: TextStyle(
                              fontFamily: globals.font,
                              fontSize: 20,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 5)),
                          AutoSizeText(
                            "${globals.currentExpenseSum}",
                            style: TextStyle(
                              fontFamily: globals.font,
                              fontSize: 24,
                            ),
                          ),
                        ]),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            // var res = await checkPrint();
                            // if (res == true) {
                            //   prints.testPrint(
                            //       globals.settings!.printer,
                            //       context,
                            //       "reciept",
                            //       {"expense": expense_data, "order": _order});
                            // } else {
                            //   print("no print enymore");
                            // }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: 1,
                                color: Colors.black,
                              ),
                              color: globals.fourthColor,
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/img/print.svg")
                              ],
                            ),
                          ),
                        ),
                        (globals.isKassa)
                            ? Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child:
                                        BlocBuilder<ExpenseBloc, ExpenseState>(
                                      builder: (context, state) {
                                        return MainButton(
                                          action: () async {
                                            if (globals.currentExpense !=
                                                null) {
                                              var modal = Modal(
                                                  ctx: context,
                                                  child: AvansModal(),
                                                  heightIndex: 0.2);
                                              await modal.customDialog();
                                              if (modal.res) {
                                                if (await confirm(context,
                                                    content:
                                                        Text("Вы уверены?"),
                                                    textCancel: Text("Нет"),
                                                    textOK: Text("Да"),
                                                    title: Text(
                                                        "Сохранить аванс"))) {
                                                  context
                                                      .read<ExpenseBloc>()
                                                      .add(ExpensAvansClose());
                                                }
                                              }
                                            } else {
                                              helper.getToast(
                                                  "Выберите счет", context);
                                            }
                                          },
                                          colour: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          text: "Аванс",
                                          textColor:
                                              Theme.of(context).primaryColor,
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child:
                                        BlocBuilder<ExpenseBloc, ExpenseState>(
                                      builder: (context, state) {
                                        return MainButton(
                                          action: () async {
                                            if (globals.currentExpense !=
                                                null) {
                                              var modal = Modal(
                                                  ctx: context,
                                                  child: DebtModal(),
                                                  heightIndex: 0.2);
                                              await modal.customDialog();
                                              if (modal.res) {
                                                if (await confirm(context,
                                                    content:
                                                        Text("Вы уверены?"),
                                                    textCancel: Text("Нет"),
                                                    textOK: Text("Да"),
                                                    title: Text(
                                                        "Закрытие счет в долг"))) {
                                                  context
                                                      .read<ExpenseBloc>()
                                                      .add(ExpenseDebtClose());
                                                }
                                              }
                                            } else {
                                              helper.getToast(
                                                  "Выберите счет", context);
                                            }
                                          },
                                          colour: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          text: "Долг",
                                          textColor:
                                              Theme.of(context).primaryColor,
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child:
                                        BlocBuilder<ExpenseBloc, ExpenseState>(
                                      builder: (context, state) {
                                        return MainButton(
                                          action: () async {
                                            int terminalSum = 0;
                                            var modal = Modal(
                                                ctx: context,
                                                child: TerminalModal(
                                                  terminalSum: terminalSum,
                                                ),
                                                heightIndex: 0.2);
                                            await modal.customDialog();
                                            if (modal.res) {
                                              if (await confirm(context,
                                                  content: Text("Вы уверены?"),
                                                  textCancel: Text("Нет"),
                                                  textOK: Text("Да"),
                                                  title:
                                                      Text("Закрытие счета"))) {
                                                context.read<ExpenseBloc>().add(
                                                    ExpenseTerminalClose());
                                              }
                                            }
                                          },
                                          colour: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          text: "Терминал",
                                          textColor:
                                              Theme.of(context).primaryColor,
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child:
                                        BlocBuilder<ExpenseBloc, ExpenseState>(
                                      builder: (context, state) {
                                        return MainButton(
                                          action: () async {
                                            if (await confirm(context,
                                                content: Text("Вы уверены?"),
                                                textCancel: Text("Нет"),
                                                textOK: Text("Да"),
                                                title:
                                                    Text("Закрытие счета"))) {
                                              context
                                                  .read<ExpenseBloc>()
                                                  .add(ExpenseClose());
                                            }
                                          },
                                          colour: Theme.of(context)
                                              .colorScheme
                                              .error,
                                          text: "Закрыть",
                                          textColor:
                                              Theme.of(context).primaryColor,
                                        );
                                      },
                                    ),
                                  )
                                ],
                              )
                            : Container(),
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
