import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/use_cases/register_user_use_case.dart';
import '../../domain/use_cases/login_user_use_case.dart';

// Events
abstract class AuthEvent {}

class RegisterUserEvent extends AuthEvent {
  final UserEntity user;

  RegisterUserEvent(this.user);
}

class LoginUserEvent extends AuthEvent {
  final UserEntity user;

  LoginUserEvent(this.user);
}

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

// Bloc
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