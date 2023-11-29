import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/features/main/search/screens/tutors_screen.dart';
import 'package:teachers_app/models/subject/subject_model.dart';
import 'package:teachers_app/router.dart';

import '../../../../constants/endpoints.dart';

class SubjectItem extends StatelessWidget {
  final SubjectModel subject;
  const SubjectItem({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            generateRoute(RouteSettings(
                arguments: subject.id, name: TutorsScreen.routeName)));
      },
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Image.network(
              "${EndPoints.baseUrl}/${subject.image}",
              height: 45.h,
              width: 45.w,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              subject.subject_name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
            )
          ],
        ),
      ),
    );
  }
}
