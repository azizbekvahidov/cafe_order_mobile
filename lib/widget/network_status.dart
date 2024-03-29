import 'dart:async';

// import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/material.dart';
import '../config/globals.dart' as globals;

/// Виджет, отображающий наличие сети или её отстутствие
class NetworkStatus extends StatefulWidget {
  /// Отображать в случае наличия сети
  final Widget onlineWidget;

  /// Отображать в случае отсутствия сети
  final Widget offlineWidget;

  /// Адрес для проверки наличия соединения
  final String? pingUrl;

  const NetworkStatus({
    Key? key,
    required this.onlineWidget,
    required this.offlineWidget,
    this.pingUrl,
  }) : super(key: key);

  @override
  _NetworkStatusState createState() => _NetworkStatusState();
}

class _NetworkStatusState extends State<NetworkStatus> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    String apiLink = globals.apiLink;
    if (apiLink != "") {
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
        // ConnectivityUtils.instance.setServerToPing(apiLink);
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    // StreamBuilder<bool>(
    //   stream: ConnectivityUtils.instance.isPhoneConnectedStream,
    //   initialData: false,
    //   builder: (context, AsyncSnapshot<bool> snapshot) {
    //     print(snapshot.data);
    //     if (snapshot.hasData) {
    //       return widget.onlineWidget ?? Icon(Icons.network_wifi);
    //     } else {
    //       return widget.offlineWidget ?? Icon(Icons.airplanemode_active);
    //     }
    //   },
    // );
  }
}
