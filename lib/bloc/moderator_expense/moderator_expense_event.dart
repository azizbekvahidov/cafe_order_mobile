import 'package:cafe_mostbyte/models/delivery_bot.dart';

abstract class ModeratorExpenseEvent {}

class ModeratorExpenseInitialized extends ModeratorExpenseEvent {}

class ModeratorExpenseCreate extends ModeratorExpenseEvent {}
