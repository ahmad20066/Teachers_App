import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/constants/global_variables.dart';

class RolesSwitch extends StatelessWidget {
  final VoidCallback onStudentSelected;
  final VoidCallback onTutorSelected;
  final bool isStudentSelected;
  RolesSwitch(
      {super.key,
      required this.onStudentSelected,
      required this.onTutorSelected,
      required this.isStudentSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 200.w,
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Colors.black),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onStudentSelected,
              child: AnimatedContainer(
                margin: EdgeInsets.all(5.sp),
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                    color:
                        isStudentSelected ? GlobalVariables.base : Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    'Student',
                    style: TextStyle(
                      color: isStudentSelected ? Colors.white : Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: onTutorSelected,
              child: AnimatedContainer(
                margin: EdgeInsets.all(5.sp),
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                    color: !isStudentSelected
                        ? GlobalVariables.base
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    'Tutor',
                    style: TextStyle(
                      color: !isStudentSelected ? Colors.white : Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
