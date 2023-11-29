// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../constants/global_variables.dart';

class CustomTextFiled extends StatelessWidget {
  TextEditingController textController;

  String labelText;

  Widget? preIcon;

  bool isPrivate;

  double vMargin;
  Widget? suffix;
  bool ltr;
  String? hintText;
  int? max, min;
  TextInputAction? action;
  TextInputType? type;
  var onChanged;
  bool enabled;
  CustomTextFiled(
      {Key? key,
      required this.textController,
      required this.labelText,
      this.preIcon,
      required this.vMargin,
      this.max,
      this.onChanged,
      this.min,
      this.ltr = false,
      this.suffix,
      this.action,
      this.enabled = true,
      this.hintText,
      this.type,
      this.isPrivate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: vMargin),
      child: TextFormField(
          enabled: enabled,
          onChanged: onChanged,
          textDirection: ltr ? TextDirection.ltr : null,
          obscureText: isPrivate,
          controller: textController,
          textInputAction: action ?? TextInputAction.next,
          keyboardType: type,
          decoration: InputDecoration(
              prefixIcon: preIcon,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalVariables.base),
                  borderRadius: BorderRadius.circular(10)),
              suffixIcon: suffix,
              isDense: true,
              hintText: hintText,
              labelStyle: TextStyle(color: GlobalVariables.base),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black38),
                  borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalVariables.base),
                  borderRadius: BorderRadius.circular(10)),
              label: Text(labelText))),
    );
  }
}
