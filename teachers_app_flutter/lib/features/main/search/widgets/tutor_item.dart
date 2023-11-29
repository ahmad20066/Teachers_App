import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/constants/endpoints.dart';
import 'package:teachers_app/constants/global_variables.dart';
import 'package:teachers_app/features/main/search/screens/tutor_details.dart';
import 'package:teachers_app/models/tutor/tutor_model.dart';
import 'package:teachers_app/router.dart';

class TutorItem extends StatelessWidget {
  final TutorModel tutor;
  const TutorItem({super.key, required this.tutor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            generateRoute(
                RouteSettings(name: TutorDetails.routeName, arguments: tutor)));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10.sp),
        child: Row(
          children: [
            SizedBox(
              width: 180.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  '${EndPoints.baseUrl}/${tutor.user.image}',
                  height: 150.h,
                  width: 180.w,
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: GlobalVariables.base,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(tutor.user.name),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: GlobalVariables.base,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(tutor.user.phone_number),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        color: GlobalVariables.base),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(tutor.user.location),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Icon(Icons.subject, color: GlobalVariables.base),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(tutor.state.subject_name),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(tutor.rating!.toString())
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
