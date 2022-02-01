import 'package:cafe_mostbyte/bloc/bot_expense/bot_expense_repository.dart';
import 'package:cafe_mostbyte/bloc/expense/expense_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../form_submission_status.dart';
import 'bot_expense_event.dart';
import 'bot_expense_state.dart';

class BotExpenseBloc extends Bloc<BotExpenseEvent, BotExpenseState> {
  final BotExpenseRepository repo;

  BotExpenseBloc({required this.repo}) : super(BotExpenseState());

  @override
  Stream<BotExpenseState> mapEventToState(BotExpenseEvent event) async* {
    if (event is BotExpenseInitialized) {
      yield state.copyWith(formStatus: InitialFormStatus());
    }
    // else if (event is ExpenseDiscount) {
    //   yield state.copyWith(formStatus: FormSubmitting());
    //   try {
    //     await repo.discountExpense();
    //     yield state.copyWith(formStatus: SubmissionSuccess());
    //   } catch (e) {
    //     yield state.copyWith(formStatus: SubmissionFailed(e));
    //   }
    // }
    else {
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
