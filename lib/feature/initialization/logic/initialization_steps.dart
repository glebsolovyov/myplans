import 'dart:async';

import 'package:myplans_app/core/components/database/database.dart';
import 'package:myplans_app/core/router/router.dart';
import 'package:myplans_app/feature/auth/data/auth_repository.dart';

import '../../auth/data/auth_data_source.dart';
import '../model/initialization_progress.dart';

typedef StepAction = FutureOr<void>? Function(InitializationProgress progress);

mixin InitializationSteps {
  final initializationSteps = <String, StepAction>{
    "Router": (progress) {
      final appRouter = AppRouter();
      return progress.dependencies.appRouter = appRouter;
    },
    "Database": (progress) {
      final database = AppDatabase(name: "myplans");
      return progress.dependencies.database = database;
    },
    "AuthRepository": (progress) {
      final authRepository = AuthRepositoryImpl(
        AuthDao(progress.dependencies.database),
      );
      return progress.dependencies.authRepository = authRepository;
    }
  };
}
