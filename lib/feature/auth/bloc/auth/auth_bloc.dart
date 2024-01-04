import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// Auth bloc.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(const AuthState.idle()) {
    on<AuthEvent>(
      (event, emit) => event.map(
        loadAllUsers: (e) => _loadAllUsers(e, emit),
      ),
    );
  }

  ///
  final AuthRepository authRepository;

  Future<void> _loadAllUsers(
      AuthEvent$LoadAllUsers event, Emitter<AuthState> emit) async {
    try {
      final users = await authRepository.getAllUsers();
      emit(
        AuthState.loaded(users: users),
      );
    } on Object catch (e) {
      emit(AuthState.idle(error: e.toString()));
      rethrow;
    }
  }
}
