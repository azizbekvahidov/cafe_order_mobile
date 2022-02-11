import './expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../form_submission_status.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository repo;

  ExpenseBloc({required this.repo}) : super(ExpenseState());

  @override
  Stream<ExpenseState> mapEventToState(ExpenseEvent event) async* {
    if (event is ExpenseInitialized) {
      yield state.copyWith(formStatus: InitialFormStatus());
    } else if (event is ExpenseCreate) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await repo.createExpense();
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    } else if (event is ExpenseUpdate) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await repo.updateExpense();
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    } else if (event is ExpenseClose) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await repo.closeExpense();
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    } else if (event is ExpenseTerminalClose) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await repo.terminalCloseExpense();
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    } else if (event is ExpenseDebtClose) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await repo.debtCloseExpense();
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    } else if (event is ExpenseAvansClose) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await repo.avansCloseExpense();
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    } else if (event is ExpenseDelivery) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await repo.deliveryExpense();
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    } else if (event is ExpenseTakeaway) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await repo.takeawayExpense();
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    } else if (event is ExpenseDiscount) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await repo.discountExpense();
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
