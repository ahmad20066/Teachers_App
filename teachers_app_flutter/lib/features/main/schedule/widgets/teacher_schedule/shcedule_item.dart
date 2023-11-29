import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/models/request/request_model.dart';

class ScheduleItem extends StatelessWidget {
  final RequestModel request;
  const ScheduleItem({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.sp),
      height: 100.h,
      // padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Transform.rotate(
              angle: -90 * (pi / 180), // Convert degrees to radians
              child: Text(
                DateFormat("EEEE").format(request.date).toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 22.sp),
              )),
          SizedBox(
            width: 10.w,
          ),
          Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  request.student.name,
                  style: TextStyle(color: Colors.black, fontSize: 18.sp),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Text(
                    DateFormat(DateFormat.HOUR_MINUTE).format(request.date),
                    style: TextStyle(fontSize: 17.sp),
                  ),
                  Text(' , '),
                  Text(
                    request.subject!.toUpperCase(),
                    style: TextStyle(fontSize: 17.sp),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
