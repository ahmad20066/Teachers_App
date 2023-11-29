import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/features/main/home/widgets/title_container.dart';
import 'package:teachers_app/features/main/schedule/cubit/cubit/schedule_cubit.dart';
import 'package:teachers_app/features/main/schedule/widgets/teacher_schedule/schedule_list.dart';

import '../cubit/request_cubit.dart';

class TeacherSchedule extends StatefulWidget {
  const TeacherSchedule({super.key});

  @override
  State<TeacherSchedule> createState() => _TeacherScheduleState();
}

class _TeacherScheduleState extends State<TeacherSchedule> {
  @override
  void initState() {
    BlocProvider.of<ScheduleCubit>(context).getTeacherSchedule();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          TitleContainer(text: 'Schedule'),
          BlocBuilder<ScheduleCubit, ScheduleState>(
            builder: (context, state) {
              if (state is ScheduleLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ScheduleLoaded) {
                return ScheduleList(requests: state.requests);
              }
              return Column();
            },
          ),
        ],
      ),
    );
  }
}
