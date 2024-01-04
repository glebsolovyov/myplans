import 'package:flutter/material.dart';

import '../../../../core/components/database/src/utils/pattern_match.dart';

@immutable
sealed class AuthEvent extends _$AuthEventBase {
  const AuthEvent();

  const factory AuthEvent.loadAllUsers() = AuthEvent$LoadAllUsers;
}

///
final class AuthEvent$LoadAllUsers extends AuthEvent {
  const AuthEvent$LoadAllUsers() : super();
}

///
///
abstract base class _$AuthEventBase {
  const _$AuthEventBase();

  ///
  R map<R>({required PatternMatch<R, AuthEvent$LoadAllUsers> loadAllUsers}) =>
      switch (this) {
        final AuthEvent$LoadAllUsers s => loadAllUsers(s),
        _ => throw AssertionError(),
      };

  ///
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, AuthEvent$LoadAllUsers>? loadAllUsers,
  }) =>
      map<R>(
        loadAllUsers: loadAllUsers ?? (_) => orElse(),
      );

  ///
  R? mapOrNull<R>({PatternMatch<R, AuthEvent$LoadAllUsers>? loadAllUsers}) =>
      map<R?>(
        loadAllUsers: loadAllUsers ?? (_) => null,
      );
}
