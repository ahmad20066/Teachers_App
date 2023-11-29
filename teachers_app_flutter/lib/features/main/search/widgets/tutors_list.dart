import 'package:flutter/material.dart';
import 'package:teachers_app/features/main/search/widgets/tutor_item.dart';
import 'package:teachers_app/models/tutor/tutor_model.dart';

class TutorsList extends StatelessWidget {
  final List<TutorModel> tutors;
  const TutorsList({super.key, required this.tutors});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: tutors.length,
        itemBuilder: (context, index) {
          return TutorItem(
            tutor: tutors[index],
          );
        });
  }
}
