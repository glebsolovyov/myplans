import 'package:flutter/foundation.dart';
import 'package:myplans_app/feature/auth/model/user_entity.dart';

import '../../../core/components/database/src/utils/pattern_match.dart';

sealed class AuthState extends _$AuthStateBase {
  const AuthState._({
    required super.users,
    super.error,
  });

  /// User is idle.
  const factory AuthState.idle({
    List<UserEntity> users,
    String? error,
  }) = _AuthState$Idle;

  /// User is loaded.
  const factory AuthState.loaded({
    required List<UserEntity> users,
    String? error,
  }) = _AuthState$Loaded;
}

/// [AuthState.idle] state matcher.
final class _AuthState$Idle extends AuthState {
  const _AuthState$Idle({
    super.users = const [],
    super.error,
  }) : super._();
}

/// [AuthState.loaded] state matcher.
final class _AuthState$Loaded extends AuthState {
  const _AuthState$Loaded({
    required super.users,
    super.error,
  }) : super._();
}


@immutable
abstract base class _$AuthStateBase {
  const _$AuthStateBase({
    required this.users, 
    this.error
    });

  @nonVirtual
  final List<UserEntity> users;

  @nonVirtual
  final String? error;


  bool get hasError => error != null;

  bool get hasUsers => users.isNotEmpty;

  bool get isLoaded => maybeMap(
        loaded: (_) => true,
        orElse: () => false,
      );

  /// Indicator whether state is already idling.
  bool get isIdling => maybeMap(
        idle: (_) => true,
        orElse: () => false,
      );

R map<R>({
    required PatternMatch<R, _AuthState$Idle> idle,
    required PatternMatch<R, _AuthState$Loaded> loaded,
  }) =>
      switch (this) {
        final _AuthState$Idle idleState => idle(idleState),
        final _AuthState$Loaded loadedState => loaded(loadedState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };
      R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _AuthState$Idle>? idle,
    PatternMatch<R, _AuthState$Loaded>? loaded,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        loaded: loaded ?? (_) => orElse(),
      );

      @override
  String toString() => 'AuthState(Users: $users, error: $error)';
}