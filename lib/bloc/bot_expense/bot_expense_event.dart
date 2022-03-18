import 'package:cafe_mostbyte/models/delivery_bot.dart';

abstract class BotExpenseEvent {}

class BotExpenseInitialized extends BotExpenseEvent {}

class AddToExpense extends BotExpenseEvent {}

class AddExpense extends BotExpenseEvent {}

class AddData extends BotExpenseEvent {
  final DeliveryBot data;
  AddData({required this.data});
}

class AddBotOrder extends BotExpenseEvent {}

class CancelBotOrder extends BotExpenseEvent {}
