import 'package:myplans_app/core/components/database/database.dart';
import 'package:myplans_app/core/router/router.dart';
import 'package:myplans_app/feature/auth/data/auth_repository.dart';

base class Dependencies {
  Dependencies();

  late final AppDatabase database;
  late final AuthRepository authRepository;
  late final AppRouter appRouter;
}

final class InitializationResult {
  InitializationResult(
      {required this.dependencies,
      required this.stepCount,
      required this.msSpent});

  final Dependencies dependencies;
  final int stepCount;
  final int msSpent;

  @override
  String toString() => '$InitializationResult('
      'dependencies: $dependencies, '
      'stepCount: $stepCount, '
      'msSpent: $msSpent'
      ')';
}
