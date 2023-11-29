import 'package:flutter/material.dart';
import 'package:teachers_app/constants/global_variables.dart';

class GenderRadio extends StatefulWidget {
  final Function(String?)? onChanged;
  String gender;

  GenderRadio({super.key, required this.onChanged, required this.gender});

  @override
  State<GenderRadio> createState() => _GenderRadioState();
}

class _GenderRadioState extends State<GenderRadio> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Radio(
                activeColor: GlobalVariables.base,
                value: 'male',
                groupValue: widget.gender,
                onChanged: widget.onChanged),
            Text('Male'),
          ],
        ),
        Row(
          children: [
            Radio(
                activeColor: GlobalVariables.base,
                value: 'female',
                groupValue: widget.gender,
                onChanged: widget.onChanged),
            Text('Female'),
          ],
        ),
      ],
    );
  }
}
