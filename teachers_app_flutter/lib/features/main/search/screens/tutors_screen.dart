import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/common/widgets/custom_appbar.dart';

import '../cubit/search_cubit.dart';
import '../widgets/tutors_list.dart';

class TutorsScreen extends StatefulWidget {
  static const routeName = '/tutors_list';
  final String subject;
  const TutorsScreen({super.key, required this.subject});

  @override
  State<TutorsScreen> createState() => _TutorsScreenState();
}

class _TutorsScreenState extends State<TutorsScreen> {
  @override
  void initState() {
    BlocProvider.of<SearchCubit>(context).getTutors(subject: widget.subject);
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
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is TutorsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TutorsLoaded) {
                return Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    TutorsList(tutors: state.tutors)
                  ],
                );
              } else if (state is TutorsEmpty) {
                return Container(
                  height: 500.h,
                  child: Center(
                    child: Text('No Tutors Found'),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      )),
    );
  }
}
