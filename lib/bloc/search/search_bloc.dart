import './search_repository.dart';
import '../../models/menu_item.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  SearchRepository repo = SearchRepository();
  final _searchFetcher = PublishSubject<List<MenuItem>>();

  Stream<List<MenuItem>> get productList => _searchFetcher.stream;

  fetchProducts({query}) async {
    List<MenuItem> response = await repo.searchList(query: query);
    _searchFetcher.sink.add(response);
  }

  dispose() async {
    await _searchFetcher.close();
  }
}

final searchBloc = SearchBloc();
