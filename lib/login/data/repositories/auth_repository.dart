
import '../../domain/entities/user_entity.dart';
import '../data_sources/local_sources/shared_prefs.dart';
import '../data_sources/remote_data_source/firebase_auth_data_source.dart';

class AuthRepository {
  final FirebaseAuthDataSource _remoteDataSource;
  final SharedPrefs _localDataSource;

  AuthRepository(this._remoteDataSource, this._localDataSource);

  Future<void> registerUser(UserEntity user) async {
    await _remoteDataSource.registerUser(user.email, user.password);
    await _localDataSource.setRegistered(true);
  }
  Future<void> loginUser(UserEntity user) async {
    await _remoteDataSource.loginUser(user.email, user.password);
    await _localDataSource.setRegistered(true); 
  }
  Future<bool> isUserRegistered() async {
    return await _localDataSource.isRegistered();
  }
}