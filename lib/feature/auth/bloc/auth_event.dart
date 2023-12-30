import 'package:flutter/material.dart';

import '../../../core/components/database/src/utils/pattern_match.dart';

@immutable
sealed class AuthEvent extends _$AuthEventBase {
  const AuthEvent();

  const factory AuthEvent.load() = AuthEvent$Load;
  const factory AuthEvent.delete(int id) = AuthEvent$Delete;
}

final class AuthEvent$Delete extends AuthEvent {
  final int id;
  const AuthEvent$Delete(this.id) : super();
}

///
final class AuthEvent$Load extends AuthEvent {
  const AuthEvent$Load() : super();
}

///
abstract base class _$AuthEventBase {
  const _$AuthEventBase();

  ///
  R map<R>(
          {required PatternMatch<R, AuthEvent$Load> load,
          required PatternMatch<R, AuthEvent$Delete> delete}) =>
      switch (this) {
        final AuthEvent$Load s => load(s),
        final AuthEvent$Delete s => delete(s),
        _ => throw AssertionError(),
      };

  ///
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, AuthEvent$Load>? load,
    PatternMatch<R, AuthEvent$Delete>? delete,
  }) =>
      map<R>(
        load: load ?? (_) => orElse(),
        delete: delete ?? (_) => orElse(),
      );

  ///
  R? mapOrNull<R>(
          {PatternMatch<R, AuthEvent$Load>? load,
          PatternMatch<R, AuthEvent$Delete>? delete}) =>
      map<R?>(
        load: load ?? (_) => null,
        delete: delete ?? (_) => null,
      );
}
