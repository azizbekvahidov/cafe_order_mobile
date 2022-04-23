import 'package:cafe_mostbyte/components/button/secondary_button.dart';
import 'package:cafe_mostbyte/components/input/default_input.dart';
import 'package:cafe_mostbyte/components/input/number_input.dart';
import 'package:cafe_mostbyte/components/input/phone_input.dart';
import 'package:cafe_mostbyte/models/delivery.dart';
import 'package:intl/intl.dart';
import 'package:cafe_mostbyte/components/input/text_input.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../config/globals.dart' as globals;

class DeliveryModal extends StatefulWidget {
  DeliveryModal({Key? key}) : super(key: key);

  @override
  _DeliveryModalState createState() => _DeliveryModalState();
}

class _DeliveryModalState extends State<DeliveryModal> {
  TextEditingController inputController = TextEditingController();
  TextEditingController? phoneController =
      MaskedTextController(mask: '00 000 00 00');
  int debtSum = 0;
  Delivery? delivery;
  String address = "";
  String phone = "";
  String comment = "";

  @override
  void initState() {
    //
    super.initState();
    if (globals.currentExpense!.delivery != null) {
      delivery = globals.currentExpense!.delivery;
      inputController.text = globals.currentExpense!.delivery!.price.toString();
      address = globals.currentExpense!.delivery!.address!;
      comment = globals.currentExpense!.delivery!.comment != null
          ? globals.currentExpense!.delivery!.comment!
          : "";
      phoneController!.text =
          globals.currentExpense!.delivery!.phone!.substring(4);
    } else {
      delivery = Delivery();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
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
                          delivery!.phone = "+998$val";
                        },
                        nextAction: true)),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: NumberInput(
                      controller: inputController,
                      hint: "Сумма доставки",
                      name: "sum",
                      nextAction: true,
                      onChanged: (val) {
                        delivery!.price = int.parse(val);
                      },
                      autofocus: true,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: DefaultInput(
                      child: FormBuilderDateTimePicker(
                        name: "time",
                        initialValue: (globals.currentExpense!.delivery != null)
                            ? (globals.currentExpense!.delivery!
                                        .delivery_time !=
                                    "null")
                                ? DateTime.parse(globals
                                    .currentExpense!.delivery!.delivery_time!)
                                : null
                            : null,
                        textInputAction: TextInputAction.next,
                        format: DateFormat('HH:mm'),
                        inputType: InputType.time,
                        onChanged: (val) {
                          String date = DateFormat("yyyy-MM-dd")
                              .format(DateTime.now())
                              .toString();
                          delivery!.delivery_time =
                              "$date ${DateFormat("HH:mm").format(val!).toString()}:${DateFormat("ss").format(DateTime.now()).toString()}";
                        },
                        decoration: InputDecoration.collapsed(
                          hintText: "Введите время",
                          hintStyle: Theme.of(context).textTheme.headline4!,
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
                      delivery!.address = val;
                    },
                    autofocus: true,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: TextInput(
                      hint: "Введите комменитарий",
                      name: "comment",
                      initialValue: comment,
                      nextAction: false,
                      onChanged: (val) {
                        delivery!.comment = val;
                      },
                      autofocus: true,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 150,
                  child: SecondaryButton(
                    action: () async {
                      globals.currentExpense!.delivery = delivery;
                      Navigator.pop(context, true);
                    },
                    colour: Theme.of(context).colorScheme.primary,
                    text: "Сохранить",
                    // textColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
