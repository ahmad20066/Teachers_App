import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teachers_app/common/widgets/custom_button.dart';
import 'package:teachers_app/common/widgets/custom_textfield.dart';
import 'package:teachers_app/constants/global_variables.dart';
import 'package:teachers_app/features/auth/register/cubit/register_cubit.dart';
import 'package:teachers_app/features/auth/register/screens/verification_screen.dart';
import 'package:teachers_app/features/auth/register/screens/welcome.dart';
import 'package:teachers_app/features/auth/register/widgets/gender_radio.dart';
import 'package:teachers_app/features/auth/register/widgets/subjects_dropdown.dart';
import 'package:teachers_app/features/auth/register/widgets/up_container.dart';
import 'package:teachers_app/features/main/search/cubit/subjects_cubit.dart';
import 'package:teachers_app/features/main/tabs/tab_screen.dart';
import 'package:teachers_app/models/subject/subject_model.dart';

import '../../../../common/widgets/image_picker.dart';
import '../../../../router.dart';
import '../../login/screen/login_screen.dart';
import '../widgets/has_acc_text.dart';

class SetUpProfile extends StatefulWidget {
  static const routeName = '/setup';
  final Role role;

  SetUpProfile({
    super.key,
    required this.role,
  });

  @override
  State<SetUpProfile> createState() => _SetUpProfileState();
}

class _SetUpProfileState extends State<SetUpProfile> {
  TextEditingController nameController = TextEditingController();

  TextEditingController numberController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  bool isPicked = false;
  File? pickedProfilePic;
  late final RegisterCubit bloc;
  String? name;

  @override
  Future<void> didChangeDependencies() async {
    BlocProvider.of<SubjectsCubit>(context).getSubjects();
    bloc = BlocProvider.of<RegisterCubit>(context, listen: false);

    bloc.emit(RegisterInitial());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    print('dispose');

    // TODO: implement dispose
    super.dispose();
  }

