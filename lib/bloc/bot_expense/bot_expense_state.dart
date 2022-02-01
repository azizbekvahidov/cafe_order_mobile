import '../form_submission_status.dart';

class BotExpenseState {
  final FormSubmissionStatus formStatus;

  BotExpenseState({
    this.formStatus = const InitialFormStatus(),
  });

  BotExpenseState copyWith({
    FormSubmissionStatus? formStatus,
  }) {
    return BotExpenseState(
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
