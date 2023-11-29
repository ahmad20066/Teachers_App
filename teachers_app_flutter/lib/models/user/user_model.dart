import 'package:teachers_app/constants/global_variables.dart';
import 'package:teachers_app/models/subject/subject_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String gender;
  final Role role;
  final String location;
  final int age;
  final String image;
  final String phone_number;
  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.gender,
      required this.role,
      required this.location,
      required this.phone_number,
      required this.image,
      required this.age});
  factory UserModel.fromjson(Map<String, dynamic> json) => UserModel(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      email: json['email'],
      gender: json['gender'],
      role: json['role'] == 'student' ? Role.student : Role.tutor,
      location: json['location'],
      phone_number: json['phone_number'],
      age: json['age']);
  toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'gender': gender,
        'role': role == Role.student ? 'student' : 'tutor',
        'location': location,
        'age': age,
        'image': image,
        'phone_number': phone_number
      };
}
