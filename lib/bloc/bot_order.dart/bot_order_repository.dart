import 'package:cafe_mostbyte/models/delivery_bot.dart';
import 'package:cafe_mostbyte/models/delivery_bot_order.dart';
import 'package:cafe_mostbyte/services/api_provider/data_api_provider.dart';

class BotOrderRepository {
  DataApiProvider dataApiProvider = DataApiProvider();

  Future<List<DeliveryBot>> botOrderApproveList({id}) =>
      dataApiProvider.getBotOrderApproveList(id: id);
  Future<List<DeliveryBotOrder>> botOrderList({id}) =>
      dataApiProvider.getBotOrderList(id: id);
}
