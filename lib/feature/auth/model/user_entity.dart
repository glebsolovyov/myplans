import '../../../core/components/database/database.dart';

base class UserEntity {
  const UserEntity(
      {required this.id, required this.login, required this.password});

  final int id;
  final String login;
  final String password;

  factory UserEntity.fromModel(User model) {
    return UserEntity(
        id: model.id, login: model.login, password: model.password);
  }
}
