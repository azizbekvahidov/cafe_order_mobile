import 'package:cafe_mostbyte/bloc/auth/expense/expense_bloc.dart';
import 'package:cafe_mostbyte/bloc/auth/expense/expense_event.dart';
import 'package:cafe_mostbyte/bloc/auth/expense/expense_repository.dart';
import 'package:cafe_mostbyte/bloc/auth/expense/expense_state.dart';
import 'package:cafe_mostbyte/bloc/form_submission_status.dart';
import 'package:cafe_mostbyte/bloc/order/order_bloc.dart';
import 'package:cafe_mostbyte/components/order_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../config/globals.dart' as globals;

class Tabs extends StatefulWidget {
  Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  ScrollController tabScroll = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dWidth = MediaQuery.of(context).size.width;
    return Positioned(
      top: 0,
      child: RepositoryProvider(
        create: (context) => ExpenseRepository(),
        child: BlocProvider(
          create: (context) =>
              ExpenseBloc(repo: context.read<ExpenseRepository>()),
          child: BlocListener<ExpenseBloc, ExpenseState>(
            listener: (context, state) {
              var formStatus = state.formStatus;
              if (formStatus is SubmissionSuccess) {
                orderBloc.fetchExpenses(id: globals.filial);
              } else if (formStatus is SubmissionFailed) {}
              // TODO: implement listener
            },
            child: StreamBuilder(
              stream: orderBloc.expenseList,
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  List expenses = snapshot.data as List;

                  return Container(
                    width: dWidth * 0.97,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: dWidth * 0.93,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: tabScroll,
                            child: Row(
                              children: [
                                for (var _expense in expenses)
                                  InkWell(
                                    onTap: () {
                                      orderBloc.fetchExpense(
                                          id: _expense["id"]);
                                      setState(() {
                                        globals.currentExpenseId =
                                            _expense["id"];
                                      });
                                      orderFooterPageState.setState(() {
                                        globals.currentExpenseSum =
                                            _expense["expense_sum"];
                                      });
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          ),
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          color: globals.currentExpenseId ==
                                                  _expense["id"]
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primaryVariant
                                              : Theme.of(context).primaryColor,
                                        ),
                                        height: 30,
                                        child: Center(
                                          child: Text(
                                            "${_expense["id"]}",
                                            style: TextStyle(
                                              color: globals.currentExpenseId ==
                                                      _expense["id"]
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Theme.of(context)
                                                      .indicatorColor,
                                            ),
                                          ),
                                        )),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        BlocBuilder<ExpenseBloc, ExpenseState>(
                          builder: (context, state) {
                            return InkWell(
                              onTap: () {
                                context
                                    .read<ExpenseBloc>()
                                    .add(ExpenseCreate());
                              },
                              child: Container(
                                height: 30,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Theme.of(context).primaryColor,
                                )),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
