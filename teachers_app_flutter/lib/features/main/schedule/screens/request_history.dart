import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/features/main/home/widgets/title_container.dart';
import 'package:teachers_app/features/main/schedule/widgets/student_requests/student_requests_list.dart';

import '../cubit/request_cubit.dart';

class StudentRequestHistory extends StatefulWidget {
  static const routeName = '/history';

  @override
  State<StudentRequestHistory> createState() => _StudentRequestHistoryState();
}

class _StudentRequestHistoryState extends State<StudentRequestHistory> {
  @override
  void initState() {
    BlocProvider.of<RequestCubit>(context).getRequestsStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RequestCubit, RequestState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          print(state);
          if (state is RequestsListLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RequestLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  TitleContainer(text: 'Requests'),
                  StudentRequestsList(requests: state.requests),
                ],
              ),
            );
          } else if (state is RequestsEmpty) {
            return Center(
              child: Text('No Requests'),
            );
          } else {
            return Container(
              color: Colors.white,
            );
          }
        },
      ),
    );
  }
}
