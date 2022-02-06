import 'package:cafe_mostbyte/models/delivery_bot.dart';

import '../form_submission_status.dart';

class BotExpenseState {
  DeliveryBot? data;
  final FormSubmissionStatus formStatus;

  BotExpenseState({
    this.data,
    this.formStatus = const InitialFormStatus(),
  });

  BotExpenseState copyWith({
    DeliveryBot? data,
    FormSubmissionStatus? formStatus,
  }) {
    return BotExpenseState(
      data: data ?? this.data,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
