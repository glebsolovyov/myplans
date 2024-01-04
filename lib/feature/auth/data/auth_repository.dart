import 'package:drift/drift.dart';
import 'package:myplans_app/feature/auth/data/auth_data_source.dart';
import 'package:myplans_app/feature/auth/model/user_entity.dart';

abstract class AuthRepository {
  Future<List<UserEntity>> getAllUsers();
  Future<UserEntity> createUser(
      {required String login, required String password});
  Future<UserEntity?> getUserById({required int id});
  Future<bool> updateUser(
      {required int id, required String login, required String password});
  Future deleteUser({required int id});
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final UserDataSource _dataSource;

  @override
  Future<UserEntity> createUser(
      {required String login, required String password}) async {
    final createdUser =
        await _dataSource.createUser(login: login, password: password);

    return UserEntity.fromModel(createdUser);
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    final allUsers = await _dataSource.getAllUsers();
    return allUsers
        .map(
          (dto) =>
              UserEntity(id: dto.id, login: dto.login, password: dto.password),
        )
        .toList();
  }

  @override
  Future<UserEntity?> getUserById({required int id}) async {
    final user = await _dataSource.getUserById(id: id);
    if (user != null) {
      return UserEntity.fromModel(user);
    } else {
      return null;
    }
  }

  @override
  Future<bool> updateUser(
      {required int id,
      required String login,
      required String password}) async {
    final updatedUser =
        await _dataSource.updateUser(id: id, login: login, password: password);

    return updatedUser;
  }

  @override
  Future deleteUser({required int id}) {
    return _dataSource.deleteUser(id: id);
  }
}