  List<File> _selectedImages = [];

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        _selectedImages =
            pickedImages.map((pickedImage) => File(pickedImage.path)).toList();
      });
    }
  }

  bool hasSpecialCharacters(String input) {
    RegExp regex = RegExp(r'[!@#%^&*(),.?":{}|<>]');
    return regex.hasMatch(input);
  }

  bool obscure = true;
  String gender = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          print('registersuccess');
          if (state is RegisterSuccess) {
            Navigator.pushAndRemoveUntil(
                context,
                generateRoute(RouteSettings(
                    name: WelcomeScreen.routeName,
                    arguments: nameController.text)),
                (route) => false);
          }
        },
        builder: (context, state) {
          print(widget.role);

          if (state is RegisterError) {
            // showDialog(
            //     context: context,
            //     builder: (context) {
            //       return Dialog(
            //         child: Container(
            //           alignment: Alignment.center,
            //           child: Text(state.message),
            //         ),
            //       );
            //     });
            return Center(
              child: Text(state.message),
            );
          }
          if (state is RegisterLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: GlobalVariables.base,
              ),
            );
          }
          // if (state is RegisterLoading) {
          //
          // }
          return SingleChildScrollView(
            child: Column(
              children: [
                UpContainer(),
                SizedBox(
                  height: 20.h,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: !isPicked
                      ? AssetImage('assets/images/student.png') as ImageProvider
                      : FileImage(pickedProfilePic!),
                  radius: 55.h,
                ),
                TextButton.icon(
                    onPressed: () async {
                      final ImageSource? imageSource =
                          await showDialog<ImageSource>(
                              context: context,
                              builder: (context) => ImagePickerWidget(
                                  text: "Choose Image source" + ":"));
                      if (imageSource == null) {
                        return;
                      }
                      final _pickedFile =
                          await ImagePicker().pickImage(source: imageSource);
                      if (_pickedFile != null) {
                        pickedProfilePic = File(_pickedFile.path);
                        isPicked = true;
                        setState(() {});
                      }
                    },
                    icon: const Icon(Icons.image),
                    label: Text("pick a profile picture")),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFiled(
                  textController: emailController,
                  labelText: "Email",
                  vMargin: 0,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFiled(
                  textController: passwordController,
                  labelText: "Password",
                  vMargin: 5,
                  isPrivate: obscure,
                  action: TextInputAction.done,
                  suffix: IconButton(
                      onPressed: () {
                        setState(() {});
                        obscure = !obscure;
                      },
                      icon: Icon(
                          obscure ? Icons.visibility : Icons.visibility_off)),
                ),
                CustomTextFiled(
                  textController: nameController,
                  labelText: 'User Name',
                  vMargin: 10,
                  hintText: 'Enter Your User Name',
                ),
                CustomTextFiled(
                  textController: numberController,
                  labelText: 'Phone Number',
                  vMargin: 10,
                  hintText: 'Enter Your Phone Number',
                ),
                CustomTextFiled(
                  textController: locationController,
                  labelText: 'Location',
                  vMargin: 10,
                  hintText: 'Enter Your Area of residence',
                  action: TextInputAction.next,
                ),
                GenderRadio(
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                    gender: gender),
                CustomTextFiled(
                  textController: ageController,
                  labelText: 'Age',
                  type: TextInputType.number,
                  vMargin: 10,
                  hintText: 'Enter Your Age',
                  action: TextInputAction.done,
                ),
                if (widget.role == Role.student)
                  CustomTextFiled(
                    textController: levelController,
                    labelText: 'Level',
                    type: TextInputType.number,
                    vMargin: 10,
                    hintText: 'Enter Your Level',
                    action: TextInputAction.done,
                  ),
                if (widget.role == Role.tutor)
                  TextButton.icon(
                      onPressed: _pickImages,
                      icon: Icon(Icons.link),
                      label: Text('Certificates')),
                if (widget.role == Role.tutor && _selectedImages.isNotEmpty)
                  Text("${_selectedImages.length} Images"),
                SizedBox(
                  height: 20.h,
                ),
                if (widget.role == Role.tutor)
                  BlocBuilder<SubjectsCubit, SubjectsState>(
                      builder: (context, state) {
                    if (state is SubjectsLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SubjectsLoaded) {
                      return SubjectDropwDown(
                        subjects: state.subjects,
                        onChanged: (v) {
                          setState(() {
                            BlocProvider.of<SubjectsCubit>(context)
                                .selectedSubject = v!;
                          });
                        },
                        value: BlocProvider.of<SubjectsCubit>(context)
                            .selectedSubject!,
                      );
                    } else if (state is SubjectsError) {
                      return Text(state.error);
                    }
                    return Container();
                  }),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  text: 'Sign Up',
                  onTap: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        ageController.text.isEmpty ||
                        pickedProfilePic == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please enter required fields"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }
                    if (widget.role == Role.tutor && _selectedImages.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please enter required fields"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }
                    if (widget.role == Role.student &&
                        levelController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please enter required fields"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }
                    if (!emailController.text.contains('@')) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please Enter a valid email"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }
                    if (passwordController.text.length <= 8) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("Password should be more than 8 characters"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }
                    if (!hasSpecialCharacters(passwordController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("Password should contain special characters"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }

                    final isVerified = await Navigator.push(
                        context,
                        generateRoute(RouteSettings(
                            name: VerificationScreen.routeName,
                            arguments: emailController.text)));
                    if (isVerified != null) {
                      await bloc.register(
                          nameController.text,
                          passwordController.text,
                          emailController.text,
                          gender,
                          widget.role,
                          locationController.text,
                          int.parse(ageController.text),
                          pickedProfilePic,
                          numberController.text,
                          certificates: _selectedImages,
                          grade: int.tryParse(levelController.text) ?? 0,
                          subject: BlocProvider.of<SubjectsCubit>(context)
                              .selectedSubject);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please verify Your Email"),
                        duration: Duration(seconds: 4),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  height: 50.h,
                  width: 150.w,
                ),
                HasAccountText(),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
