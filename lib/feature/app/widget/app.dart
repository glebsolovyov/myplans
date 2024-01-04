import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widget/scope_widgets.dart';
import '../../auth/bloc/user/auth_bloc.dart';
import '../../auth/bloc/user/auth_event.dart';
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
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(authRepository: result.dependencies.authRepository)
                  ..add(const AuthEvent.loadAllUsers()),
          ),
        ],
        child: ScopesProvider(
          providers: [
            ScopeProvider(
              buildScope: (child) => DependenciesScope(
                dependencies: result.dependencies,
                child: child,
              ),
            ),
          ],
          child: const AppContext(),
        ),
      );
}
