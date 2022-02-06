abstract class DeliveryEvent {}

class ExpenseInitialized extends DeliveryEvent {}

class ExpenseCreate extends DeliveryEvent {}

class ExpenseUpdate extends DeliveryEvent {}

class ExpenseClose extends DeliveryEvent {}

class ExpenseTerminalClose extends DeliveryEvent {}

class ExpenseDebtClose extends DeliveryEvent {}

class ExpenseAvansClose extends DeliveryEvent {}

class ExpenseDelivery extends DeliveryEvent {}

class ExpenseTakeaway extends DeliveryEvent {}

class ExpenseDiscount extends DeliveryEvent {}

class LoginSubmitted extends DeliveryEvent {}
