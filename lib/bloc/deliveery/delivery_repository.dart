import 'dart:convert';
import 'package:cafe_mostbyte/models/delivery.dart';
import 'package:cafe_mostbyte/services/api_provider/data_api_provider.dart';
import 'package:cafe_mostbyte/services/network_service.dart';
import '../../../config/globals.dart' as globals;
import '../../../services/helper.dart' as helper;

class DeliveryRepository {
  NetworkService net = NetworkService();
  DataApiProvider dataApiProvider = DataApiProvider();
}
