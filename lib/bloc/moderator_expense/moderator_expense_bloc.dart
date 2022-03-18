import 'package:cafe_mostbyte/bloc/moderator_expense/moderator_expense_event.dart';
import 'package:cafe_mostbyte/bloc/moderator_expense/moderator_expense_repository.dart';
import 'package:cafe_mostbyte/bloc/moderator_expense/moderator_expense_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../form_submission_status.dart';
import '../../config/globals.dart' as globals;

class ModeratorExpenseBloc
    extends Bloc<ModeratorExpenseEvent, ModeratorExpenseState> {
  final ModeratorExpenseRepository repo;

  ModeratorExpenseBloc({required this.repo}) : super(ModeratorExpenseState());

  @override
  Stream<ModeratorExpenseState> mapEventToState(
      ModeratorExpenseEvent event) async* {
    if (event is ModeratorExpenseInitialized) {
      yield state.copyWith(formStatus: InitialFormStatus());
    } else if (event is ModeratorExpenseCreate) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        globals.currentExpense = await repo.createExpense();
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
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
