import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/constants/global_variables.dart';
import 'package:teachers_app/features/auth/register/screens/register_screen.dart';
import 'package:teachers_app/features/auth/register/screens/setup_profile.dart';
import 'package:teachers_app/router.dart';

class SignUpText extends StatelessWidget {
  final Role role;
  const SignUpText({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-0.7, 1),
      child: RichText(
        text: TextSpan(
            text: 'Don`t Have An Account? ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          generateRoute(RouteSettings(
                              name: SetUpProfile.routeName,
                              arguments: {
                                'role':
                                    role == Role.student ? 'student' : 'tutor'
                              })));
                    },
                  text: 'Sign Up Instead',
                  style: TextStyle(color: GlobalVariables.base))
            ]),
      ),
    );
  }
}
