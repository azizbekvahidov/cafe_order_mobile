import 'delivery_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth/auth_repository.dart';
import '../form_submission_status.dart';
import 'delivery_event.dart';
import 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  final DeliveryRepository repo;

  DeliveryBloc({required this.repo}) : super(DeliveryState());

  @override
  Stream<DeliveryState> mapEventToState(DeliveryEvent event) async* {
    if (event is ExpenseInitialized) {
      yield state.copyWith(formStatus: InitialFormStatus());
    } else {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        // await authRepo.login(login: state.phone, pass: state.password);
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
