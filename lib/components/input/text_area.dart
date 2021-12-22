import 'package:cafe_mostbyte/generated/locale_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import './default_input.dart';
import '../../config/globals.dart' as globals;

class TextArea extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final name;
  // ignore: prefer_typing_uninitialized_variables
  final String hint;
  final onChanged;
  final onSubmitted;
  final onEditingComplete;
  final bool nextAction;
  const TextArea(
      {required this.controller,
      required this.name,
      required this.hint,
      this.onChanged,
      this.onSubmitted,
      this.onEditingComplete,
      required this.nextAction,
      Key? key})
      : super(key: key);

  @override
  _TextAreaState createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> {
  int maxCnt = 1200;
  int _symbol = 1200;

  @override
  Widget build(BuildContext context) {
    var loc = Localizations.of<LocaleBase>(context, LocaleBase)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).hintColor,
              ),
              borderRadius: BorderRadius.circular(8)),
          child: FormBuilderTextField(
            textInputAction:
                widget.nextAction ? TextInputAction.next : TextInputAction.done,
            onChanged: (val) {
              setState(() {
                _symbol = maxCnt - val!.length;
              });
              widget.onChanged(val);
            },
            onSubmitted: widget.onSubmitted,
            onEditingComplete: widget.onEditingComplete,
            name: widget.name,
            maxLines: 5,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Theme.of(context).indicatorColor,
                ),
            keyboardType: TextInputType.text,
            controller: widget.controller,
            decoration: InputDecoration.collapsed(
              hintText: widget.hint,
              hintStyle: Theme.of(context).textTheme.headline4!,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            "осталось ${_symbol} символов",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        )
      ],
    );
  }
}
