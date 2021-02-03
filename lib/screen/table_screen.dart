import 'package:cafe_order/screen/order_screen.dart';
import 'package:cafe_order/widget/custon_appbar.dart';
import 'package:flutter/material.dart';
import 'package:cafe_order/globals.dart' as globals;

class TableScreen extends StatefulWidget {
  TableScreen({Key key}) : super(key: key);

  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List<dynamic> _tables = [
    {
      "id": 1,
      "name": "tab1",
    },
    {
      "id": 2,
      "name": "tab2",
    },
    {
      "id": 3,
      "name": "tab3",
    },
    {
      "id": 4,
      "name": "tab4",
    }
  ];

  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    var appbar = CustomAppbar();
    return Scaffold(
      appBar: appbar,
      body: Container(
        height: dHeight - appbar.preferredSize.height,
        width: dWidth,
        alignment: Alignment.center,
        child: Center(
            child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Image.asset("assets/img/logo.png"),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: dWidth,
                height: dHeight - appbar.preferredSize.height - 200,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _tables.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        globals.isOrder = true;
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (BuildContext ctx) {
                          return OrderScreen(
                            tableId: _tables[index]["id"],
                          );
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: globals.thirdColor,
                        ),
                        height: 50,
                        child: Center(
                          child: Text(_tables[index]["name"]),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
