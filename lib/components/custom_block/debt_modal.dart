import 'package:cafe_mostbyte/components/input/number_input.dart';
import 'package:cafe_mostbyte/components/input/text_input.dart';
import 'package:flutter/material.dart';
import '../../config/globals.dart' as globals;

class DebtModal extends StatefulWidget {
  DebtModal({Key? key}) : super(key: key);

  @override
  _DebtModalState createState() => _DebtModalState();
}

class _DebtModalState extends State<DebtModal> {
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
                    hint: "Введите оплаченную сумму долга",
                    name: "sum",
                    nextAction: true,
                    onChanged: (val) {
                      setState(() {
                        debtSum = int.parse(val);
                      });
                      if (val == "") {
                        globals.currentExpense!.debt_payed = 0;
                      } else {
                        globals.currentExpense!.debt_payed = int.parse(val);
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
