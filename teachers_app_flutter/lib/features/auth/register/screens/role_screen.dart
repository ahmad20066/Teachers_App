import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/common/widgets/custom_button.dart';
import 'package:teachers_app/constants/global_variables.dart';
import 'package:teachers_app/features/auth/login/screen/login_screen.dart';
import 'package:teachers_app/features/auth/register/screens/register_screen.dart';
import 'package:teachers_app/features/auth/register/screens/setup_profile.dart';
import 'package:teachers_app/features/main/home/widgets/title_container.dart';
import 'package:teachers_app/router.dart';

class RoleScreen extends StatefulWidget {
  static const routeName = '/roles';
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  int _selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 70.h,
          ),
          Text(
            "Welcome!",
            style: TextStyle(
                color: Color.fromRGBO(105, 28, 193, 1),
                fontWeight: FontWeight.bold,
                fontSize: 35.sp),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              children: [
                SizedBox(height: 16.0),
                Stack(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/teacher.png',
                          height: 225.h,
                          width: 235.w,
                        ),
                        Text(
                          'Teacher',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Color.fromRGBO(105, 28, 193, 1),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      right: 0,
                      child: Transform.scale(
                        scale: 2,
                        child: Radio(
                            activeColor: GlobalVariables.base,
                            value: 1,
                            groupValue: _selectedindex,
                            onChanged: (value) {
                              setState(() {
                                _selectedindex = value!;
                              });
                            }),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Stack(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/student.png',
                          height: 225.h,
                          width: 225.w,
                        ),
                        Text(
                          'Student',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Color.fromRGBO(105, 28, 193, 1),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      right: 0,
                      child: Transform.scale(
                        scale: 2,
                        child: Radio(
                            activeColor: GlobalVariables.base,
                            value: 2,
                            groupValue: _selectedindex,
                            onChanged: (value) {
                              setState(() {
                                _selectedindex = value!;
                              });
                            }),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Align(
                    child: CustomButton(
                        // margin: EdgeInsets.only(left: 60.w),
                        width: 150.w,
                        text: "Go",
                        onTap: () {
                          if (_selectedindex == 1) {
                            Navigator.push(
                                context,
                                generateRoute(RouteSettings(
                                    name: LogInScreen.routeName,
                                    arguments: {'role': 'tutor'})));
                          } else if (_selectedindex == 2) {
                            Navigator.push(
                                context,
                                generateRoute(RouteSettings(
                                    name: LogInScreen.routeName,
                                    arguments: {'role': 'student'})));
                          } else {
                            return;
                          }
                        }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
