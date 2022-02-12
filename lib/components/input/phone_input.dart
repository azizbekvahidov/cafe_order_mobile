import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import './default_input.dart';
import '../../config/globals.dart' as globals;

class PhoneInput extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final name;
  final String hint;
  final onChanged;
  final onSubmitted;
  final onEditingComplete;
  final bool nextAction;
  final bool autofocus;
  final bool isRequired;
  const PhoneInput(
      {required this.controller,
      required this.name,
      required this.hint,
      this.onChanged,
      this.onSubmitted,
      this.onEditingComplete,
      required this.nextAction,
      this.autofocus = false,
      this.isRequired = false,
      Key? key})
      : super(key: key);

  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultInput(
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Text(
            "+998 ",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Expanded(
          flex: 9,
          child: FormBuilderTextField(
            autofocus: widget.autofocus,
            textInputAction:
                widget.nextAction ? TextInputAction.next : TextInputAction.done,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            onEditingComplete: widget.onEditingComplete,
            name: widget.name,
            maxLines: 1,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Theme.of(context).indicatorColor,
                ),
            keyboardType: TextInputType.phone,
            controller: widget.controller,
            decoration: InputDecoration.collapsed(
              hintText: widget.hint,
              hintStyle: Theme.of(context).textTheme.headline4!,
            ),
          ),
        ),
      ]),
    );
  }
}
