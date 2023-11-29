import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/constants/global_variables.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(15.sp),
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(color: GlobalVariables.base),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Teachers App',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold),
          ),
          Image.asset(
            'assets/images/appbar.png',
            // height: 60.h,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
