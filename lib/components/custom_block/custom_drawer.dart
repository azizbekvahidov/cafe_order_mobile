import 'package:cafe_mostbyte/bloc/order/order_bloc.dart';
import 'package:flutter/material.dart';
import '../../config/globals.dart' as globals;

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: globals.categories != null
            ? ListView.builder(
                itemCount: globals.categories!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 7),
                    child: InkWell(
                      onTap: () {
                        orderBloc.fetchProduct(
                            id: globals.categories![index]["id"]);
                        Navigator.pop(context);
                        // getProdByCategory(res[index]["type_id"]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          // border:
                          //     Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset:
                                  Offset(2, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.center,
                        child: Center(
                          child: Text(
                            globals.categories![index]["name_uz"],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container(
                child: Center(
                  child: Text("no data"),
                ),
              ),
      ),
    );
  }
}
