import 'package:cafe_mostbyte/bloc/bot_order.dart/bot_order_repository.dart';
import 'package:cafe_mostbyte/models/delivery_bot.dart';
import 'package:cafe_mostbyte/models/delivery_bot_order.dart';
import 'package:rxdart/rxdart.dart';

class BotOrderBloc {
  BotOrderRepository repo = BotOrderRepository();
  final _botOrderApproveListFetcher = PublishSubject<List<DeliveryBot>>();
  final _botOrderListFetcher = PublishSubject<List<DeliveryBotOrder>>();

  Stream<List<DeliveryBot>> get botOrderApproveList =>
      _botOrderApproveListFetcher.stream;
  Stream<List<DeliveryBotOrder>> get botOrderList =>
      _botOrderListFetcher.stream;

  fetchApproveOrders({id}) async {
    List<DeliveryBot> response = await repo.botOrderApproveList(id: id);
    _botOrderApproveListFetcher.sink.add(response);
  }

  fetchBotOrders({id}) async {
    List<DeliveryBotOrder> response = await repo.botOrderList(id: id);
    _botOrderListFetcher.sink.add(response);
  }

  dispose() async {
    await _botOrderApproveListFetcher.close();
    await _botOrderListFetcher.close();
  }
}

final botOrderBloc = BotOrderBloc();
