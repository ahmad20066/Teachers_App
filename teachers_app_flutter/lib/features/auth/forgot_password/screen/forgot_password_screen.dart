import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/common/widgets/custom_button.dart';
import 'package:teachers_app/common/widgets/custom_textfield.dart';
import 'package:teachers_app/features/auth/forgot_password/cubit/forgot_cubit.dart';
import 'package:teachers_app/features/auth/login/screen/login_screen.dart';
import 'package:teachers_app/features/auth/register/widgets/avatar.dart';
import 'package:teachers_app/features/main/home/widgets/title_container.dart';
import 'package:teachers_app/router.dart';

import '../../register/cubit/register_cubit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot';
  ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController codeController = TextEditingController();

  bool isVerified = false;
  String email = '';
  bool obscure = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70.h,
            ),
            TitleContainer(text: "Forgot Password"),
            Avatar(isTeacher: true),
            SizedBox(
              height: 20.h,
            ),
            BlocConsumer<ForgotCubit, ForgotState>(
              listener: (context, state) {
                if (state is ForgotError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.error),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.red,
                  ));
                } else if (state is ForgotSuccess) {
                  Navigator.pushReplacement(
                      context,
                      generateRoute(
                          RouteSettings(name: LogInScreen.routeName)));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Password changed successfully'),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.green,
                  ));
                }
              },
              builder: (context, state) {
                if (state is ForgotLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!isVerified)
                        Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            BlocConsumer<RegisterCubit, RegisterState>(
                              listener: (context, state) {
                                if (state is CodeSent) {
                                  email = emailController.text;
                                  print(email);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Code Sent to your email"),
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.green,
                                  ));
                                }
                                //  else if (state is CodeError) {
                                //   ScaffoldMessenger.of(context)
                                //       .showSnackBar(SnackBar(
                                //     content: Text(state.error),
                                //     duration: Duration(seconds: 3),
                                //     backgroundColor: Colors.red,
                                //   ));
                                // }
                                else if (state is VerifySuccess) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Code Verified"),
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.green,
                                  ));
                                  isVerified = true;
                                  setState(() {});
                                  codeController.clear();
                                }
                                // else if (state is VerifyError) {
                                //   ScaffoldMessenger.of(context)
                                //       .showSnackBar(SnackBar(
                                //     content: Text(state.error),
                                //     duration: Duration(seconds: 3),
                                //     backgroundColor: Colors.red,
                                //   ));
                                // }
                              },
                              builder: (context, state) {
                                if (state is SendingCode ||
                                    state is VerifyLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is CodeSent ||
                                    state is VerifyError) {
                                  return Column(
                                    children: [
                                      CustomTextFiled(
                                          textController: codeController,
                                          labelText: 'Code',
                                          vMargin: 10),
                                      CustomButton(
                                          text: 'Submit',
                                          width: 120.w,
                                          height: 50.h,
                                          onTap: () async {
                                            await BlocProvider.of<
                                                    RegisterCubit>(context)
                                                .confirmCode(
                                                    email, codeController.text);
                                          }),
                                    ],
                                  );
                                } else if (state is VerifySuccess) {
                                  return CustomButton(
                                    text: 'Submit',
                                    onTap: null,
                                    width: 120.w,
                                    color: Colors.grey,
                                    height: 50.h,
                                  );
                                }
                                return Column(
                                  children: [
                                    CustomTextFiled(
                                        textController: emailController,
                                        labelText: 'Email',
                                        vMargin: 20),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    CustomButton(
                                        text: 'Send Code',
                                        width: 160.w,
                                        height: 50.h,
                                        onTap: () async {
                                          await BlocProvider.of<RegisterCubit>(
                                                  context)
                                              .sendCode(emailController.text);
                                        }),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      if (isVerified)
                        CustomTextFiled(
                            textController: passwordController,
                            labelText: 'new password',
                            isPrivate: obscure,
                            suffix: IconButton(
                                onPressed: () {
                                  setState(() {});
                                  obscure = !obscure;
                                },
                                icon: Icon(obscure
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            vMargin: 10),
                      SizedBox(
                        height: 20.h,
                      ),
                      if (isVerified)
                        CustomButton(
                            text: 'Submit',
                            color: !isVerified ? Colors.grey : null,
                            onTap: !isVerified
                                ? () {}
                                : () {
                                    print(emailController.text);
                                    print(passwordController.text);
                                    BlocProvider.of<ForgotCubit>(context)
                                        .forgotPassword(emailController.text,
                                            passwordController.text);
                                  })
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
