// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:teachers_app/common/widgets/custom_button.dart';
// import 'package:teachers_app/common/widgets/custom_textfield.dart';
// import 'package:teachers_app/features/auth/login/screen/login_screen.dart';
// import 'package:teachers_app/features/auth/login/widgets/forgot_password.dart';
// import 'package:teachers_app/features/auth/register/cubit/register_cubit.dart';
// import 'package:teachers_app/features/auth/register/screens/setup_profile.dart';
// import 'package:teachers_app/features/auth/register/widgets/has_acc_text.dart';
// import 'package:teachers_app/features/auth/register/widgets/role_switch.dart';
// import 'package:teachers_app/router.dart';

// import '../widgets/avatar.dart';

// class RegisterScreen extends StatefulWidget {
//   static const routeName = '/register';
//   final String role;

//   RegisterScreen({super.key, required this.role});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<RegisterCubit, RegisterState>(
//         builder: (context, state) {
//           return SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 50.h,
//                 ),
//                 Avatar(
//                   isTeacher: widget.role == 'tutor',
//                 ),
//                 SizedBox(
//                   height: 20.h,
//                 ),
//                 // RolesSwitch(
//                 //     onStudentSelected: () {
//                 //       setState(() {
//                 //         isStudentSelected = true;
//                 //       });
//                 //     },
//                 //     onTutorSelected: () {
//                 //       setState(() {
//                 //         isStudentSelected = false;
//                 //       });
//                 //     },
//                 //     isStudentSelected: isStudentSelected),
//                 SizedBox(
//                   height: 20.h,
//                 ),
//                 CustomTextFiled(
//                   textController: emailController,
//                   labelText: "Email",
//                   vMargin: 0,
//                 ),
//                 SizedBox(
//                   height: 20.h,
//                 ),
//                 CustomTextFiled(
//                   textController: passwordController,
//                   labelText: "Password",
//                   vMargin: 5,
//                   isPrivate: true,
//                   action: TextInputAction.done,
//                 ),
//                 SizedBox(
//                   height: 20.h,
//                 ),
//                 CustomButton(
//                     text: 'Continue',
//                     width: 160.w,
//                     onTap: () {
//                       if (emailController.text.isEmpty ||
//                           passwordController.text.isEmpty) {
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text("Please enter required fields"),
//                           duration: Duration(seconds: 3),
//                           backgroundColor: Colors.red,
//                         ));
//                         return;
//                       }
//                       if (!emailController.text.contains('@')) {
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text("Please Enter a valid email"),
//                           duration: Duration(seconds: 3),
//                           backgroundColor: Colors.red,
//                         ));
//                         return;
//                       }
//                       if (passwordController.text.length <= 8) {
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content:
//                               Text("Password should be more than 8 characters"),
//                           duration: Duration(seconds: 3),
//                           backgroundColor: Colors.red,
//                         ));
//                         return;
//                       }
//                       if (!hasSpecialCharacters(passwordController.text)) {
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text(
//                               "Password should contain special characters"),
//                           duration: Duration(seconds: 3),
//                           backgroundColor: Colors.red,
//                         ));
//                         return;
//                       }
//                       Navigator.push(
//                           context,
//                           generateRoute(RouteSettings(
//                               name: SetUpProfile.routeName,
//                               arguments: {
//                                 'role': widget.role,
//                                 'email': emailController.text,
//                                 'password': passwordController.text
//                               })));
//                     }),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
