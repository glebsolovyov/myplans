import 'package:drift/drift.dart';

import '../../../core/components/database/database.dart';
part "auth_data_source.g.dart";

abstract class UserDataSource {
  Future<User> createUser({required String login, required String password});
  Future<List<User>> getAllUsers();
  Future<User?> getUserById({required int id});
  Future<bool> updateUser(
      {required int id, required String login, required String password});
  Future deleteUser({required int id});
}

@DriftAccessor(tables: [AppDatabase])
class AuthDao extends DatabaseAccessor<AppDatabase>
    with _$AuthDaoMixin
    implements UserDataSource {
  AuthDao(super.attachedDatabase);

  @override
  Future<User> createUser({required String login, required String password}) {
    return attachedDatabase.into(attachedDatabase.users).insertReturning(
        UsersCompanion.insert(login: login, password: password));
  }

  @override
  Future<List<User>> getAllUsers() => select(attachedDatabase.users).get();

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
  Future deleteUser({required int id}) {
    return (attachedDatabase.delete(attachedDatabase.users)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
