import 'package:auto_size_text/auto_size_text.dart';
import 'package:cafe_mostbyte/bloc/bot_expense/bot_expense_bloc.dart';
import 'package:cafe_mostbyte/bloc/bot_expense/bot_expense_event.dart';
import 'package:cafe_mostbyte/bloc/bot_expense/bot_expense_repository.dart';
import 'package:cafe_mostbyte/bloc/bot_expense/bot_expense_state.dart';
import 'package:cafe_mostbyte/bloc/filial/filial_bloc.dart';
import 'package:cafe_mostbyte/bloc/form_submission_status.dart';
import 'package:cafe_mostbyte/components/button/main_button.dart';
import 'package:cafe_mostbyte/components/button/secondary_button.dart';
import 'package:cafe_mostbyte/components/input/custom_radio.dart';
import 'package:cafe_mostbyte/components/moderator/moderator_expense_card.dart';
import 'package:cafe_mostbyte/models/delivery.dart';
import 'package:cafe_mostbyte/models/filial.dart';
import 'package:cafe_mostbyte/utils/enums/order_type.dart';
import 'package:intl/intl.dart';
import 'package:cafe_mostbyte/components/input/default_input.dart';
import 'package:cafe_mostbyte/components/input/number_input.dart';
import 'package:cafe_mostbyte/components/input/phone_input.dart';
import 'package:cafe_mostbyte/components/input/text_input.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  TextEditingController inputController = TextEditingController();
  TextEditingController? phoneController =
      MaskedTextController(mask: '00 000 00 00');
  Delivery delivery = Delivery();
  bool isSelectOrderType = false;
  // Delivery? delivery;
  String address = "";
  String phone = "";
  String comment = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (globals.currentExpense != null) {
      if (globals.currentExpense!.delivery != null) {
        isSelectOrderType = true;
        delivery = globals.currentExpense!.delivery!;
        address = globals.currentExpense!.delivery!.address ?? "";
        comment = globals.currentExpense!.delivery!.comment != null
            ? globals.currentExpense!.delivery!.comment!
            : "";
        phoneController!.text =
            globals.currentExpense!.delivery!.phone!.substring(4);
        helper.calculateTotalSum();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    filialBloc.fetchFilial();
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    return RepositoryProvider(
      create: (context) => BotExpenseRepository(),
      child: BlocProvider(
        create: (context) =>
            BotExpenseBloc(repo: context.read<BotExpenseRepository>()),
        child: BlocListener<BotExpenseBloc, BotExpenseState>(
          listener: (context, state) async {
            var formStatus = state.formStatus;
            if (formStatus is SubmissionSuccess) {
              delivery = Delivery();
              globals.filial = 0;
              globals.isBotOrder = null;
              globals.currentExpense = null;
              globals.currentExpenseSum = 0;
              moderatorExpenseCardPageState.setState(() {});
              moderatorFooterPageState.setState(() {});
              isSelectOrderType = false;
              inputController.text = "";
              phoneController!.text = "";
              address = "";
              phone = "";
              comment = "";
              context.read<BotExpenseBloc>().add(BotExpenseInitialized());
              helper.getToast("Успешно отправлено", context,
                  bgColor: Theme.of(context).colorScheme.primary);
            } else if (formStatus is SubmissionFailed) {
              helper.getToast("Что то пошло не так", context);
            }
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
                            margin: const EdgeInsets.only(top: 10),
                            height: 140,
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
                                                  isRequired: true,
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
                                                  initialValue: (globals
                                                                  .currentExpense!
                                                                  .delivery !=
                                                              null &&
                                                          globals
                                                                  .currentExpense!
                                                                  .delivery
                                                                  ?.delivery_time !=
                                                              null)
                                                      ? DateTime.parse(globals
                                                          .currentExpense!
                                                          .delivery!
                                                          .delivery_time!)
                                                      : null,
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
                                              isRequired: true,
                                              initialValue: address,
                                              hint: "Введите адрес",
                                              name: "address",
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
                                                initialValue: comment,
                                                hint: "Введите комменитарий",
                                                name: "comment",
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: dWidth * 0.3,
                            child: Column(
                              children: [
                                Text(
                                  "Филиал",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                StreamBuilder<List<Filial>>(
                                    stream: filialBloc.filialList,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<Filial> data =
                                            snapshot.data as List<Filial>;
                                        return CustomRadio(
                                          data: data
                                              .map((e) => {
                                                    "index": e.id,
                                                    "value": e.name,
                                                  })
                                              .toList(),
                                          result: globals.filial.toString(),
                                          onClick: (value) {
                                            globals.filial =
                                                int.parse(value.toString());
                                          },
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(snapshot.error.toString());
                                      }
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }),
                                Container(
                                  child: FormBuilderRadioGroup(
                                    initialValue: (globals.currentExpense ==
                                            null)
                                        ? null
                                        : globals.currentExpense!.order_type,
                                    decoration: InputDecoration(
                                      labelStyle:
                                          Theme.of(context).textTheme.bodyText1,
                                      label: Text(
                                        "Тип заказа",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                      floatingLabelStyle:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    wrapSpacing: 5.0,
                                    disabled: (globals.currentExpense == null)
                                        ? ["book_table", "take", "delivery"]
                                        : null,
                                    activeColor:
                                        Theme.of(context).colorScheme.primary,
                                    onChanged: (value) {
                                      if (globals.currentExpense != null) {
                                        isSelectOrderType = true;
                                        globals.currentExpense!.order_type =
                                            value.toString();
                                      } else {
                                        helper.getToast(
                                            "Выберите или откройте счет",
                                            context);
                                      }
                                    },
                                    name: 'filial',
                                    options: [
                                      {
                                        "key": OrderType.book_table.name,
                                        "value": "Зал"
                                      },
                                      {
                                        "key": OrderType.take.name,
                                        "value": "С собой"
                                      },
                                      {
                                        "key": OrderType.delivery.name,
                                        "value": "Доставка"
                                      },
                                    ]
                                        .map((item) => FormBuilderFieldOption(
                                              value: item["key"].toString(),
                                              child: Text(
                                                "${item["value"]}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                            ))
                                        .toList(growable: false),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 150,
                            width: dWidth * 0.17,
                            padding: const EdgeInsets.only(bottom: 10),
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 7),
                                  child: BlocBuilder<BotExpenseBloc,
                                      BotExpenseState>(
                                    builder: (context, state) {
                                      return MainButton(
                                        action: () async {
                                          if (globals.currentExpense != null) {
                                            if (globals.filial != 0) {
                                              if (isSelectOrderType) {
                                                if (await confirm(context,
                                                    content:
                                                        Text("Вы уверены?"),
                                                    textCancel: Text("Нет"),
                                                    textOK: Text("Да"),
                                                    title: Text(
                                                        "Закрытие счета"))) {
                                                  globals.currentExpense!
                                                      .delivery = delivery;
                                                  context
                                                      .read<BotExpenseBloc>()
                                                      .add(AddBotOrder());
                                                }
                                              } else {
                                                helper.getToast(
                                                    "Выберите тип заказа",
                                                    context);
                                              }
                                            } else {
                                              helper.getToast(
                                                  "Выберите филиал", context);
                                            }
                                          } else {
                                            helper.getToast(
                                                "Выберите или откройте счет",
                                                context);
                                          }
                                        },
                                        colour: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        text: "Отправить",
                                        textColor:
                                            Theme.of(context).primaryColor,
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 7),
                                  child: BlocBuilder<BotExpenseBloc,
                                      BotExpenseState>(
                                    builder: (context, state) {
                                      return SecondaryButton(
                                        action: () async {
                                          if (await confirm(context,
                                              content: Text("Вы уверены?"),
                                              textCancel: Text("Нет"),
                                              textOK: Text("Да"),
                                              title: Text("Отменить?"))) {
                                            context
                                                .read<BotExpenseBloc>()
                                                .add(CancelBotOrder());
                                          }
                                        },
                                        colour:
                                            Theme.of(context).colorScheme.error,
                                        text: "Отмена",
                                        // textColor:
                                        //     Theme.of(context).primaryColor,
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
