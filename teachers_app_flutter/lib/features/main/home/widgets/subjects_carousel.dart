import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/features/main/home/widgets/subject_item.dart';

import '../../search/cubit/subjects_cubit.dart';

class SubjectsCarousel extends StatefulWidget {
  SubjectsCarousel({super.key});

  @override
  State<SubjectsCarousel> createState() => _SubjectsCarouselState();
}

class _SubjectsCarouselState extends State<SubjectsCarousel> {
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    BlocProvider.of<SubjectsCubit>(context).getSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectsCubit, SubjectsState>(
      builder: (context, state) {
        if (state is SubjectsLoaded) {
          return Align(
            alignment: Alignment.centerLeft,
            child: CarouselSlider.builder(
                carouselController: _controller,
                itemCount: state.subjects.length,
                itemBuilder: (context, index, realIndex) =>
                    SubjectItem(subject: state.subjects[index]),
                options: CarouselOptions(
                  padEnds: false,
                  viewportFraction: 0.17,
                  height: 70.h,
                  initialPage: 0,
                  // autoPlay: true,
                  enableInfiniteScroll: false,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (index, reason) {},
                  scrollDirection: Axis.horizontal,
                )),
          );
        } else if (state is SubjectsLoading) {
          return CircularProgressIndicator();
        } else {
          return Container();
        }
      },
    );
  }
}
