import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/models/subject/subject_model.dart';

import '../../../../constants/global_variables.dart';

class SubjectDropwDown extends StatelessWidget {
  final List<SubjectModel> subjects;
  final Function(SubjectModel?)? onChanged;
  final SubjectModel value;
  const SubjectDropwDown(
      {super.key, required this.subjects, this.onChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    print(subjects[0] == value);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Subject :",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
              color: GlobalVariables.base),
        ),
        SizedBox(
          width: 20.w,
        ),
        Container(
          width: 150.w,
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: GlobalVariables.base)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<SubjectModel>(
              borderRadius: BorderRadius.circular(10),
              value: value,
              items: subjects
                  .map((e) => DropdownMenuItem<SubjectModel>(
                        child: Text(
                          e.subject_name,
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        value: e,
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
