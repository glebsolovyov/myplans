import 'package:drift/drift.dart';
import 'package:myplans_app/core/components/database/src/connection/open_connection.dart';

part 'app_database.g.dart';

@DriftDatabase(include: {"tables/user.drift"})
class AppDatabase extends _$AppDatabase {
  AppDatabase({required String name}) : super(openConnection(name));

  @override
  int get schemaVersion => 1;
}