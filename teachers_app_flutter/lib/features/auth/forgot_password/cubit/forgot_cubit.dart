import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teachers_app/features/auth/services/auth_services.dart';

part 'forgot_state.dart';

class ForgotCubit extends Cubit<ForgotState> {
  ForgotCubit() : super(ForgotInitial());
  forgotPassword(String email, String newPassword) async {
    try {
      emit(ForgotLoading());
      final success = await AuthServices().forgotPassword(email, newPassword);
      if (success == true) {
        emit(ForgotSuccess());
      }
      emit(ForgotInitial());
    } catch (e) {
      emit(ForgotError(e.toString()));
    }
  }
}
