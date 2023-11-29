import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/common/widgets/custom_button.dart';
import 'package:teachers_app/features/auth/register/widgets/avatar.dart';

import '../../../../common/widgets/custom_textfield.dart';
import '../cubit/register_cubit.dart';

class VerificationScreen extends StatefulWidget {
  static const routeName = '/verify';
  final String email;

  const VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  // const VerificationScreen({super.key});
  TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<RegisterCubit>(context).sendCode(widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 70.h,
              ),
              Avatar(isTeacher: true),
              SizedBox(
                height: 20.h,
              ),
              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is VerifySuccess) {
                    Navigator.pop(context, true);
                  } else if (state is VerifyError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.error),
                      duration: Duration(seconds: 4),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is SendingCode) {
                    return CircularProgressIndicator();
                  }

                  if (state is CodeSent || state is VerifyError) {
                    return Column(
                      children: [
                        CustomTextFiled(
                          textController: codeController,
                          labelText: 'Verification Code',
                          vMargin: 10,
                          action: TextInputAction.done,
                          hintText: 'Enter Code Sent to your email',
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomButton(
                            text: 'Submit',
                            onTap: () async {
                              await BlocProvider.of<RegisterCubit>(context)
                                  .confirmCode(
                                      widget.email, codeController.text);
                            })
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
// BlocConsumer<RegisterCubit, RegisterState>(
//                   listener: (context, state) {
//                     if (emailController.text.isEmpty ||
//                         passwordController.text.isEmpty) {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Text("Please enter required fields"),
//                         duration: Duration(seconds: 3),
//                         backgroundColor: Colors.red,
//                       ));
//                       return;
//                     }
//                     if (!emailController.text.contains('@')) {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Text("Please Enter a valid email"),
//                         duration: Duration(seconds: 3),
//                         backgroundColor: Colors.red,
//                       ));
//                       return;
//                     }
//                     if (passwordController.text.length <= 8) {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content:
//                             Text("Password should be more than 8 characters"),
//                         duration: Duration(seconds: 3),
//                         backgroundColor: Colors.red,
//                       ));
//                       return;
//                     }
//                     if (!hasSpecialCharacters(passwordController.text)) {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content:
//                             Text("Password should contain special characters"),
//                         duration: Duration(seconds: 3),
//                         backgroundColor: Colors.red,
//                       ));
//                       return;
//                     }
//                     if (state is CodeSent) {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Text("Code Sent to your email"),
//                         duration: Duration(seconds: 3),
//                         backgroundColor: Colors.green,
//                       ));
//                     } else if (state is CodeError) {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Text(state.error),
//                         duration: Duration(seconds: 3),
//                         backgroundColor: Colors.red,
//                       ));
//                     } else if (state is VerifySuccess) {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Text("Code Verified"),
//                         duration: Duration(seconds: 3),
//                         backgroundColor: Colors.green,
//                       ));
//                       isVerified = true;
//                       codeController.clear();
//                     } else if (state is VerifyError) {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Text(state.error),
//                         duration: Duration(seconds: 3),
//                         backgroundColor: Colors.red,
//                       ));
//                     }
//                   },
//                   builder: (context, state) {
//                     if (state is SendingCode || state is VerifyLoading) {
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     } else if (state is CodeSent || state is VerifyError) {
//                       return CustomButton(
//                           text: 'Submit',
//                           width: 120.w,
//                           height: 50.h,
//                           onTap: () async {
//                             await BlocProvider.of<RegisterCubit>(context)
//                                 .confirmCode(
//                                     emailController.text, codeController.text);
//                           });
//                     } else if (state is VerifySuccess) {
//                       return CustomButton(
//                         text: 'Submit',
//                         onTap: null,
//                         width: 120.w,
//                         height: 50.h,
//                       );
//                     }
//                     return CustomButton(
//                         text: 'Send Code',
//                         width: 120.w,
//                         height: 50.h,
//                         onTap: () async {
//                           await BlocProvider.of<RegisterCubit>(context)
//                               .sendCode(emailController.text);
//                         });
//                   },
//                 ),