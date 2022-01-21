import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../input/default_input.dart';
import '../../generated/locale_base.dart';

class CustomRangeSlider extends StatefulWidget {
  final name;
  // ignore: prefer_typing_uninitialized_variables
  final String hint;
  final onTap;
  final Function? onChange;
  final String result;
  final double min;
  final double max;
  final int division;
  final RangeValues range;
  const CustomRangeSlider({
    required this.name,
    required this.hint,
    this.onTap,
    this.onChange,
    required this.result,
    required this.min,
    required this.max,
    required this.division,
    this.range = const RangeValues(0.0, 0.0),
    Key? key,
  }) : super(key: key);

  @override
  _CustomRangeSliderState createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  double? _min = 0.0;
  double? _max = 0.0;
  @override
  void initState() {
    super.initState();

    if (widget.result != "") {
      var temp = widget.result.split(",");
      _min = double.tryParse(temp[0]);
      _max = double.tryParse(temp[1]);
    } else {
      _min = widget.range.start;
      _max = widget.range.end;
    }
    // _age = widget.result == 0 ? 3.0 : widget.result.toDouble();
  }

  void slideChange(val) {
    setState(() {
      _min = val.start;
      _max = val.end;
    });
  }

  @override
  Widget build(BuildContext context) {
    var loc = Localizations.of<LocaleBase>(context, LocaleBase)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          DefaultInput(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.hint,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontSize: 12),
                ),
                Text(
                  "${_min!.toInt()} - ${_max!.toInt()}",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                )
              ],
            ),
          )),
          FormBuilderRangeSlider(
            initialValue: RangeValues(_min!, _max!),
            name: widget.name,
            min: widget.min,
            max: widget.max,
            onChanged: (val) {
              widget.onChange!(val);
              slideChange(val);
            },
            divisions: widget.division,
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Theme.of(context).hintColor,
            displayValues: DisplayValues.minMax,
            decoration: InputDecoration(
              disabledBorder: InputBorder.none,
              enabled: false,
            ),
          ),
        ],
      ),
    );
  }
}
