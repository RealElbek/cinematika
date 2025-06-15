import '../../data/repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class LoginUserUseCase {
  final AuthRepository _repository;

  LoginUserUseCase(this._repository);

  Future<void> execute(UserEntity user) async {
    await _repository.loginUser(user);
  }
}