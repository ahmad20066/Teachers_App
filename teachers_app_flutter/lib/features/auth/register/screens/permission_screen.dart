import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/common/widgets/custom_button.dart';
import 'package:teachers_app/features/auth/register/screens/welcome.dart';
import 'package:teachers_app/features/main/home/widgets/title_container.dart';
import 'package:teachers_app/router.dart';

import '../../../main/tabs/tab_screen.dart';
import '../../../main/tabs/tabs.dart';

class PermissionScreen extends StatelessWidget {
  static const routeName = '/permission';
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
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
        SizedBox(
          height: 140.h,
        ),
        TitleContainer(
          text: 'Request Permission',
          alignment: Alignment.center,
        ),
        SizedBox(
          height: 60.h,
        ),
        Text(
          ''' this application requires you to have
 an access of your location and your
 playstore account details ''',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(134, 134, 134, 1)),
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          '''please click the button if you agree
with the necessary permission this
application requires ''',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(134, 134, 134, 1)),
        ),
        Spacer(),
        CustomButton(
            text: 'I AGREE',
            onTap: () {
              Navigator.of(context).push(
                  generateRoute(RouteSettings(name: MainTabsScreen.routeName)));
            }),
        SizedBox(
          height: 80.h,
        ),
      ]),
    );
  }
}
