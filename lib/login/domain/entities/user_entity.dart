class UserEntity {
  final String email;
  final String password;

  @override
  String toString() => 'UserEntity(email: $email)';
  UserEntity({required this.email, required this.password});
}