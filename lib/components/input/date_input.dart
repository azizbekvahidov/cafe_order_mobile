import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import './default_input.dart';
import '../../config/globals.dart' as globals;

class DateInput extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final name;
  // ignore: prefer_typing_uninitialized_variables
  final String hint;
  final onChanged;
  final validator;
  final onSubmitted;
  final onEditingComplete;
  final String initialValue;
  final bool nextAction;
  final bool isRequired;
  const DateInput(
      {this.controller,
      required this.name,
      required this.hint,
      this.onChanged,
      this.validator,
      this.onSubmitted,
      this.onEditingComplete,
      this.initialValue = "",
      required this.nextAction,
      this.isRequired = false,
      Key? key})
      : super(key: key);

  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  @override
  Widget build(BuildContext context) {
    DateTime.parse(widget.initialValue);
    return DefaultInput(
      isRequired: widget.isRequired,
      child: FormBuilderDateTimePicker(
        cursorColor: Theme.of(context).indicatorColor,
        initialValue: widget.initialValue != ""
            ? DateTime.parse(widget.initialValue)
            : null,
        firstDate: DateTime(1970),
        lastDate: DateTime.now(),
        validator: widget.validator,
        format: DateFormat("dd.MM.yyyy"),
        initialEntryMode: DatePickerEntryMode.calendar,
        textInputAction:
            widget.nextAction ? TextInputAction.next : TextInputAction.done,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        onEditingComplete: widget.onEditingComplete,
        name: widget.name,
        maxLines: 1,
        locale: Locale(globals.lang),
        style: Theme.of(context).textTheme.headline4!.copyWith(
              color: Theme.of(context).indicatorColor,
            ),
        inputType: InputType.date,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: Container(
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
              child: SvgPicture.asset("assets/img/Calendar.svg"),
            ),
          ),
          border: InputBorder.none,
          hintText: widget.hint,
          contentPadding: const EdgeInsets.only(bottom: 12),
          hintStyle: Theme.of(context).textTheme.headline4!,
        ),
      ),
    );
  }
}
