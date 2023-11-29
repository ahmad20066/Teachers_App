import 'package:flutter/material.dart';
import 'package:teachers_app/features/main/schedule/widgets/teacher_schedule/shcedule_item.dart';

import '../../../../../models/request/request_model.dart';

class ScheduleList extends StatelessWidget {
  final List<RequestModel> requests;
  const ScheduleList({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        return ScheduleItem(request: requests[index]);
      },
    );
  }
}
