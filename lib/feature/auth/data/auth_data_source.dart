import 'package:drift/drift.dart';
import 'package:path/path.dart';

import '../../../core/components/database/database.dart';
part "auth_data_source.g.dart";

abstract class UserDataSource {
  Future<User> createUser({required String login, required String password});
  Future<List<User>> getAllUsers();
  Future<User?> getUserById({required int id});
  Future<bool> updateUser(
      {required int id, required String login, required String password});
  Future<int> deleteUser({required int id});
  Future<bool> login({required String login, required String password});
  Future<bool> logout({required int id});
}

@DriftAccessor(tables: [AppDatabase])
class AuthDao extends DatabaseAccessor<AppDatabase>
    with _$AuthDaoMixin
    implements UserDataSource {
  AuthDao(super.attachedDatabase);

  @override
  Future<User> createUser({required String login, required String password}) {
    return attachedDatabase.into(attachedDatabase.users).insertReturning(
        UsersCompanion.insert(login: login, password: password, isLogin: 1));
  }

  @override
  Future<List<User>> getAllUsers() {
    print("fdsfdsaaaa");
    print(select(attachedDatabase.users).get());
    return select(attachedDatabase.users).get();
  }

  @override
  Future<User?> getUserById({required int id}) {
    return (select(attachedDatabase.users)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  @override
  Future<bool> updateUser(
      {required int id, required String login, required String password}) {
    return attachedDatabase.update(attachedDatabase.users).replace(
        UsersCompanion(
            id: Value(id), login: Value(login), password: Value(password)));
  }

  @override
  Future<int> deleteUser({required int id}) {
    return (attachedDatabase.delete(attachedDatabase.users)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<bool> login({required String login, required String password}) async {
    final user = await (select(attachedDatabase.users)
          ..where(
              (tbl) => tbl.login.equals(login) & tbl.password.equals(password)))
        .getSingleOrNull();
    if (user != null) {
      return attachedDatabase.update(attachedDatabase.users).replace(
          UsersCompanion(
              id: Value(user.id),
              login: Value(user.login),
              password: Value(user.password),
              isLogin: const Value(1)));
    }
    return false;
  }

  @override
  Future<bool> logout({required int id}) async {
    final user = await getUserById(id: id);
    if (user != null) {
      return attachedDatabase.update(attachedDatabase.users).replace(
          UsersCompanion(
              id: Value(user.id),
              login: Value(user.login),
              password: Value(user.password),
              isLogin: const Value(0)));
    }
    return false;
  }
}
