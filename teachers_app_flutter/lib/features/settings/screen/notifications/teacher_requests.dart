import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/features/settings/widgets/teacher%20requests/teacher_requests_list.dart';

import '../../../main/schedule/cubit/request_cubit.dart';

class TeacherRequests extends StatefulWidget {
  static const routeName = '/teacher-requests';
  const TeacherRequests({super.key});

  @override
  State<TeacherRequests> createState() => _TeacherRequestsState();
}

class _TeacherRequestsState extends State<TeacherRequests> {
  @override
  void initState() {
    BlocProvider.of<RequestCubit>(context).getTeacherRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RequestCubit, RequestState>(
        builder: (context, state) {
          if (state is RequestLoaded) {
            return Column(
              children: [RequestsList(requests: state.requests)],
            );
          }
          if (state is RequestsEmpty) {
            return Center(
              child: Text('No Requests'),
            );
          }
          if (state is RequestsListLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
