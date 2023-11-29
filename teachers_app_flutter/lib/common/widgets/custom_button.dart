import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  String text = 'click';
  final VoidCallback? onTap;
  bool fill;
  double? height, width;
  final Color? color;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;
  CustomButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.fill = true,
      this.height,
      this.color,
      this.width,
      this.padding,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        height: height ?? 50.h,
        width: width,
        margin: margin ?? EdgeInsets.only(top: 10.h, right: 50.w, left: 50.w),
        decoration: BoxDecoration(
            // gradient: LinearGradient(colors: [
            //   GlobalVariables.base,
            //   GlobalVariables.base,
            //   Colors.white
            // ]),
            borderRadius: BorderRadius.circular(10),
            color: color ?? GlobalVariables.base),
        //width: MediaQuery.of(context).size.width / 1.5,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: fill ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ));
  }
}
