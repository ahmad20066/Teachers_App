import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:teachers_app/features/main/home/screens/home_screen.dart';
import 'package:teachers_app/features/main/schedule/screens/schedule_screen.dart';
import 'package:teachers_app/features/main/search/screens/search_screen.dart';
import 'package:teachers_app/features/settings/screen/settings_screen.dart';
import 'package:teachers_app/features/settings/screen/notifications/teacher_requests.dart';

import '../../../constants/global_variables.dart';
import '../../auth/profile/cubit/user_cubit.dart';

class StudentTabsScreen extends StatefulWidget {
  static const routeName = '/tabs';
  @override
  State<StudentTabsScreen> createState() => _StudentTabsScreenState();
}

class _StudentTabsScreenState extends State<StudentTabsScreen> {
  // final List<IconData> icons = [Icons.note, Icons.monetization_on];
  int currentIndex = 1;

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context, listen: false).fetchCurrentUser();
    super.initState();
  }

  List<Widget> screens = [
    SearchScreen(),
    ScheduleScreen(),
    HomeScreen(),
    SettingsScreen(),
  ];
  List<Widget> icons = [
    Icon(
      Icons.search,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.schedule,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.home,
      size: 30.sp,
      color: Colors.white,
    ),
    Icon(
      Icons.settings,
      size: 30.sp,
      color: Colors.white,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
                height: 70.h,
                index: currentIndex,
                backgroundColor: Colors.white.withOpacity(0),
                color: GlobalVariables.base,

                // leftCornerRadius: 30,
                // rightCornerRadius: 30,
                items: icons,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                }),
            body: screens[currentIndex],
          );
        } else if (state is UserLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold();
      },
    );
  }
}
