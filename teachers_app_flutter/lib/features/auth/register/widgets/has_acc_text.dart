import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:teachers_app/constants/global_variables.dart';
import 'package:teachers_app/features/auth/login/screen/login_screen.dart';
import 'package:teachers_app/router.dart';

class HasAccountText extends StatelessWidget {
  const HasAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-0.7, 1),
      child: RichText(
        text: TextSpan(
            text: "Already have an account?",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            children: [
              TextSpan(
                  text: ' Log In instead',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pop(context);
                    },
                  style: TextStyle(
                      color: GlobalVariables.base,
                      fontWeight: FontWeight.normal))
            ]),
      ),
    );
  }
}
