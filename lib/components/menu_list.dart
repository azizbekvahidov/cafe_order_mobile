import 'package:cafe_mostbyte/bloc/order/order_bloc.dart';
import 'package:cafe_mostbyte/components/product_card.dart';
import 'package:flutter/material.dart';

class MenuList extends StatefulWidget {
  var appbarSize;
  MenuList({required this.appbarSize, Key? key}) : super(key: key);

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  ScrollController _menuController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    return Positioned(
      top: 30,
      left: 0,
      child: Container(
        width: dWidth * 0.77,
        height: dHeight - widget.appbarSize - 200,
        child: SingleChildScrollView(
          controller: _menuController,
          child: StreamBuilder(
            stream: orderBloc.productList,
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                List _products = snapshot.data as List;

                return Wrap(
                  children: [
                    for (Map _product in _products)
                      ProductCard(product: _product)
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: Text("Get Category"));
            },
          ),
        ),
      ),
    );
  }
}
