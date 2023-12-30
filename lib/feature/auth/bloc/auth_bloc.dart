
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// Auth bloc.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository})
      : super(const AuthState.idle()) {
    on<AuthEvent>(
      (event, emit) => event.map(load: (e) => _load(e, emit)),
    );
  }

  ///
  final AuthRepository authRepository;

  Future<void> _load(
      AuthEvent$Load event, Emitter<AuthState> emit) async {
    try {
      final users = await authRepository.getAllUsers();
      return emit(
        AuthState.loaded(users: users),
      );
    } on Object catch (e) {
      emit(AuthState.idle(error: e.toString()));
      rethrow;
    }
  }
}
