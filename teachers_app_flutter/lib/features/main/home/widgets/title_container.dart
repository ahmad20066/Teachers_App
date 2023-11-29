import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/constants/global_variables.dart';

class TitleContainer extends StatelessWidget {
  final String text;
  final String? subtitle;
  final Color color;
  Alignment? alignment;
  TitleContainer(
      {super.key,
      required this.text,
      this.subtitle,
      this.alignment,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment(-1, -1),
      child: Container(
        decoration: BoxDecoration(
            // color: GlobalVariables.base,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10))),
        alignment: alignment ?? Alignment(-0.8, 0),
        height: 70.h,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 28.sp),
            ),
            SizedBox(
              height: 3.h,
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: TextStyle(color: Colors.black38),
              )
          ],
        ),
      ),
    );
  }
}
