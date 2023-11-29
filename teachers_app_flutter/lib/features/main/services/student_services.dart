import 'dart:convert';

import 'package:teachers_app/common/network/network.dart';
import 'package:teachers_app/constants/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:teachers_app/models/request/request_model.dart';

import '../../../common/local/local.dart';

class StudentServices {
  sendRequest(String teacherId, String date, String subject) async {
    final statusCode = await Network.postRequest(
        '${EndPoints.request}',
        jsonEncode(
            {'teacher_id': teacherId, 'subject': subject, 'date': date}));
    print(statusCode);
    if (statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> cancelRequest(String teacherId) async {
    try {
      final url = Uri.parse('${EndPoints.request}/$teacherId');
      final token = await LocalRepo().getToken();
      print('token');
      print(token);
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      };
      final response = await http.delete(url, headers: headers);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception(jsonDecode(response.body)['Message']);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<RequestModel>> getRequests() async {
    try {
      final jsonResponse = await Network.getRequest(EndPoints.request);
      print(jsonResponse);
      return (jsonResponse as List)
          .map((e) => RequestModel.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  report(String teacherId, String reason) async {
    try {
      final statusCode = await Network.postRequest(
          EndPoints.report,
          jsonEncode({
            'reason': reason,
            'teacher_id': teacherId,
          }));
      if (statusCode == 201) {
        return true;
      } else {
        throw Exception('Error Report');
      }
    } catch (e) {
      rethrow;
    }
  }
}
