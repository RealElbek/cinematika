import '../../data/repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class RegisterUserUseCase {
  final AuthRepository _repository;

  RegisterUserUseCase(this._repository);

  Future<void> execute(UserEntity user) async {
    await _repository.registerUser(user);
  }
}