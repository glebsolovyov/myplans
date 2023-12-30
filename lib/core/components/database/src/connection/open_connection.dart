import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

QueryExecutor openConnection(String name) => LazyDatabase(
  () async {
    final rootFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(rootFolder.path, "$name.sqlite"));
    return NativeDatabase(file);
  } 
);