import 'package:drift/drift.dart';

import '../../../core/components/database/database.dart';
part "auth_data_source.g.dart";
abstract class UserDataSource {
  Future<void> createUser();
  Future<List<User>> getAllUsers();
  }

@DriftAccessor(tables: [AppDatabase])
class UserDao extends DatabaseAccessor<AppDatabase>
    with _$UserDaoMixin
    implements UserDataSource{
      UserDao(super.attachedDatabase);

      @override
      Future<void> createUser() =>
        attachedDatabase.into(attachedDatabase.users).insert(UsersCompanion.insert(id: const Value(1), login: "admin", password: "admin"));

      
      @override
      Future<List<User>> getAllUsers() =>
      select(attachedDatabase.users).get();
    }