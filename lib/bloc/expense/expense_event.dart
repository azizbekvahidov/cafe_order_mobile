abstract class ExpenseEvent {}

class ExpenseInitialized extends ExpenseEvent {}

class ExpenseCreate extends ExpenseEvent {}

class ExpenseUpdate extends ExpenseEvent {}

class ExpenseClose extends ExpenseEvent {}

class ExpenseTerminalClose extends ExpenseEvent {}

class ExpenseDebtClose extends ExpenseEvent {}

class ExpensAvansClose extends ExpenseEvent {}

class LoginSubmitted extends ExpenseEvent {}
