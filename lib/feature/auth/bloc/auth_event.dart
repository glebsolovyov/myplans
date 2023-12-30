import 'package:flutter/material.dart';

import '../../../core/components/database/src/utils/pattern_match.dart';

@immutable
sealed class AuthEvent extends _$AuthEventBase {
  const AuthEvent();

  const factory AuthEvent.load() = AuthEvent$Load;
}

///
final class AuthEvent$Load extends AuthEvent {
  const AuthEvent$Load() : super();
}

///
abstract base class _$AuthEventBase {
  const _$AuthEventBase();

  ///
  R map<R>({required PatternMatch<R, AuthEvent$Load> load}) =>
      switch (this) {
        final AuthEvent$Load s => load(s),
        _ => throw AssertionError(),
      };

  ///
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, AuthEvent$Load>? load,
  }) =>
      map<R>(load: load ?? (_) => orElse());

  ///
  R? mapOrNull<R>({PatternMatch<R, AuthEvent$Load>? load}) => map<R?>(
        load: load ?? (_) => null,
      );
}
