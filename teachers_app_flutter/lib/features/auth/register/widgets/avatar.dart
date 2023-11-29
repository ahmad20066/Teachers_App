import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/constants/global_variables.dart';

class Avatar extends StatelessWidget {
  bool isTeacher = false;
  Avatar({super.key, required this.isTeacher});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CircleAvatar(
        radius: 110.sp,
        backgroundColor: Color.fromRGBO(140, 140, 140, 0.2),
        child: Image(image: AssetImage('assets/images/logo.png')),
      ),
    );
  }
}
