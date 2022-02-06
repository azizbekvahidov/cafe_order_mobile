import 'package:cafe_mostbyte/models/category.dart';
import 'package:cafe_mostbyte/models/delivery_bot.dart';
import 'package:cafe_mostbyte/models/expense.dart';
import 'package:cafe_mostbyte/models/menu_item.dart';
import 'package:cafe_mostbyte/services/api_provider/data_api_provider.dart';

class BotOrderRepository {
  DataApiProvider dataApiProvider = DataApiProvider();

  Future<List<DeliveryBot>> botOrderApproveList({id}) =>
      dataApiProvider.getBotOrderApproveList(id: id);
}
