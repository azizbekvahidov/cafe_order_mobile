import 'dart:async';

import 'package:bloc/bloc.dart';
import './authentificate_event.dart';
import './authentification_state.dart';
import '../../services/api_provider/user/user_repository.dart';
import '../../config/globals.dart' as globals;

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthentifacionState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationUninitialized());

  @override
  AuthentifacionState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthentifacionState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();
      if (hasToken) {
        globals.isAuth = hasToken;
        globals.userData = await userRepository.getUser();

        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      globals.isAuth = false;
      globals.userData = null;
      globals.token = "";
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }

  void dispose() {}
}
