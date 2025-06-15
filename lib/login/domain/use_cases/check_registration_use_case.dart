
import '../../data/repositories/auth_repository.dart';

class CheckRegistrationUseCase {
  final AuthRepository _repository;

  CheckRegistrationUseCase(this._repository);

  Future<bool> execute() async {
    return await _repository.isUserRegistered();
  }
}