import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teachers_app/features/auth/services/auth_services.dart';

part 'change_state.dart';

class ChangeCubit extends Cubit<ChangeState> {
  ChangeCubit() : super(ChangeInitial());
  changePassword(String password, String oldPassword) async {
    try {
      emit(ChangeLoadingl());
      final success =
          await AuthServices().changePassword(password, oldPassword);
      if (success == true) {
        emit(ChangeSuccess());
      }
      emit(ChangeInitial());
    } catch (e) {
      print(e);
      emit(ChangeError(e.toString()));
    }
  }
}
