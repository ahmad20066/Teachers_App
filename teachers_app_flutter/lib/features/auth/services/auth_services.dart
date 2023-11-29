import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teachers_app/common/local/local.dart';
import 'package:teachers_app/common/network/network.dart';
import 'package:teachers_app/constants/endpoints.dart';
import 'package:teachers_app/constants/global_variables.dart';
import 'package:teachers_app/models/student/student_model.dart';
import 'package:teachers_app/models/tutor/tutor_model.dart';
import 'package:teachers_app/models/user/user_model.dart';

class AuthServices {
  register(user, String password) async {
    try {
      final url = Uri.parse(EndPoints.register);
      print(jsonEncode({'password': password.toString(), ...user.toJson()}));
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body:
              jsonEncode({...user.toJson(), 'password': password.toString()}));
      print(response.statusCode);
      if (response.statusCode == 201) {
        final token = jsonDecode(response.body)['token'];
        await LocalRepo().saveToken(token);
        return true;
      } else {
        return jsonDecode(response.body)['Message'];
      }
    } catch (e) {
      print(e);
      return 'Error';
    }
  }

  login(String email, String password) async {
    try {
      final url = Uri.parse(EndPoints.login);
      print('hhhh');
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'email': email, 'password': password}));
      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final token = jsonDecode(response.body)['token'];
        await LocalRepo().saveToken(token);
        if (jsonResponse['parent']['user']['role'] == 'student') {
          return StudentModel.fromJson(jsonResponse['parent']);
        } else {
          return TutorModel.fromJson(jsonResponse['parent']);
        }
      } else {
        return jsonDecode(response.body)['Message'];
      }
    } catch (e) {
      print(e);
      return 'Error';
    }
  }

  getProfile() async {
    try {
      final jsonReponse = await Network.getRequest(EndPoints.profile);
      print('profile');
      print(jsonReponse);
      await LocalRepo().saveToken(jsonReponse['user']['jwtToken']);
      var user;
      if (jsonReponse['user']['role'] == 'student') {
        user = StudentModel.fromJson(jsonReponse);
      } else {
        user = TutorModel.fromJson(jsonReponse);
      }
      return user;
    } catch (e) {
      rethrow;
    }
  }

  deactivateAcc() async {
    try {
      final statusCode =
          await Network.postRequest(EndPoints.deactivate, jsonEncode({}));
      print(statusCode);
      if (statusCode == 201) {
        return true;
      } else {
        throw Exception('Error deleting account');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  sendCode(String email) async {
    try {
      final statusCode = await Network.postRequest(
          EndPoints.sendEmail, jsonEncode({'email': email}));
      if (statusCode == 201) {
        return true;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  confirmCode(String email, String code) async {
    try {
      final statusCode = await Network.postRequest(
          EndPoints.sendCode, jsonEncode({'email': email, 'code': code}));
      if (statusCode == 201) {
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  forgotPassword(String email, String newPassword) async {
    try {
      final url = Uri.parse(EndPoints.forgotPassword);

      print('aaaaa');
      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.post(url,
          headers: headers,
          body: jsonEncode({'email': email, 'newPassword': newPassword}));
      print(response.body);
      if (response.statusCode != 201) {
        throw Exception(jsonDecode(response.body)['Message']);
      } else {
        return true;
      }
      return response.statusCode;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  changePassword(String newPassword, String oldPassword) async {
    try {
      final statusCode = await Network.postRequest(EndPoints.changePassword,
          jsonEncode({'newPassword': newPassword, 'oldPassword': oldPassword}));
      if (statusCode == 201) {
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }
}
