import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'registerpagecubit_state.dart';

class RegisterPageCubit extends Cubit<RegisterPageState> {
  RegisterPageCubit() : super(RegisterPageInitial());
  changeStateToVerification() {
    emit(Verification());
  }

  changeToRegister() {
    emit(RegisterPageInitial());
  }
}
