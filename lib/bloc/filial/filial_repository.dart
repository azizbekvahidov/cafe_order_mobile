import 'package:cafe_mostbyte/models/category.dart';
import 'package:cafe_mostbyte/models/filial.dart';
import 'package:cafe_mostbyte/services/api_provider/data_api_provider.dart';

class FilialRepository {
  DataApiProvider dataApiProvider = DataApiProvider();

  Future<List<Filial>> filialList() => dataApiProvider.getFilials();
}
