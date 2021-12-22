import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import './default_input.dart';
import './input_formatter/upper_case_text_formatter.dart';
import '../../config/globals.dart' as globals;

class TextInput extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final name;
  // ignore: prefer_typing_uninitialized_variables
  final String hint;
  final bool enabled;
  final onChanged;
  final validator;
  final onSubmitted;
  final maxLength;
  final onEditingComplete;
  final String initialValue;
  final bool nextAction;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatter;
  const TextInput(
      {this.controller,
      this.enabled = true,
      required this.name,
      required this.hint,
      this.onChanged,
      this.validator,
      this.maxLength,
      this.onSubmitted,
      this.onEditingComplete,
      this.initialValue = "",
      this.inputFormatter,
      required this.nextAction,
      this.autofocus = false,
      Key? key})
      : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  List<TextInputFormatter> _inputFormatter = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.inputFormatter != null) {
      _inputFormatter = widget.inputFormatter!;
      _inputFormatter
          .add(new LengthLimitingTextInputFormatter(widget.maxLength));
    } else {
      _inputFormatter
          .add(new LengthLimitingTextInputFormatter(widget.maxLength));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultInput(
      child: FormBuilderTextField(
        autofocus: widget.autofocus,
        enabled: widget.enabled,
        initialValue: widget.initialValue != "" ? widget.initialValue : null,
        validator: widget.validator,
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
        inputFormatters: _inputFormatter,
        keyboardType: TextInputType.text,
        controller: widget.controller,
        decoration: InputDecoration.collapsed(
          hintText: widget.hint,
          hintStyle: Theme.of(context).textTheme.headline4!,
        ),
      ),
    );
  }
}
