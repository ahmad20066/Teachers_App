import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/common/widgets/custom_button.dart';
import 'package:teachers_app/common/widgets/custom_textfield.dart';
import 'package:teachers_app/features/auth/register/widgets/avatar.dart';
import 'package:teachers_app/features/main/home/widgets/title_container.dart';
import 'package:teachers_app/features/settings/cubit/change_cubit.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/change';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController newPasswordController = TextEditingController();

  TextEditingController oldPasswordController = TextEditingController();
  bool obscure = true;
  bool obscure2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChangeCubit, ChangeState>(
        listener: (context, state) {
          if (state is ChangeSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Password changed Successfully'),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,
            ));
          } else if (state is ChangeError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          if (state is ChangeLoadingl) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100.h,
                ),
                Avatar(isTeacher: true),
                SizedBox(
                  height: 20.h,
                ),
                TitleContainer(text: 'Change your password'),
                CustomTextFiled(
                    textController: oldPasswordController,
                    labelText: 'old password',
                    isPrivate: obscure2,
                    suffix: IconButton(
                        onPressed: () {
                          setState(() {});
                          obscure2 = !obscure2;
                        },
                        icon: Icon(obscure2
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    vMargin: 10),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFiled(
                    textController: newPasswordController,
                    labelText: 'new password',
                    isPrivate: obscure,
                    suffix: IconButton(
                        onPressed: () {
                          setState(() {});
                          obscure = !obscure;
                        },
                        icon: Icon(
                            obscure ? Icons.visibility : Icons.visibility_off)),
                    vMargin: 10),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  text: 'Submit',
                  onTap: () {
                    BlocProvider.of<ChangeCubit>(context).changePassword(
                        newPasswordController.text, oldPasswordController.text);
                  },
                  width: 100.w,
                  height: 50.h,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
