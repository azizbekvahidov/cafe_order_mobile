import 'package:cafe_mostbyte/bloc/order/order_repository.dart';
import 'package:cafe_mostbyte/models/expense.dart';
import 'package:cafe_mostbyte/models/menu_item.dart';
import 'package:rxdart/rxdart.dart';

class OrderBloc {
  OrderRepository repo = OrderRepository();
  final _categoryFetcher = PublishSubject<List<dynamic>>();
  final _productFetcher = PublishSubject<List<MenuItem>>();
  final _expensesFetcher = PublishSubject<List<dynamic>>();
  final _expenseFetcher = PublishSubject<Expense?>();

  Stream<List<dynamic>> get categoryList => _categoryFetcher.stream;
  Stream<List<MenuItem>> get productList => _productFetcher.stream;
  Stream<List<dynamic>> get expenseList => _expensesFetcher.stream;
  Stream<Expense?> get expense => _expenseFetcher.stream;

  fetchCategory() async {
    List<dynamic> response = await repo.categoryList();
    _categoryFetcher.sink.add(response);
  }

  fetchProduct({id}) async {
    List<MenuItem> response = await repo.productList(id: id);
    _productFetcher.sink.add(response);
  }

  fetchExpenses({id}) async {
    List<dynamic> response = await repo.expenseList(id: id);
    _expensesFetcher.sink.add(response);
  }

  fetchExpense({id}) async {
    Expense? response = await repo.expense(id: id);
    _expenseFetcher.sink.add(response);
  }

  dispose() async {
    await _categoryFetcher.close();
    await _productFetcher.close();
    await _expensesFetcher.close();
    await _expenseFetcher.close();
  }
}

final orderBloc = OrderBloc();
