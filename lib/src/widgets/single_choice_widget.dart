import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

class SingleChoiceWidget extends StatelessWidget {
  final int index;
  final Function(int) onChanged;
  final List<String> items;
  SingleChoiceWidget({
    @required this.index,
    @required this.onChanged,
    @required this.items,
  });
  @override
  Widget build(BuildContext context) {
    return ChipsChoice<int>.single(
      value: index,
      onChanged: onChanged,
      choiceItems: C2Choice.listFrom<int, String>(
        source: items,
        value: (i, v) => i,
        label: (i, v) => v,
        tooltip: (i, v) => v,
      ),
      choiceStyle: C2ChoiceStyle(
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      // wrapped: true,
    );
  }
}
