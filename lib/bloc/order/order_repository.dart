import 'package:cafe_mostbyte/models/expense.dart';
import 'package:cafe_mostbyte/models/menu_item.dart';
import 'package:cafe_mostbyte/services/api_provider/data_api_provider.dart';

class OrderRepository {
  DataApiProvider dataApiProvider = DataApiProvider();

  Future<List<dynamic>> categoryList() => dataApiProvider.getCategory();
  Future<List<MenuItem>> productList({id}) =>
      dataApiProvider.getProducts(id: id);
  Future<List<dynamic>> expenseList({id}) =>
      dataApiProvider.getExpenses(id: id);
  Future<Expense?> expense({id}) => dataApiProvider.getExpense(id: id);
}
