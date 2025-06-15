import 'package:cinematika/home/domain/repositories/movie_repository.dart';
import 'package:cinematika/login/data/data_sources/local_sources/shared_prefs.dart' as _i4;
import 'package:cinematika/login/data/data_sources/remote_data_source/firebase_auth_data_source.dart' as _i5;
import 'package:cinematika/login/data/repositories/auth_repository.dart' as _i3;
import 'package:cinematika/login/domain/use_cases/check_registration_use_case.dart' as _i2;
import 'package:cinematika/login/domain/use_cases/login_user_use_case.dart' as _i2;
import 'package:cinematika/login/domain/use_cases/register_user_use_case.dart' as _i2;
import 'package:cinematika/login/presentation/manager/auth_bloc.dart';
import 'package:mockito/mockito.dart' as _i1;

class MockRegisterUserUseCase extends _i1.Mock implements _i2.RegisterUserUseCase {}
class MockLoginUserUseCase extends _i1.Mock implements _i2.LoginUserUseCase {}
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {}
class MockSharedPrefs extends _i1.Mock implements _i4.SharedPrefs {}
class MockFirebaseAuthDataSource extends _i1.Mock implements _i5.FirebaseAuthDataSource {}
class MockAuthBloc extends _i1.Mock implements AuthBloc {}
class MockMovieRepository extends _i1.Mock implements MovieRepository {}