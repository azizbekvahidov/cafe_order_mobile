import 'package:cafe_mostbyte/components/input/number_input.dart';
import 'package:flutter/material.dart';
import '../../config/globals.dart' as globals;

class DiscountModal extends StatefulWidget {
  DiscountModal({Key? key}) : super(key: key);

  @override
  _DiscountModalState createState() => _DiscountModalState();
}

class _DiscountModalState extends State<DiscountModal> {
  TextEditingController inputController = TextEditingController();
  @override
  void initState() {
    super.initState();
    inputController.text = globals.currentExpense!.discount.toString();
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
                  child: NumberInput(
                    controller: inputController,
                    hint:
                        "Введите сумму скидки ${globals.settings!.discount == "sum" ? "В сумах" : "В процентах"}",
                    name: "sum",
                    nextAction: true,
                    onChanged: (val) {
                      if (val == "") {
                        globals.currentExpense!.discount = 0;
                      } else {
                        globals.currentExpense!.discount = int.parse(val);
                      }
                    },
                    onSubmitted: (val) {
                      Navigator.pop(context, true);
                    },
                    autofocus: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
