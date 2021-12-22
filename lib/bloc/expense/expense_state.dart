import '../form_submission_status.dart';

class ExpenseState {
  final FormSubmissionStatus formStatus;

  ExpenseState({
    this.formStatus = const InitialFormStatus(),
  });

  ExpenseState copyWith({
    FormSubmissionStatus? formStatus,
  }) {
    return ExpenseState(
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
