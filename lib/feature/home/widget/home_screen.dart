import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myplans_app/feature/auth/bloc/user/auth_event.dart';
import 'package:myplans_app/feature/initialization/widget/dependencies_scope.dart';

import '../../auth/bloc/user/auth_bloc.dart';
import '../../auth/bloc/user/auth_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AuthBloc userBloc;
  @override
  void initState() {
    super.initState();
    userBloc =
        AuthBloc(authRepository: DependenciesScope.of(context).authRepository)
          ..add(const AuthEvent.loadUser(1));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Text(state.user?.login ?? 'skdjfksdfj');
          },
        ),
      ),
    );
  }
}
