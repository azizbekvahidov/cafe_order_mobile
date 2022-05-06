import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoggedIn extends AuthenticationEvent {
  final String token;

  LoggedIn({required this.token});

  @override
  String toString() => 'LoggedIn { token: $token }';

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  List<Object?> get props => throw UnimplementedError();
}

class CloseChange extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetChange extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
