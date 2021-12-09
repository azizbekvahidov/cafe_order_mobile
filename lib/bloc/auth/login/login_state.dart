import '../../form_submission_status.dart';

class LoginState {
  final String phone;
  final String password;
  bool get isValidPassword => password.length > 6;
  final FormSubmissionStatus formStatus;

  LoginState({
    this.phone = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? phone,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
