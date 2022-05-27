import 'package:cafe_mostbyte/bloc/order/order_bloc.dart';
import 'package:cafe_mostbyte/components/product_card.dart';
import 'package:cafe_mostbyte/models/menu_item.dart' as menuItem;
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
      top: 35,
      left: 0,
      child: Container(
        width: dWidth * 0.77,
        height: dHeight - widget.appbarSize - 200,
        child: SingleChildScrollView(
          controller: _menuController,
          child: StreamBuilder(
            stream: orderBloc.productList,
            builder:
                (context, AsyncSnapshot<List<menuItem.MenuItem>> snapshot) {
              if (snapshot.hasData) {
                List _products = snapshot.data as List;

                return Wrap(
                  children: [
                    for (menuItem.MenuItem _product in _products)
                      ProductCard(data: _product)
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(
                  child: Text(
                "Выберите категорию!!!",
                style: Theme.of(context).textTheme.headline1,
              ));
            },
          ),
        ),
      ),
    );
  }
}
