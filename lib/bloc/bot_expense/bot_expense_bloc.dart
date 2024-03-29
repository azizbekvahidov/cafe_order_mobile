import 'package:cafe_mostbyte/bloc/bot_expense/bot_expense_repository.dart';
import 'package:cafe_mostbyte/models/expense.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../form_submission_status.dart';
import 'bot_expense_event.dart';
import 'bot_expense_state.dart';
import '../../config/globals.dart' as globals;
import '../../services/helper.dart' as helper;

class BotExpenseBloc extends Bloc<BotExpenseEvent, BotExpenseState> {
  final BotExpenseRepository repo;

  BotExpenseBloc({required this.repo}) : super(BotExpenseState());

  @override
  Stream<BotExpenseState> mapEventToState(BotExpenseEvent event) async* {
    if (event is BotExpenseInitialized) {
      yield state.copyWith(formStatus: InitialFormStatus());
    } else if (event is AddData) {
      yield state.copyWith(data: event.data);
    } else if (event is AddToExpense) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        Expense expense = await repo.addToExpense(data: state.data);
        globals.currentExpense = expense;
        expense.order.forEach((element) {
          helper.generateCheck(
            data: element.product!,
            type: element.type,
            amount: element.amount,
            comment: element.comment,
            expense: expense,
          );
        });
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    } else if (event is AddExpense) {
      try {
        globals.currentExpense = await repo.addExpense(data: state.data);
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    } else if (event is AddBotOrder) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await repo.AddBotOrder();
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    } else if (event is CancelBotOrder) {
      await repo.CancelBotOrder();
      yield state.copyWith(formStatus: FormSubmitting());
      try {
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
