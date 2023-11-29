import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/features/main/schedule/screens/request_history.dart';
import 'package:teachers_app/features/main/schedule/screens/teacher_schedule.dart';
import 'package:teachers_app/features/settings/screen/notifications/teacher_requests.dart';

import '../../../../constants/global_variables.dart';
import '../../../auth/profile/cubit/user_cubit.dart';
import '../widgets/student_requests/student_requests_list.dart';
import '../../../settings/widgets/teacher requests/teacher_requests_list.dart';
import '../../home/widgets/title_container.dart';
import '../cubit/request_cubit.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          if (state.user.user.role == Role.student) {
            return StudentRequestHistory();
          } else {
            return TeacherSchedule();
          }
        } else if (state is UserLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UserError) {
          return Center(
            child: Text(state.error),
          );
        }
        return Column();
      },
    );
  }
}
