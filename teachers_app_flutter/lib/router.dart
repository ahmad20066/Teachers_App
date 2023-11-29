import 'package:flutter/material.dart';
import 'package:teachers_app/constants/global_variables.dart';
import 'package:teachers_app/features/auth/forgot_password/screen/forgot_password_screen.dart';
import 'package:teachers_app/features/auth/login/screen/login_screen.dart';
import 'package:teachers_app/features/auth/register/screens/permission_screen.dart';
import 'package:teachers_app/features/auth/register/screens/role_screen.dart';
import 'package:teachers_app/features/auth/register/screens/setup_profile.dart';
import 'package:teachers_app/features/auth/register/screens/verification_screen.dart';
import 'package:teachers_app/features/auth/register/screens/welcome.dart';
import 'package:teachers_app/features/main/search/screens/tutor_details.dart';
import 'package:teachers_app/features/main/search/screens/tutors_screen.dart';
import 'package:teachers_app/features/main/tabs/tab_screen.dart';
import 'package:teachers_app/features/main/schedule/screens/request_history.dart';
import 'package:teachers_app/features/main/tabs/tabs.dart';
import 'package:teachers_app/features/settings/screen/change_password_screen.dart';
import 'package:teachers_app/features/settings/screen/notifications/teacher_requests.dart';
import 'package:teachers_app/models/tutor/tutor_model.dart';

import 'features/auth/register/screens/register_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LogInScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => LogInScreen(
                role: (settings.arguments as Map)['role'] == 'tutor'
                    ? Role.tutor
                    : Role.student,
              ));
    // case RegisterScreen.routeName:
    //   return MaterialPageRoute(
    //       builder: (context) => RegisterScreen(
    //           role: (settings.arguments! as Map)['role'] as String));
    case TabsScreen.routeName:
      return MaterialPageRoute(builder: (context) => TabsScreen());
    case MainTabsScreen.routeName:
      return MaterialPageRoute(builder: (context) => MainTabsScreen());
    case VerificationScreen.routeName:
      final email = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => VerificationScreen(
                email: email,
              ));
    case ChangePasswordScreen.routeName:
      return MaterialPageRoute(builder: (context) => ChangePasswordScreen());
    case TeacherRequests.routeName:
      return MaterialPageRoute(builder: (context) => TeacherRequests());
    case ForgotPasswordScreen.routeName:
      return MaterialPageRoute(builder: (context) => ForgotPasswordScreen());
    case RoleScreen.routeName:
      return MaterialPageRoute(builder: (context) => RoleScreen());
    case PermissionScreen.routeName:
      return MaterialPageRoute(builder: (context) => PermissionScreen());
    case StudentRequestHistory.routeName:
      return MaterialPageRoute(builder: (context) => StudentRequestHistory());
    case WelcomeScreen.routeName:
      final name = settings.arguments as String;
      // final name = 'Mariam';
      return MaterialPageRoute(
          builder: (context) => WelcomeScreen(
                name: name,
              ));
    case TutorDetails.routeName:
      return MaterialPageRoute(
          builder: (context) => TutorDetails(
                tutor: settings.arguments as TutorModel,
              ));
    case TutorsScreen.routeName:
      return MaterialPageRoute(
          builder: (context) =>
              TutorsScreen(subject: settings.arguments as String));
    case SetUpProfile.routeName:
      return MaterialPageRoute(
          builder: (context) => SetUpProfile(
                role: (settings.arguments as Map)['role'] == 'tutor'
                    ? Role.tutor
                    : Role.student,
              ));
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("this page doesn't exist"),
                ),
              ));
  }
}
