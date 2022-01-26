import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:onye_front_ened/repositories/auth_repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  // ignore: unused_field
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(const LoginState());

  void setPassword(String? argpassword) {
    final String password = argpassword!;
    emit(state.copywith(password: password));
  }

  void setUserName(String? arguserName) {
    final String userName = arguserName!;
    emit(state.copywith(userName: userName));
  }

  void login() async {
    await _authRepository.signIn(
        username: state.userName, password: state.password);
  }
}
