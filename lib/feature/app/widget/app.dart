import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myplans_app/feature/auth/bloc/auth_bloc.dart';
import 'package:myplans_app/feature/auth/bloc/auth_event.dart';

import '../../../core/widget/scope_widgets.dart';
import '../../initialization/model/dependencies.dart';
import '../../initialization/widget/dependencies_scope.dart';
import 'app_context.dart';

class App extends StatelessWidget {
  /// {@macro app}
  const App({required this.result, super.key});

  void run() => runApp(this);

  /// Handles initialization result.
  final InitializationResult result;

  @override
  Widget build(BuildContext context) => ScopesProvider(
        providers: [
          ScopeProvider(
            buildScope: (child) => DependenciesScope(
              dependencies: result.dependencies,
              child: child,
            ),
          ),
        ],
        child: const AppContext(),
      );
}
