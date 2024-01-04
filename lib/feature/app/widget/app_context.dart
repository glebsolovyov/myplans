import 'package:flutter/material.dart';
import 'package:myplans_app/core/router/router.dart';

import '../../auth/widget/auth_screen.dart';

class AppContext extends StatelessWidget {
  const AppContext({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter();
    return MaterialApp.router(
      routerConfig: router.router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
