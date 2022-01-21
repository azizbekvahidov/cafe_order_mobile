import 'package:cafe_mostbyte/components/input/text_input.dart';
import 'package:cafe_mostbyte/models/order.dart';
import 'package:flutter/material.dart';
import '../../services/helper.dart' as helper;

class OrderCommentModal extends StatefulWidget {
  Order data;
  OrderCommentModal({required this.data, Key? key}) : super(key: key);

  @override
  _OrderCommentModalState createState() => _OrderCommentModalState();
}

class _OrderCommentModalState extends State<OrderCommentModal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: TextInput(
          initialValue: widget.data.comment == null ? "" : widget.data.comment!,
          hint: "Введите комментарий для блюда",
          name: "comment",
          nextAction: false,
          onSubmitted: (val) {
            widget.data.comment = val;
            helper.generateCheck(
                data: widget.data.product!,
                type: widget.data.type,
                amount: 0,
                comment: val);
            Navigator.of(context).pop();
          },
          autofocus: true,
        ),
      ),
    );
  }
}
