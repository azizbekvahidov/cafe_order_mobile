import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import './default_input.dart';
import '../../config/globals.dart' as globals;

class NumberInput extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final name;
  // ignore: prefer_typing_uninitialized_variables
  final String hint;
  final maxLength;
  final onChanged;
  final onSubmitted;
  final onEditingComplete;
  final bool autofocus;
  final bool nextAction;
  final bool isRequired;
  const NumberInput(
      {required this.controller,
      required this.name,
      required this.hint,
      this.maxLength,
      this.onChanged,
      this.autofocus = false,
      this.onSubmitted,
      this.onEditingComplete,
      required this.nextAction,
      this.isRequired = false,
      Key? key})
      : super(key: key);

  @override
  _NumberInputState createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  @override
  Widget build(BuildContext context) {
    return DefaultInput(
      isRequired: widget.isRequired,
      child: Container(
        child: FormBuilderTextField(
          textInputAction:
              widget.nextAction ? TextInputAction.next : TextInputAction.done,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          onEditingComplete: widget.onEditingComplete,
          name: widget.name,
          autofocus: widget.autofocus,
          inputFormatters: [
            new LengthLimitingTextInputFormatter(widget.maxLength),
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          maxLines: 1,
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Theme.of(context).indicatorColor,
              ),
          keyboardType: TextInputType.number,
          controller: widget.controller,
          decoration: InputDecoration.collapsed(
            hintText: widget.hint,
            hintStyle: Theme.of(context).textTheme.headline4!,
          ),
        ),
      ),
    );
  }
}
