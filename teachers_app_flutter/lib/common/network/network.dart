import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teachers_app/common/local/local.dart';

class Network {
  static getHeaders() async {
    final token = await LocalRepo().getToken();
    print('token');
    print(token);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token',
    };
    return headers;
  }

  static getRequest(String path) async {
    try {
      final url = Uri.parse(path);
      final headers = await getHeaders();
      final response = await http.get(url, headers: headers);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else if (response.statusCode == 401) {
        throw Exception('Not Authenticated');
      } else {
        throw Exception(jsonDecode(response.body)['Message']);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static postRequest(String path, dynamic body, {bool isPut = false}) async {
    try {
      final url = Uri.parse(path);
      final headers = await getHeaders();
      late final response;
      print('aaaaa');
      if (isPut) {
        response = await http.put(url, headers: headers, body: body);
        print(response.body);
        print(response.statusCode);
      } else {
        response = await http.post(url, headers: headers, body: body);
        print(response.body);
        print(response.statusCode);
      }
      if (response.statusCode != 201) {
        throw Exception(jsonDecode(response.body)['Message']);
      }
      return response.statusCode;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
