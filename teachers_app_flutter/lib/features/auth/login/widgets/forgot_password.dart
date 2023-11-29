import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final VoidCallback onTap;
  const ForgotPassword({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-0.85, 1),
      child: InkWell(
          onTap: onTap,
          child: Text(
            'Forgot Password?',
            style: TextStyle(
                decoration: TextDecoration.underline, color: Colors.blue),
          )),
    );
  }
}
