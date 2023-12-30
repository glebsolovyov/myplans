import 'package:myplans_app/feature/auth/data/auth_data_source.dart';
import 'package:myplans_app/feature/auth/model/user_entity.dart';

abstract class AuthRepository{
  Future<List<UserEntity>> getAllUsers();
}

class AuthRepositoryImpl implements AuthRepository{
  AuthRepositoryImpl(this._dataSource);

  final UserDataSource _dataSource;

  @override
  Future<List<UserEntity>> getAllUsers() async {
    final allUsers = await _dataSource.getAllUsers();
    return allUsers
        .map(
          (dto) => UserEntity(
            id: dto.id, 
            login: dto.login, 
            password: dto.password
            ),
          )
          .toList();
  }
}