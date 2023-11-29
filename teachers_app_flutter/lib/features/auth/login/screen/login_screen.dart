import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/common/widgets/custom_button.dart';
import 'package:teachers_app/common/widgets/custom_textfield.dart';
import 'package:teachers_app/constants/global_variables.dart';
import 'package:teachers_app/features/auth/forgot_password/screen/forgot_password_screen.dart';
import 'package:teachers_app/features/auth/login/cubit/login_cubit.dart';
import 'package:teachers_app/features/auth/login/widgets/signup_text.dart';
import 'package:teachers_app/features/auth/register/widgets/avatar.dart';
import 'package:teachers_app/features/main/tabs/tab_screen.dart';
import 'package:teachers_app/router.dart';

import '../../../main/tabs/tabs.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = '/login';
  final Role role;
  LogInScreen({super.key, required this.role});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailControlelr = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool obscure = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ));
        } else if (state is LoginSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              generateRoute(RouteSettings(name: MainTabsScreen.routeName)),
              (route) => false);
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 70.h,
              ),
              Avatar(isTeacher: true),
              SizedBox(
                height: 20.h,
              ),
              CustomTextFiled(
                  textController: emailControlelr,
                  labelText: 'Email',
                  vMargin: 10),
              CustomTextFiled(
                  textController: passwordController,
                  labelText: 'Password',
                  isPrivate: obscure,
                  suffix: IconButton(
                      onPressed: () {
                        setState(() {});
                        obscure = !obscure;
                      },
                      icon: Icon(
                          obscure ? Icons.visibility : Icons.visibility_off)),
                  vMargin: 10),
              Align(
                alignment: Alignment(-0.8, 1),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        generateRoute(RouteSettings(
                            name: ForgotPasswordScreen.routeName)));
                  },
                  child: Text('Forgot Password'),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                text: 'Log In',
                onTap: () {
                  BlocProvider.of<LoginCubit>(context)
                      .logIn(emailControlelr.text, passwordController.text);
                },
                width: 160.w,
              ),
              SizedBox(
                height: 10.h,
              ),
              SignUpText(
                role: widget.role,
              )
            ],
          ),
        );
      },
    ));
  }
}
