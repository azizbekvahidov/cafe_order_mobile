import '../../models/menu_item.dart';
import 'package:cafe_mostbyte/services/api_provider/data_api_provider.dart';

class SearchRepository {
  DataApiProvider dataApiProvider = DataApiProvider();

  Future<List<MenuItem>> searchList({query}) =>
      dataApiProvider.searchProducts(query: query);
}
