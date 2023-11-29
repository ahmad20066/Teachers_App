import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/features/main/home/cubit/home_cubit.dart';
import 'package:teachers_app/features/main/search/cubit/search_cubit.dart';

import 'carousel_item.dart';

class ImageCarousel extends StatefulWidget {
  ImageCarousel({Key? key}) : super(key: key);

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context, listen: false).getpopularTutors();
    super.initState();
  }

  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state is PopularTutorsLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PopularTutorsLoaded) {
        return CarouselSlider.builder(
            carouselController: _controller,
            itemCount: state.tutors.length,
            itemBuilder: (context, index, realIndex) => CarouselItem(
                  tutor: state.tutors[index],
                ),
            options: CarouselOptions(
              padEnds: false,
              viewportFraction: 0.45,
              height: 270.h,
              initialPage: 0,
              // autoPlay: true,
              enableInfiniteScroll: false,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              onPageChanged: (index, reason) {},
              scrollDirection: Axis.horizontal,
            ));
      }
      return Container();
    });
  }
}
