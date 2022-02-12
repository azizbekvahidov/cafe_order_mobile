import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DefaultInput extends StatefulWidget {
  Widget child;
  bool isRequired;
  DefaultInput({this.isRequired = false, required this.child, Key? key})
      : super(key: key);

  @override
  _DefaultInputState createState() => _DefaultInputState();
}

class _DefaultInputState extends State<DefaultInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 48,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: (widget.isRequired)
            ? Border.all(color: Theme.of(context).colorScheme.error)
            : Border.all(color: Theme.of(context).hintColor),
        color: Color.fromARGB(255, 230, 231, 233),
        borderRadius: BorderRadius.circular(8),
      ),
      child: widget.child,
    );
  }
}
