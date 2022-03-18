import 'package:cafe_mostbyte/bloc/bot_order.dart/bot_order_repository.dart';
import 'package:cafe_mostbyte/models/delivery_bot.dart';
import 'package:rxdart/rxdart.dart';

class BotOrderBloc {
  BotOrderRepository repo = BotOrderRepository();
  final _botOrderApproveListFetcher = PublishSubject<List<DeliveryBot>>();

  Stream<List<DeliveryBot>> get botOrderApproveList =>
      _botOrderApproveListFetcher.stream;

  fetchApproveOrders({id}) async {
    List<DeliveryBot> response = await repo.botOrderApproveList(id: id);
    _botOrderApproveListFetcher.sink.add(response);
  }

  dispose() async {
    await _botOrderApproveListFetcher.close();
  }
}

final botOrderBloc = BotOrderBloc();
