import 'package:cafe_mostbyte/components/input/number_input.dart';
import 'package:cafe_mostbyte/components/input/text_input.dart';
import 'package:flutter/material.dart';
import '../../config/globals.dart' as globals;
import '../../services/helper.dart' as helper;

class AvansModal extends StatefulWidget {
  AvansModal({Key? key}) : super(key: key);

  @override
  _AvansModalState createState() => _AvansModalState();
}

class _AvansModalState extends State<AvansModal> {
  TextEditingController inputController = TextEditingController();
  int debtSum = 0;
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
                    hint: "Введите оплаченную сумму Аванса",
                    name: "sum",
                    nextAction: true,
                    onChanged: (val) {
                      setState(() {
                        debtSum = int.parse(val);
                      });
                      if (val == "") {
                        globals.currentExpense!.prepaidSum = 0;
                      } else {
                        globals.currentExpense!.prepaidSum = int.parse(val);
                      }
                    },
                    autofocus: true,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: TextInput(
                      hint: "Введите комменитарий",
                      name: "comment",
                      nextAction: false,
                      onSubmitted: (val) {
                        Navigator.pop(context, true);
                      },
                      onChanged: (val) {
                        globals.currentExpense!.comment = val;
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
                Text(
                  "Осталось долга: ${globals.currentExpenseSum - debtSum}",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
