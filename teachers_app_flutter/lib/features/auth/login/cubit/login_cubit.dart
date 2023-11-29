import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:teachers_app/features/auth/services/auth_services.dart';
import 'package:teachers_app/models/student/student_model.dart';
import 'package:teachers_app/models/tutor/tutor_model.dart';
import 'package:teachers_app/models/user/user_model.dart';

import '../../profile/cubit/user_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  logIn(email, password) async {
    emit(LoginLoading());
    final response = await AuthServices().login(email, password);
    print('--------------');
    print(response);
    if (response is TutorModel || response is StudentModel) {
      final userCubit = UserCubit();
      userCubit.changeState(response);
      emit(LoginSuccess());
    } else {
      emit(LoginError(response));
    }
  }
}
