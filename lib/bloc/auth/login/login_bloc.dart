import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth_repository.dart';
import '../../form_submission_status.dart';
import './login_event.dart';
import './login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  LoginBloc({required this.authRepo}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInitialized) {
      yield state.copyWith(formStatus: InitialFormStatus());
    } else if (event is LoginPhoneChanged) {
      yield state.copyWith(phone: event.phone);
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await authRepo.login(login: state.phone, pass: state.password);
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
