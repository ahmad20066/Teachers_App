import 'dart:convert';

import 'package:teachers_app/common/network/network.dart';
import 'package:teachers_app/constants/endpoints.dart';
import 'package:teachers_app/models/request/request_model.dart';
import 'package:teachers_app/models/subject/subject_model.dart';
import 'package:teachers_app/models/tutor/tutor_model.dart';

class TutorsService {
  Future<List<TutorModel>> getTutors(
      {String? search,
      bool top = false,
      String? subject,
      bool alphabet = false}) async {
    try {
      late final jsonReponse;
      if (!top) {
        if (search != null) {
          if (alphabet = true) {
            jsonReponse = await Network.getRequest(
                '${EndPoints.tutors}?search=$search&alphabet=$alphabet');
          } else {
            jsonReponse =
                await Network.getRequest('${EndPoints.tutors}?search=$search');
          }
        } else if (subject != null) {
          jsonReponse =
              await Network.getRequest('${EndPoints.tutors}?subj=$subject');
        } else {
          jsonReponse = await Network.getRequest(
              '${EndPoints.tutors}?alphabet=$alphabet');
        }
      } else {
        jsonReponse = await Network.getRequest('${EndPoints.tutors}?show=top');
      }
      print('ssss');
      print(jsonReponse);
      return (jsonReponse as List).map((e) => TutorModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<SubjectModel>> getSubjects() async {
    try {
      final jsonResponse =
          await Network.getRequest(EndPoints.tutors + '/subjects');
      print('aaaaa');
      print(jsonResponse);
      return (jsonResponse as List)
          .map((e) => SubjectModel.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<RequestModel>> getRequests() async {
    try {
      final jsonResponse = await Network.getRequest(EndPoints.teacherRequest);

      return (jsonResponse as List)
          .map((e) => RequestModel.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<RequestModel>> getScheduleRequests() async {
    try {
      final jsonResponse = await Network.getRequest(EndPoints.schedule);
      print('ssss');
      print(jsonResponse);
      return (jsonResponse as List)
          .map((e) => RequestModel.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  acceptRequest(String id, {String? comment}) async {
    try {
      late final statusCode;
      if (comment == null) {
        statusCode = await Network.postRequest(
            '${EndPoints.teacherRequest}/accept/$id', jsonEncode({}));
      } else {
        statusCode = await Network.postRequest(
            '${EndPoints.teacherRequest}/accept/$id',
            jsonEncode({'comment': comment}));
      }
      if (statusCode == 201) {
        return true;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  rejectRequest(String id, {String? comment}) async {
    try {
      late final statusCode;
      if (comment == null) {
        statusCode = await Network.postRequest(
            '${EndPoints.teacherRequest}/reject/$id', jsonEncode({}));
      } else {
        statusCode = await Network.postRequest(
            '${EndPoints.teacherRequest}/reject/$id',
            jsonEncode({'comment': comment}));
      }

      print("aaaaaaaaaaaaa");
      print(statusCode);
      if (statusCode == 201) {
        return true;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
