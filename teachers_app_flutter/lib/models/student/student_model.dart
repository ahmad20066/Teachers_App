import 'package:teachers_app/models/user/user_model.dart';

class StudentModel {
  final String id;
  final int grade;
  final UserModel user;

  StudentModel({required this.id, required this.grade, required this.user});
  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
      id: json['_id'],
      user: UserModel.fromjson(json['user']),
      grade: json['grade']);
  toJson() => {'grade': grade, ...user.toJson()};
}
