import 'package:cafe_mostbyte/bloc/order/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tabbed_view/tabbed_view.dart';

class Tabs extends StatefulWidget {
  Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  List<TabData> tabs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: StreamBuilder(
        stream: orderBloc.expenseList,
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            List expenses = snapshot.data as List;
            if (expenses.length != 0) {
              orderBloc.fetchExpense(id: expenses[expenses.length - 1]["id"]);
            }
            return Row(
              children: [
                for (var _expense in expenses)
                  InkWell(
                    onTap: () {
                      orderBloc.fetchExpense(id: _expense["id"]);
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        height: 30,
                        child: Center(
                          child: Text("${_expense["id"]}"),
                        )),
                  )
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
