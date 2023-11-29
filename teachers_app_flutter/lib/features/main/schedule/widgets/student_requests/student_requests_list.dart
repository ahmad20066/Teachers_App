import 'package:flutter/material.dart';
import 'package:teachers_app/features/main/schedule/widgets/student_requests/request_item.dart';
import 'package:teachers_app/models/request/request_model.dart';

class StudentRequestsList extends StatelessWidget {
  final List<RequestModel> requests;
  const StudentRequestsList({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        return RequestItem(request: requests[index], isTeacher: false);
      },
    );
  }
}
