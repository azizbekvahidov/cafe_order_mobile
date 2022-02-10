import 'package:auto_size_text/auto_size_text.dart';
import 'package:cafe_mostbyte/bloc/expense/expense_bloc.dart';
import 'package:cafe_mostbyte/bloc/expense/expense_event.dart';
import 'package:cafe_mostbyte/bloc/expense/expense_repository.dart';
import 'package:cafe_mostbyte/bloc/expense/expense_state.dart';
import 'package:cafe_mostbyte/bloc/form_submission_status.dart';
import 'package:cafe_mostbyte/bloc/order/order_bloc.dart';
import 'package:cafe_mostbyte/components/button/main_button.dart';
import 'package:cafe_mostbyte/components/moderator/moderator_expense_card.dart';
import 'package:cafe_mostbyte/models/delivery.dart';
import 'package:intl/intl.dart';
import 'package:cafe_mostbyte/components/expense_card.dart';
import 'package:cafe_mostbyte/components/input/default_input.dart';
import 'package:cafe_mostbyte/components/input/number_input.dart';
import 'package:cafe_mostbyte/components/input/phone_input.dart';
import 'package:cafe_mostbyte/components/input/text_input.dart';
import 'package:cafe_mostbyte/components/tabs.dart';
import 'package:cafe_mostbyte/models/expense.dart';
import 'package:cafe_mostbyte/services/print_service.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/globals.dart' as globals;
import '../../services/helper.dart' as helper;

_ModeratorFooterState moderatorFooterPageState = _ModeratorFooterState();

class ModeratorFooter extends StatefulWidget {
  ModeratorFooter({Key? key}) : super(key: key);

  @override
  _ModeratorFooterState createState() {
    moderatorFooterPageState = _ModeratorFooterState();
    return moderatorFooterPageState;
  }
}

class _ModeratorFooterState extends State<ModeratorFooter> {
  PrintService print = new PrintService();
  TextEditingController inputController = TextEditingController();
  TextEditingController? phoneController =
      MaskedTextController(mask: '00 000 00 00');
  Delivery delivery = Delivery();
  String address = "";
  String comment = "";
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
                await print.checkPrint(printData: globals.orderState);
                globals.orderState = null;
                tabsState.setState(() {
                  globals.currentExpenseChange = false;
                });
              }
              moderatorExpenseCardPageState.setState(() {});
              moderatorFooterPageState.setState(() {});
              context.read<ExpenseBloc>().add(ExpenseInitialized());
            } else if (formStatus is SubmissionFailed) {
              helper.getToast("Что то пошло не так", context);
            }
            // TODO: implement listener
          },
          child: Positioned(
              bottom: 0,
              child: Container(
                color: Theme.of(context).primaryColor,
                height: 170,
                padding: EdgeInsets.only(bottom: 5, top: 5),
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
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            height: 150,
                            child: (globals.currentExpense != null)
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: PhoneInput(
                                                  controller: phoneController,
                                                  name: "phone",
                                                  autofocus: true,
                                                  hint: "99 999 99 99",
                                                  onChanged: (val) {
                                                    delivery.phone = "+998$val";
                                                  },
                                                  nextAction: true)),
                                          Expanded(
                                            flex: 4,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16),
                                              child: NumberInput(
                                                controller: inputController,
                                                hint: "Сумма доставки",
                                                name: "sum",
                                                nextAction: true,
                                                onChanged: (val) {
                                                  delivery.price =
                                                      int.parse(val);
                                                },
                                                autofocus: true,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16),
                                              child: DefaultInput(
                                                child:
                                                    FormBuilderDateTimePicker(
                                                  name: "time",
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  format: DateFormat('HH:mm'),
                                                  inputType: InputType.time,
                                                  onChanged: (val) {
                                                    String date = DateFormat(
                                                            "yyyy-MM-dd")
                                                        .format(DateTime.now())
                                                        .toString();
                                                    if (val != null)
                                                      delivery.delivery_time =
                                                          "$date ${DateFormat("HH:mm").format(val).toString()}:${DateFormat("ss").format(DateTime.now()).toString()}";
                                                  },
                                                  decoration:
                                                      InputDecoration.collapsed(
                                                    hintText: "Введите время",
                                                    hintStyle: Theme.of(context)
                                                        .textTheme
                                                        .headline4!,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: TextInput(
                                              hint: "Введите адрес",
                                              name: "address",
                                              initialValue: address,
                                              nextAction: true,
                                              onChanged: (val) {
                                                delivery.address = val;
                                              },
                                              autofocus: true,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16),
                                              child: TextInput(
                                                hint: "Введите комменитарий",
                                                name: "comment",
                                                initialValue: comment,
                                                nextAction: false,
                                                onChanged: (val) {
                                                  delivery.comment = val;
                                                },
                                                autofocus: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Container(),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 150,
                            width: dWidth * 0.3,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 150,
                            width: dWidth * 0.17,
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
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
                                          "${globals.currentExpenseSum}",
                                          style: TextStyle(
                                            fontFamily: globals.font,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: BlocBuilder<ExpenseBloc, ExpenseState>(
                                    builder: (context, state) {
                                      return MainButton(
                                        action: () async {
                                          if (await confirm(context,
                                              content: Text("Вы уверены?"),
                                              textCancel: Text("Нет"),
                                              textOK: Text("Да"),
                                              title: Text("Закрытие счета"))) {
                                            globals.currentExpense!.delivery =
                                                delivery;
                                            context
                                                .read<ExpenseBloc>()
                                                .add(ExpenseClose());
                                          }
                                        },
                                        colour:
                                            Theme.of(context).colorScheme.error,
                                        text: "Отправить",
                                        textColor:
                                            Theme.of(context).primaryColor,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
