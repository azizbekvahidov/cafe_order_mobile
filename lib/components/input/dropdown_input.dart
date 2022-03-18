import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './default_input.dart';
import '../../config/globals.dart' as globals;

class DropdownInput extends StatefulWidget {
  final name;
  // ignore: prefer_typing_uninitialized_variables
  final String hint;
  final onChanged;
  final validator;
  final onTap;
  final List options;
  final result;
  final bool isRequired;
  const DropdownInput(
      {required this.name,
      required this.hint,
      this.onChanged,
      this.validator,
      this.onTap,
      required this.options,
      this.result = "",
      this.isRequired = false,
      Key? key})
      : super(key: key);

  @override
  _DropdownInputState createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {
  @override
  Widget build(BuildContext context) {
    return DefaultInput(
      isRequired: widget.isRequired,
      child: FormBuilderDropdown(
        validator: widget.validator,
        initialValue: widget.result == "" ? null : widget.result,
        icon: SvgPicture.asset("assets/img/arrow-down.svg"),
        items: widget.options.map((option) {
          return DropdownMenuItem(
            value: option["index"],
            child: Text('${option["value"]}'),
          );
        }).toList(),
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        name: widget.name,
        style: Theme.of(context).textTheme.headline4!.copyWith(
              color: Theme.of(context).indicatorColor,
            ),
        decoration: InputDecoration.collapsed(
          hintText: widget.hint,
          hintStyle: Theme.of(context).textTheme.headline4!,
        ),
      ),
    );
  }
}
