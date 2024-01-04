import 'package:flutter/foundation.dart';
import 'package:myplans_app/core/components/database/database.dart';

import '../../../../core/components/database/src/utils/pattern_match.dart';
import '../../model/user_entity.dart';

sealed class UserState extends _$UserStateBase {
  const UserState._({
    super.user,
    super.error,
  });

  /// User is idle.
  const factory UserState.idle({
    UserEntity user,
    String? error,
  }) = _UserState$Idle;

  /// User is loaded.
  const factory UserState.loaded({
    UserEntity user,
    String? error,
  }) = _UserState$Loaded;
}

/// [UserState.idle] state matcher.
final class _UserState$Idle extends UserState {
  const _UserState$Idle({
    super.user,
    super.error,
  }) : super._();
}

/// [UserState.loaded] state matcher.
final class _UserState$Loaded extends UserState {
  const _UserState$Loaded({
    super.user,
    super.error,
  }) : super._();
}

@immutable
abstract base class _$UserStateBase {
  const _$UserStateBase({required this.user, this.error});

  @nonVirtual
  final UserEntity? user;

  @nonVirtual
  final String? error;

  bool get hasError => error != null;

  bool get hasUser => user != null;

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
    required PatternMatch<R, _UserState$Idle> idle,
    required PatternMatch<R, _UserState$Loaded> loaded,
  }) =>
      switch (this) {
        final _UserState$Idle idleState => idle(idleState),
        final _UserState$Loaded loadedState => loaded(loadedState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _UserState$Idle>? idle,
    PatternMatch<R, _UserState$Loaded>? loaded,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        loaded: loaded ?? (_) => orElse(),
      );

  @override
  String toString() => 'UserState(User: $user, error: $error)';
}
