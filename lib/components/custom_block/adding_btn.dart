import 'package:auto_size_text/auto_size_text.dart';
import 'package:cafe_mostbyte/components/expense_card.dart';
import 'package:cafe_mostbyte/components/moderator/moderator_expense_card.dart';
import 'package:cafe_mostbyte/components/tabs.dart';
import 'package:cafe_mostbyte/models/order.dart';
import 'package:flutter/material.dart';
import '../../config/globals.dart' as globals;
import '../../services/helper.dart' as helper;

// ignore: must_be_immutable
class AddingBtn extends StatefulWidget {
  Order data;
  AddingBtn({required this.data, Key? key}) : super(key: key);

  @override
  _AddingBtnState createState() => _AddingBtnState();
}

class _AddingBtnState extends State<AddingBtn> {
  changeState(temp) {
    temp = double.parse(temp.toStringAsFixed(1));
    if (temp <= 0) {
      if (expenseCardPageState.mounted)
        expenseCardPageState.setState(() {
          globals.currentExpense!.order.removeWhere((element) {
            return element.product_id == widget.data.product_id &&
                element.type == widget.data.type;
          });
        });
      if (moderatorExpenseCardPageState.mounted)
        moderatorExpenseCardPageState.setState(() {
          globals.currentExpense!.order.removeWhere((element) {
            return element.product_id == widget.data.product_id &&
                element.type == widget.data.type;
          });
        });
    } else {
      if (expenseCardPageState.mounted)
        expenseCardPageState.setState(() {
          var orderRow = globals.currentExpense!.order.firstWhere((element) {
            return element.product_id == widget.data.product_id &&
                element.type == widget.data.type;
          });
          orderRow.amount = temp;
        });
      if (moderatorExpenseCardPageState.mounted)
        moderatorExpenseCardPageState.setState(() {
          var orderRow = globals.currentExpense!.order.firstWhere((element) {
            return element.product_id == widget.data.product_id &&
                element.type == widget.data.type;
          });
          orderRow.amount = temp;
        });
    }
    if (tabsState.mounted)
      tabsState.setState(() {
        globals.currentExpenseChange = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: InkWell(
                onTap: () {
                  double temp = (widget.data.amount - 0.1).toDouble();

                  changeState(temp);
                  helper.generateCheck(
                      data: widget.data.product!,
                      type: widget.data.type,
                      amount: -0.1);
                  helper.calculateTotalSum();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    "-0.1",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 32),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: InkWell(
                onTap: () {
                  double temp = (widget.data.amount - 0.5).toDouble();

                  changeState(temp);
                  helper.generateCheck(
                      data: widget.data.product!,
                      type: widget.data.type,
                      amount: -0.5);
                  helper.calculateTotalSum();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    "-0.5",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 32),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: InkWell(
                onTap: () {
                  double temp = (widget.data.amount + 0.5).toDouble();

                  changeState(temp);
                  helper.generateCheck(
                      data: widget.data.product!,
                      type: widget.data.type,
                      amount: 0.5);
                  helper.calculateTotalSum();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    "+0.5",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 32),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: InkWell(
                onTap: () {
                  double temp = (widget.data.amount + 0.1).toDouble();

                  changeState(temp);
                  helper.generateCheck(
                      data: widget.data.product!,
                      type: widget.data.type,
                      amount: 0.1);
                  helper.calculateTotalSum();
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: AutoSizeText(
                    "+0.1",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 32),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
