import 'package:teachers_app/models/student/student_model.dart';
import 'package:teachers_app/models/tutor/tutor_model.dart';
import 'package:teachers_app/models/user/user_model.dart';

class RequestModel {
  final String id;
  final String state;
  final dynamic student;
  String? comment;
  final DateTime createdAt;
  final UserModel tutor;
  final DateTime date;
  String? subject;

  RequestModel(
      {required this.id,
      required this.state,
      required this.student,
      required this.date,
      this.comment,
      this.subject,
      required this.createdAt,
      required this.tutor});
  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
        date: DateTime.parse(json['date']),
        tutor: UserModel.fromjson(json['teacher_id']),
        id: json['_id'],
        state: json['state'],
        student: UserModel.fromjson(json['student_id']),
        comment: json['comment'],
        subject: json['subject'],
        createdAt: DateTime.parse(json['createdAt']));
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'student': student as int,
        'comment': comment,
        'date': date.toIso8601String()
      };
}
