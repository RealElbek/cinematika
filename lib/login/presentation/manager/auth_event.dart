import '../../domain/entities/user_entity.dart';

abstract class AuthEvent {}

class RegisterUserEvent extends AuthEvent {
  final UserEntity user;

  RegisterUserEvent(this.user);
}

class LoginUserEvent extends AuthEvent {
  final UserEntity user;

  LoginUserEvent(this.user);
}