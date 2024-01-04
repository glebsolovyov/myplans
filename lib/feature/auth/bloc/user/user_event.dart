import 'package:flutter/foundation.dart';

import '../../../../core/components/database/src/utils/pattern_match.dart';

@immutable
sealed class UserEvent extends _$UserEventBase {
  const UserEvent();

  const factory UserEvent.loadUser(int id) = UserEvent$LoadUser;
  const factory UserEvent.create(String login, String password) =
      UserEvent$CreateUser;
  const factory UserEvent.update(int id, String login, String password) =
      UserEvent$Update;
  const factory UserEvent.delete(int id) = UserEvent$Delete;
}

///
final class UserEvent$LoadUser extends UserEvent {
  final int id;
  const UserEvent$LoadUser(this.id) : super();
}

final class UserEvent$CreateUser extends UserEvent {
  final String login;
  final String password;
  const UserEvent$CreateUser(this.login, this.password) : super();
}

///
final class UserEvent$Delete extends UserEvent {
  final int id;
  const UserEvent$Delete(this.id) : super();
}

final class UserEvent$Update extends UserEvent {
  final int id;
  final String login;
  final String password;

  const UserEvent$Update(this.id, this.login, this.password) : super();
}

///
abstract base class _$UserEventBase {
  const _$UserEventBase();

  ///
  R map<R>(
          {required PatternMatch<R, UserEvent$LoadUser> loadUser,
          required PatternMatch<R, UserEvent$CreateUser> create,
          required PatternMatch<R, UserEvent$Update> update,
          required PatternMatch<R, UserEvent$Delete> delete}) =>
      switch (this) {
        final UserEvent$LoadUser s => loadUser(s),
        final UserEvent$CreateUser s => create(s),
        final UserEvent$Update s => update(s),
        final UserEvent$Delete s => delete(s),
        _ => throw AssertionError(),
      };

  ///
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, UserEvent$LoadUser>? loadUser,
    PatternMatch<R, UserEvent$CreateUser>? create,
    PatternMatch<R, UserEvent$Update>? update,
    PatternMatch<R, UserEvent$Delete>? delete,
  }) =>
      map<R>(
        loadUser: loadUser ?? (_) => orElse(),
        create: create ?? (_) => orElse(),
        update: update ?? (_) => orElse(),
        delete: delete ?? (_) => orElse(),
      );

  ///
  R? mapOrNull<R>(
          {PatternMatch<R, UserEvent$LoadUser>? loadUser,
          PatternMatch<R, UserEvent$CreateUser>? create,
          PatternMatch<R, UserEvent$Update>? update,
          PatternMatch<R, UserEvent$Delete>? delete}) =>
      map<R?>(
        loadUser: loadUser ?? (_) => null,
        create: create ?? (_) => null,
        update: update ?? (_) => null,
        delete: delete ?? (_) => null,
      );
}
