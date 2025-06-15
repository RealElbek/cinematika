// test/mocks/mocks.dart
import 'package:cinematika/login/data/data_sources/local_sources/shared_prefs.dart';
import 'package:cinematika/login/data/data_sources/remote_data_source/firebase_auth_data_source.dart';
import 'package:cinematika/login/data/repositories/auth_repository.dart';
import 'package:cinematika/login/domain/use_cases/check_registration_use_case.dart';
import 'package:cinematika/login/domain/use_cases/login_user_use_case.dart';
import 'package:cinematika/login/domain/use_cases/register_user_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  RegisterUserUseCase,
  LoginUserUseCase,
  AuthRepository,
  SharedPrefs,
  FirebaseAuthDataSource,
])
void main() {}