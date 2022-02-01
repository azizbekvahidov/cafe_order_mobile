import '../form_submission_status.dart';

class DeliveryState {
  final FormSubmissionStatus formStatus;

  DeliveryState({
    this.formStatus = const InitialFormStatus(),
  });

  DeliveryState copyWith({
    FormSubmissionStatus? formStatus,
  }) {
    return DeliveryState(
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
