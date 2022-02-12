import 'package:cafe_mostbyte/models/employee.dart';
import 'package:cafe_mostbyte/models/expense.dart';
import 'package:cafe_mostbyte/models/table.dart';
import 'package:cafe_mostbyte/services/api_provider/data_api_provider.dart';
import 'package:cafe_mostbyte/services/network_service.dart';
import '../../../config/globals.dart' as globals;

class ModeratorExpenseRepository {
  NetworkService net = NetworkService();
  DataApiProvider dataApiProvider = DataApiProvider();

  Future<Expense> createExpense() async {
    try {
      var expense = Expense(
          id: 0,
          order_date: "",
          print: 0,
          expense_sum: 0,
          comment: "",
          prepaid: 0,
          prepaidSum: 0,
          ready_time: "",
          phone: "",
          employee: Employee(
              employee_id: globals.userData!.id,
              check_percent: globals.userData!.check_percent,
              login: globals.userData!.login,
              name: globals.userData!.name),
          order: [],
          table: Table(id: 0, name: ""));
      return expense;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
