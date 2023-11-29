import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/features/main/tabs/student_tab_screen.dart';
import 'package:teachers_app/features/main/tabs/tab_screen.dart';

import '../../../constants/global_variables.dart';
import '../../auth/profile/cubit/user_cubit.dart';

class MainTabsScreen extends StatefulWidget {
  static const routeName = '/mainTabs';
  const MainTabsScreen({super.key});

  @override
  State<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context, listen: false).fetchCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            if (state.user.user.role == Role.tutor) {
              return TabsScreen();
            } else {
              return StudentTabsScreen();
            }
          } else if (state is UserLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold();
        },
      ),
    );
  }
}
