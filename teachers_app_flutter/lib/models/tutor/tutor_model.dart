import 'package:teachers_app/models/subject/subject_model.dart';
import 'package:teachers_app/models/user/user_model.dart';

class TutorModel {
  final String id;
  final SubjectModel state;
  final UserModel user;
  final double? rating;
  final List certificates;

  TutorModel(
      {required this.id,
      this.rating,
      required this.state,
      required this.user,
      required this.certificates});
  factory TutorModel.fromJson(Map<String, dynamic> json) => TutorModel(
      id: json['_id'],
      rating: json['rating'],
      certificates: json['certificate'],
      state: SubjectModel.fromJson(json['state']),
      user: UserModel.fromjson(json['user']));
  toJson() =>
      {'state': state.id, 'certificate': certificates, ...user.toJson()};
}
