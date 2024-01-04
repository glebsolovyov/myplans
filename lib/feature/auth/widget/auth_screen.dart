import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myplans_app/feature/auth/bloc/user/auth_bloc.dart';

import '../bloc/user/auth_state.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                return Text(state.users.toString());
              }),
              TextFormField(
                controller: _loginController,
                decoration: const InputDecoration(helperText: "login"),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(helperText: "password"),
              ),
              ElevatedButton(
                  onPressed: () => login(context), child: Text("Войти"))
            ],
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) {
    try {
      // context.read<UserBloc>().add(
      //     UserEvent.login(_loginController.text, _passwordController.text));
      context.go("/home");
    } on Object catch (e) {
      print("fdsf");
    }
  }
}
