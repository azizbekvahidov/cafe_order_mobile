import 'package:equatable/equatable.dart';
import '../app_status.dart';

class AuthentifacionState extends Equatable {
  AppStatus? appStatus;
  @override
  List<Object> get props => [];
  AuthentifacionState({this.appStatus = const InitialAppStatus()});
}

AuthentifacionState copyWith({
  AppStatus? formStatus,
}) {
  return AuthentifacionState(
    appStatus: formStatus,
  );
}

class AuthenticationUninitialized extends AuthentifacionState {
  AuthenticationUninitialized() : super(appStatus: InitialAppStatus());
}

class AuthenticationAuthenticated extends AuthentifacionState {
  AuthenticationAuthenticated() : super(appStatus: AppLoggedInStatus());
}

class AuthenticationUnauthenticated extends AuthentifacionState {
  AuthenticationUnauthenticated() : super(appStatus: AppLoggedOutStatus());
}

class AuthenticationLoading extends AuthentifacionState {}
