import 'package:auto_size_text/auto_size_text.dart';
import 'package:cafe_mostbyte/helper/dio_connection.dart';
import './order_screen.dart';
import '../widget/custon_appbar.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

_TableScreenState tableScreenState;

class TableScreen extends StatefulWidget {
  TableScreen({Key key}) : super(key: key);

  @override
  _TableScreenState createState() {
    tableScreenState = _TableScreenState();
    return tableScreenState;
  }
}

class _TableScreenState extends State<TableScreen> {
  List<dynamic> _tables = globals.tables;
  List<dynamic> _activeTables;
  var connect = new DioConnection();
  @override
  void initState() {
    super.initState();
    getExpenses();
    setState(() {});
  }

  Future getExpenses() async {
    try {
      Map<String, String> headers = {};
      var response = await connect.getHttp(
          'expenses?user=${globals.userData["employee_id"]}',
          tableScreenState,
          headers);
      var res = [];
      if (response["statusCode"] == 200) {
        res = response["result"];
      }
      return res;
    } catch (e) {
      print(e);
    }
  }

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
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: dWidth,
                height: dHeight - appbar.preferredSize.height - 90,
                child: FutureBuilder(
                  future: getExpenses(),
                  builder: (conxtext, snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: _tables.length,
                            itemBuilder: (BuildContext context, int index) {
                              bool _isMy = false;
                              var active;
                              try {
                                active = snapshot.data.firstWhere((e) =>
                                    e["table"] == _tables[index]["table_num"]);
                                if (active != null &&
                                    active["employee_id"] ==
                                        globals.userData["employee_id"]) {
                                  _isMy = true;
                                }
                              } catch (e) {
                                print(e);
                              }
                              return Container(
                                margin: EdgeInsets.only(
                                    bottom: 10, left: 6, right: 6),
                                child: InkWell(
                                  onTap: () {
                                    if (_isMy) {
                                      globals.isOrder = true;
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext ctx) {
                                        return OrderScreen(
                                            tableId: _tables[index]
                                                ["table_num"],
                                            expenseId: active["expense_id"],
                                            tableName: _tables[index]
                                                    ["table_num"]
                                                .toString());
                                      }));
                                    } else if (active == null) {
                                      globals.isOrder = true;
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext ctx) {
                                        return OrderScreen(
                                          tableId: _tables[index]["table_num"],
                                          tableName: _tables[index]["table_num"]
                                              .toString(),
                                        );
                                      }));
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(2,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 2,
                                        color: active == null
                                            ? Colors.transparent
                                            : _isMy
                                                ? globals.mainColor
                                                : globals.secondaryColor,
                                      ),
                                    ),
                                    height: 50,
                                    child: Center(
                                      child: AutoSizeText(
                                        _tables[index]["table_num"].toString(),
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontFamily: globals.font,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Container();
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
