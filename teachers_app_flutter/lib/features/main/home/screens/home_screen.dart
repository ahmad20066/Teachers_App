import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/common/widgets/custom_appbar.dart';
import 'package:teachers_app/constants/global_variables.dart';
import 'package:teachers_app/features/main/home/widgets/image_carousel.dart';
import 'package:teachers_app/features/main/home/widgets/subjects_carousel.dart';
import 'package:teachers_app/features/main/home/widgets/title_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(),
            SizedBox(
              height: 30.h,
            ),
            TitleContainer(
              text: 'Subject Categories',
              subtitle: "Choose your subject to find your tutor",
            ),
            SizedBox(
              height: 10.h,
            ),
            SubjectsCarousel(),
            SizedBox(
              height: 10.h,
            ),
            TitleContainer(
              text: 'Featured Lists',
              color: GlobalVariables.base,
            ),
            ImageCarousel(),
          ],
        ),
      ),
    );
  }
}
