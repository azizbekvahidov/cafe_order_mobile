import '../form_submission_status.dart';

class ModeratorExpenseState {
  final FormSubmissionStatus formStatus;

  ModeratorExpenseState({
    this.formStatus = const InitialFormStatus(),
  });

  ModeratorExpenseState copyWith({
    FormSubmissionStatus? formStatus,
  }) {
    return ModeratorExpenseState(
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
