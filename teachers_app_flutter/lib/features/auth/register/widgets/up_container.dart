import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/constants/global_variables.dart';

class UpContainer extends StatelessWidget {
  const UpContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        alignment: Alignment.center,
        height: 100.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: GlobalVariables.base,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(55.sp),
              bottomLeft: Radius.circular(55.sp),
            )),
        child: Text(
          'Set Up Your Profile',
          style: TextStyle(
              color: Colors.white,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
