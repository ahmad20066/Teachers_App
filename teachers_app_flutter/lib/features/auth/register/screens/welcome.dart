import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/common/widgets/custom_button.dart';
import 'package:teachers_app/features/auth/register/screens/permission_screen.dart';
import 'package:teachers_app/features/main/home/widgets/title_container.dart';
import 'package:teachers_app/router.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome';
  final String name;
  const WelcomeScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 80.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 50..w,
              ),
              Image.asset(
                'assets/images/logo.png',
                height: 85.h,
              ),
              Container(
                decoration: BoxDecoration(
                    // color: GlobalVariables.base,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10))),
                height: 100.h,
                child: Text(
                  '''
Tutor
Assistance
App''',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28.sp),
                ),
              ),
            ],
          ),
          Spacer(),
          TitleContainer(
            text: 'Welcome $name!',
            alignment: Alignment.center,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            '''It’s a pleasure to meet you. We are
excited that you’re here so let’s get
                       started! ''',
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(134, 134, 134, 1)),
          ),
          SizedBox(
            height: 50.h,
          ),
          CustomButton(
              text: 'Get Started',
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    generateRoute(
                        RouteSettings(name: PermissionScreen.routeName)));
              }),
          SizedBox(
            height: 150.h,
          )
        ],
      ),
    );
  }
}
