import 'package:cafe_mostbyte/components/input/number_input.dart';
import 'package:cafe_mostbyte/components/input/text_input.dart';
import 'package:cafe_mostbyte/models/order.dart';
import 'package:flutter/material.dart';
import '../../config/globals.dart' as globals;
import '../../services/helper.dart' as helper;

class TerminalModal extends StatefulWidget {
  int terminalSum;
  TerminalModal({required this.terminalSum, Key? key}) : super(key: key);

  @override
  _TerminalModalState createState() => _TerminalModalState();
}

class _TerminalModalState extends State<TerminalModal> {
  TextEditingController inputController = TextEditingController();
  int terminalSum = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            NumberInput(
              controller: inputController,
              hint: "Введите сумму оплаченный терминалом",
              name: "comment",
              nextAction: false,
              onSubmitted: (val) {
                if (globals.currentExpense != null) {
                  if (val == "") {
                    globals.currentExpense!.terminal =
                        globals.currentExpenseSum;
                  } else {
                    globals.currentExpense!.terminal = int.parse(val);
                  }
                } else {
                  helper.getToast("Выберите счет", context);
                }
                Navigator.pop(context, true);
              },
              onChanged: (val) {
                setState(() {
                  terminalSum = int.parse(val);
                });
              },
              autofocus: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Наличные: ${globals.currentExpenseSum - terminalSum}",
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
