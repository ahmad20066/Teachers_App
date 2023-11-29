import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teachers_app/common/local/local.dart';
import 'package:teachers_app/features/auth/services/auth_services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  Future<void> fetchCurrentUser() async {
    try {
      final currentUser = await AuthServices().getProfile();
      emit(UserLoaded(currentUser));
    } catch (e) {
      print(e);
      if (e.toString().contains('Not Authenticated')) {
        emit(UserExpired());
      } else {
        emit(UserError(e.toString()));
      }
    }
  }

  changeState(user) {
    emit(UserLoaded(user));
  }

  deactivateAcc() async {
    try {
      // emit(UserLoading());
      final success = await AuthServices().deactivateAcc();
      print(success);
    } catch (e) {
      emit(UserDeleteError(e.toString()));
    }
  }

  Future<void> logOut() async {
    await LocalRepo().clearData();
  }
}
