import 'package:cafe_mostbyte/bloc/bot_order.dart/bot_order_repository.dart';
import 'package:cafe_mostbyte/models/delivery_bot.dart';
import 'package:cafe_mostbyte/models/expense.dart';
import 'package:cafe_mostbyte/models/menu_item.dart';
import 'package:rxdart/rxdart.dart';

class BotOrderBloc {
  BotOrderRepository repo = BotOrderRepository();
  final _botOrderListFetcher = PublishSubject<List<DeliveryBot>>();

  Stream<List<DeliveryBot>> get botOrderList => _botOrderListFetcher.stream;

  fetchOrders({id}) async {
    List<DeliveryBot> response = await repo.botOrderList(id: id);
    _botOrderListFetcher.sink.add(response);
  }

  dispose() async {
    await _botOrderListFetcher.close();
  }
}

final botOrderBloc = BotOrderBloc();
