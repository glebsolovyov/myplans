import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(const AuthState.idle()) {
    on<AuthEvent>(
      (event, emit) => event.map(
          loadAllUsers: (e) => _loadAllUsers(e, emit),
          loadUser: (e) => _loadUser(e, emit),
          create: (e) => _create(e, emit),
          update: (e) => _update(e, emit),
          delete: (e) => _delete(e, emit),
          login: (e) => _login(e, emit),
          logout: (e) => _logout(e, emit)),
    );
  }

  ///
  final AuthRepository authRepository;

  Future<void> _loadUser(
      AuthEvent$LoadUser event, Emitter<AuthState> emit) async {
    try {
      final user = await authRepository.getUserById(id: event.id);
      if (user != null) {
        emit(
          AuthState.loaded(user: user),
        );
      } else {
        throw Exception("Пользователь не найден");
      }
    } on Object catch (e) {
      emit(AuthState.idle(error: e.toString()));
      rethrow;
    }
  }

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

  Future<void> _create(
      AuthEvent$CreateUser event, Emitter<AuthState> emit) async {
    try {
      final newUser = await authRepository.createUser(
          login: event.login, password: event.password);
      final user = await authRepository.getUserById(id: newUser.id);
      if (user != null) {
        emit(
          AuthState.loaded(user: user),
        );
      } else {
        throw Exception("Пользователь не найден");
      }
    } on Object catch (e) {
      emit(AuthState.idle(error: e.toString()));
      rethrow;
    }
  }

  Future<void> _update(AuthEvent$Update event, Emitter<AuthState> emit) async {
    try {
      final updatedUser = await authRepository.updateUser(
          id: event.id, login: event.login, password: event.password);
      final user = await authRepository.getUserById(id: event.id);
      if (user != null && updatedUser) {
        emit(
          AuthState.loaded(user: user),
        );
      } else {
        throw Exception("Пользователь не найден");
      }
    } on Object catch (e) {
      emit(AuthState.idle(error: e.toString()));
      rethrow;
    }
  }

  Future<void> _delete(AuthEvent$Delete event, Emitter<AuthState> emit) async {
    try {
      final isDeleted = await authRepository.deleteUser(id: event.id);
      if (isDeleted != 0) {
        emit(
          const AuthState.loaded(),
        );
      } else {
        throw Exception("Пользователь не найден");
      }
    } on Object catch (e) {
      emit(AuthState.idle(error: e.toString()));
      rethrow;
    }
  }

  Future<void> _login(AuthEvent$Login event, Emitter<AuthState> emit) async {
    try {
      final isLogin = await authRepository.login(
          login: event.login, password: event.password);
      if (isLogin) {
        emit(
          const AuthState.loaded(),
        );
      } else {
        throw Exception("Пользователь не найден");
      }
    } on Object catch (e) {
      emit(AuthState.idle(error: e.toString()));
      rethrow;
    }
  }

  Future<void> _logout(AuthEvent$Logout event, Emitter<AuthState> emit) async {
    try {
      final isLogout = await authRepository.logout(id: event.id);
      if (isLogout) {
        emit(
          const AuthState.loaded(),
        );
      } else {
        throw Exception("Пользователь не найден");
      }
    } on Object catch (e) {
      emit(AuthState.idle(error: e.toString()));
      rethrow;
    }
  }
}
