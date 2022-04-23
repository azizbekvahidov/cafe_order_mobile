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
import 'package:cafe_mostbyte/components/custom_block/delivery_modal.dart';
import 'package:cafe_mostbyte/components/custom_block/discount_modal.dart';
import 'package:cafe_mostbyte/components/custom_block/modal.dart';
import 'package:cafe_mostbyte/components/custom_block/takeaway_modal.dart';
import 'package:cafe_mostbyte/components/custom_block/terminal_modal.dart';
import 'package:cafe_mostbyte/components/expense_card.dart';
import 'package:cafe_mostbyte/components/tabs.dart';
import 'package:cafe_mostbyte/models/expense.dart';
import 'package:cafe_mostbyte/services/print_service.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
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
                await print.checkPrint(
                    printData: globals.orderState,
                    order_type: globals.currentExpense!.order_type);
                globals.orderState = null;
                tabsState.setState(() {
                  globals.currentExpenseChange = false;
                });
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
                                    Icon(
                                      MaterialCommunityIcons.printer_check,
                                      size: 30,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                    ) //SvgPicture.asset("assets/img/receipt.svg")
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        StreamBuilder(
                          stream: orderBloc.expense,
                          builder: (context, AsyncSnapshot<Expense?> snapshot) {
                            if (snapshot.hasData) {
                              Expense data = snapshot.data!;
                              return Row(
                                children: [
                                  BlocBuilder<ExpenseBloc, ExpenseState>(
                                    builder: (context, state) {
                                      return Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: InkWell(
                                              onTap: () async {
                                                if (data != null) {
                                                  var modal = Modal(
                                                      ctx: context,
                                                      child: TakeawayModal(),
                                                      heightIndex: 0.22);
                                                  await modal.customDialog();
                                                  if (modal.res) {
                                                    setState(() {
                                                      globals.currentExpense!
                                                          .order_type = "take";
                                                    });
                                                    // context
                                                    //     .read<ExpenseBloc>()
                                                    //     .add(ExpenseTakeaway());
                                                    // }
                                                  }
                                                } else {
                                                  helper.getToast(
                                                      "Выберите счет", context);
                                                }
                                              },
                                              child: Icon(
                                                MaterialIcons.food_bank,
                                                // "assets/img/take-away.svg",
                                                color: (data.delivery != null)
                                                    ? Colors.black
                                                    : ((data.phone == null)
                                                        ? Colors.black
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .primary),
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondaryContainer,
                                            thickness: 2,
                                            width: 2,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              if (data != null) {
                                                var modal = Modal(
                                                    ctx: context,
                                                    child: DeliveryModal(),
                                                    heightIndex: 0.3);
                                                await modal.customDialog();
                                                if (modal.res) {
                                                  setState(() {
                                                    globals.currentExpense!
                                                            .order_type =
                                                        "delivery";
                                                  });
                                                  // context
                                                  //     .read<ExpenseBloc>()
                                                  //     .add(ExpenseDelivery());
                                                  // }
                                                }
                                              } else {
                                                helper.getToast(
                                                    "Выберите счет", context);
                                              }
                                            },
                                            child: Icon(
                                              MaterialCommunityIcons
                                                  .truck_delivery,
                                              color: (data.delivery == null)
                                                  ? Colors.black
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 300,
                                    margin: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                      border:
                                          Border(bottom: BorderSide(width: 1)),
                                    ),
                                    child: Text(
                                      "${data.delivery == null ? (data.phone != null ? data.phone : "") : data.delivery!.phone}",
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            return Container();
                          },
                        ),
                        StreamBuilder(
                          stream: orderBloc.expense,
                          builder: (context, AsyncSnapshot<Expense?> snapshot) {
                            if (snapshot.hasData) {
                              Expense data = snapshot.data!;
                              return Row(
                                children: [
                                  BlocBuilder<ExpenseBloc, ExpenseState>(
                                    builder: (context, state) {
                                      return Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              if (data != null) {
                                                var modal = Modal(
                                                    ctx: context,
                                                    child: DiscountModal(),
                                                    heightIndex: 0.2);
                                                await modal.customDialog();
                                                if (modal.res) {
                                                  context
                                                      .read<ExpenseBloc>()
                                                      .add(ExpenseDiscount());
                                                  // }
                                                }
                                              } else {
                                                helper.getToast(
                                                    "Выберите счет", context);
                                              }
                                            },
                                            child: Icon(
                                              MaterialCommunityIcons.sale,
                                              color: (data.discount == 0)
                                                  ? Colors.black
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 100,
                                    margin: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                      border:
                                          Border(bottom: BorderSide(width: 1)),
                                    ),
                                    child: Text(
                                      "${data.discount == 0 ? "" : data.discount}",
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            return Container();
                          },
                        ),
                        StreamBuilder(
                          stream: orderBloc.expense,
                          builder: (context, AsyncSnapshot<Expense?> snapshot) {
                            if (snapshot.hasData) {
                              Expense data = snapshot.data!;
                              return Container(
                                width: 200,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AutoSizeText(
                                        "Итого: ",
                                        style: TextStyle(
                                          fontFamily: globals.font,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 5)),
                                      AutoSizeText(
                                        "${globals.currentExpenseSum - (globals.settings!.discount == 'sum' ? data.discount : ((globals.currentExpenseSum * data.discount / 100) / 100).ceil() * 100)}",
                                        style: TextStyle(
                                          fontFamily: globals.font,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              );
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            await print.recieptPrint(
                                expense: globals.currentExpense);
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
                                Icon(
                                  MaterialCommunityIcons.printer_pos,
                                  size: 30,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                )
                                //SvgPicture.asset("assets/img/print.svg")
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
                                                      .add(ExpenseAvansClose());
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
