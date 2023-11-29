import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teachers_app/base64_helper.dart';
import 'package:teachers_app/constants/global_variables.dart';
import 'package:teachers_app/features/auth/services/auth_services.dart';
import 'package:teachers_app/models/student/student_model.dart';
import 'package:teachers_app/models/tutor/tutor_model.dart';
import 'package:teachers_app/models/user/user_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  sendCode(String email) async {
    try {
      emit(SendingCode());
      final success = await AuthServices().sendCode(email);
      if (success) {
        emit(CodeSent());
        return true;
      }
    } catch (e) {
      emit(CodeError(e.toString()));
      return false;
    }
  }

  confirmCode(String code, String email) async {
    try {
      emit(VerifyLoading());
      final success = await AuthServices().confirmCode(code, email);
      if (success) {
        emit(VerifySuccess());
      }
    } catch (e) {
      emit(VerifyError(e.toString()));
    }
  }

  register(
      String name, password, email, gender, role, location, age, image, number,
      {subject, grade, List<File> certificates = const []}) async {
    emit(RegisterLoading());
    AuthServices _service = AuthServices();
    final addedImage;
    if (image != null) {
      addedImage = Base46Helper.base46Convert(image);
    } else {
      addedImage = image;
    }

    final addedUser = UserModel(
        id: 'ss',
        phone_number: number,
        name: name,
        email: email,
        gender: gender,
        role: role,
        location: location,
        image: addedImage,
        age: age);
    var added;
    if (role == Role.tutor) {
      final certificatesBase =
          certificates.map((e) => Base46Helper.base46Convert(e)).toList();
      added = TutorModel(
          id: 'ss',
          state: subject,
          user: addedUser,
          certificates: certificatesBase);
    } else {
      added = StudentModel(id: 'ss', grade: grade, user: addedUser);
    }
    final success = await _service.register(added, password);
    print(success);
    if (success == true) {
      print('heyyy');
      emit(RegisterSuccess(success));
    } else if (success is String) {
      emit(RegisterError(success));
    }
  }
}
