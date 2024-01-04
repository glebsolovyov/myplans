import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/auth_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.authRepository}) : super(const UserState.idle()) {
    on<UserEvent>(
      (event, emit) => event.map(
        loadUser: (e) => _loadUser(e, emit),
        create: (e) => _create(e, emit),
        update: (e) => _update(e, emit),
        delete: (e) => _delete(e, emit),
      ),
    );
  }

  ///
  final AuthRepository authRepository;

  Future<void> _loadUser(
      UserEvent$LoadUser event, Emitter<UserState> emit) async {
    try {
      final user = await authRepository.getUserById(id: event.id);
      if (user != null) {
        emit(
          UserState.loaded(user: user),
        );
      } else {
        throw Exception("Пользователь не найден");
      }
    } on Object catch (e) {
      emit(UserState.idle(error: e.toString()));
      rethrow;
    }
  }

  Future<void> _create(
      UserEvent$CreateUser event, Emitter<UserState> emit) async {
    try {
      final newUser = await authRepository.createUser(
          login: event.login, password: event.password);
      final user = await authRepository.getUserById(id: newUser.id);
      if (user != null) {
        emit(
          UserState.loaded(user: user),
        );
      } else {
        throw Exception("Пользователь не найден");
      }
    } on Object catch (e) {
      emit(UserState.idle(error: e.toString()));
      rethrow;
    }
  }

  Future<void> _update(UserEvent$Update event, Emitter<UserState> emit) async {
    try {
      final updatedUser = await authRepository.updateUser(
          id: event.id, login: event.login, password: event.password);
      final user = await authRepository.getUserById(id: event.id);
      if (user != null && updatedUser) {
        emit(
          UserState.loaded(user: user),
        );
      } else {
        throw Exception("Пользователь не найден");
      }
    } on Object catch (e) {
      emit(UserState.idle(error: e.toString()));
      rethrow;
    }
  }

  Future<void> _delete(UserEvent$Delete event, Emitter<UserState> emit) async {
    try {
      final newUser = await authRepository.deleteUser(id: event.id);
      final user = await authRepository.getUserById(id: newUser.id);
      if (user != null) {
        emit(
          UserState.loaded(user: user),
        );
      } else {
        throw Exception("Пользователь не найден");
      }
    } on Object catch (e) {
      emit(UserState.idle(error: e.toString()));
      rethrow;
    }
  }
}
