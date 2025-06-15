import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/register_user_use_case.dart';
import '../../domain/use_cases/login_user_use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUserUseCase _registerUserUseCase;
  final LoginUserUseCase _loginUserUseCase;

  AuthBloc(this._registerUserUseCase, this._loginUserUseCase) : super(AuthInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await _registerUserUseCase.execute(event.user);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthError(e.toString().contains('successfully') ? 'Registration successful, but check logs for warnings' : e.toString()));
      }
    });

    on<LoginUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await _loginUserUseCase.execute(event.user);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}