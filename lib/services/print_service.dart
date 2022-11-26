import 'dart:convert';
import 'dart:io';

import 'package:cafe_mostbyte/components/tabs.dart';
import 'package:cafe_mostbyte/models/department.dart';
import 'package:cafe_mostbyte/models/expense.dart';
import 'package:intl/intl.dart';
import 'package:cafe_mostbyte/models/print_data.dart';
import 'package:cafe_mostbyte/services/api_provider/data_api_provider.dart';
import 'package:cafe_mostbyte/utils/demo.dart';
import 'package:cafe_mostbyte/utils/service.dart';
import 'package:cafe_mostbyte/utils/webview_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pos_printer_manager/pos_printer_manager.dart';
import 'package:webcontent_converter/webcontent_converter.dart';

import '../config/globals.dart' as globals;

class PrintService {
  bool _isLoading = false;
  List<USBPrinter>? _printers;
  DataApiProvider apiProvider = DataApiProvider();

  _scan() async {
    List<USBPrinter> printers = await USBPrinterManager.discover();
    _printers = printers;
  }

  _connect({
    isClose = false,
    isCheck = true,
    Expense? expense,
    PrintData? printData,
    Department? e,
    String orderType = "",
  }) async {
    if (_printers == null) {
      await _scan();
    }
    USBPrinter _printer = _printers!.firstWhere((element) =>
        element.address ==
        (isCheck
            ? e!.printer
            : (isClose
                ? globals.settings!.printerKassa
                : globals.settings!.printer)));
    var paperSize = PaperSize.mm80;
    var profile = await CapabilityProfile.load();
    var manager = USBPrinterManager(_printer, paperSize, profile);
    await manager.connect();
    globals.manager = null;
    if (isCheck) {
      setCheckPrint(e!, printData!, manager, orderType);
    } else {
      setRecieptPrint(expense!, manager);
    }
    globals.manager = manager;
  }

  setCheckPrint(Department e, PrintData printData, USBPrinterManager manager,
      String orderType) async {
    printData = removeDuplicate(printData);
    try {
      final content = Demo.generateCheck(
          data: printData,
          department: e,
          orderType: orderType,
          time: globals.currentExpense!.delivery != null
              ? (globals.currentExpense!.delivery!.delivery_time == "null"
                  ? null
                  : globals.currentExpense!.delivery!.delivery_time)
              : globals.currentExpense!.ready_time);
      var bytes = await WebcontentConverter.contentToImage(
        content: content,
        executablePath: WebViewHelper.executablePath(),
      );
      var service = ESCPrinterService(bytes);
      var data = await service.getBytes();

      if (manager != null) {
        // print("isConnected ${e.printer} ${_manager!.isConnected}");
        manager.writeBytes(data, isDisconnect: false);
      }
      Map<String, dynamic> body = printData.toJson();
      body.addAll({
        "order_date": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        "filial": {"id": globals.filial},
      });
      await apiProvider.setArchive(expense: body, action: "printCheck");
    } catch (e, s) {
      final Directory directory = await getApplicationDocumentsDirectory();
      String filename =
          '${directory.path}/error/${DateFormat('dd.MM.yyyy').format(DateTime.now())}/${DateFormat('HH-mm-ss').format(DateTime.now())}.txt';
      final Future<Null> file =
          File(filename).create(recursive: true).then((File file) async {
        await file.writeAsString("$e\n\r$s");
        // Stuff to do after file has been created...
      });
    }
  }

  PrintData removeDuplicate(PrintData data) {
    data.departments!.forEach((e) {
      if (e.orders != null) {
        e.orders!.map((order) {
          e.orders!.removeWhere((element) => element == order);
        });
      }
    });
    return data;
  }

  checkPrint({PrintData? printData, order_type}) async {
    List<Department>? list = printData!.departments;
    var orderType = "Зал";
    switch (order_type) {
      case "book_table":
        orderType = "Зал";
        break;
      case "delivery":
        orderType = "Доставка";
        break;
      case "take":
        orderType = "С собой";
        break;
    }
    if (list != null) {
      list.forEach((e) {
        _connect(e: e, printData: printData, orderType: orderType);
      });
    }
  }

  setRecieptPrint(Expense expense, USBPrinterManager manager) async {
    final content = Demo.getReceiptContent(data: expense);
    var bytes = await WebcontentConverter.contentToImage(
      content: content,
      executablePath: WebViewHelper.executablePath(),
    );
    var service = ESCPrinterService(bytes);
    var data = await service.getBytes();

    if (manager != null) {
      // print("isConnected ${_manager!.isConnected}");
      manager.writeBytes(data, isDisconnect: false);
    }

    await apiProvider.setArchive(expense: expense, action: "printReciept");
  }

  recieptPrint({Expense? expense, isClose = false}) async {
    if (!globals.currentExpenseChange) {
      _connect(expense: expense, isCheck: false, isClose: isClose);
    } else {
      await checkPrint(
          printData: globals.orderState,
          order_type: globals.currentExpense!.order_type);
      globals.orderState = null;
      tabsState.setState(() {
        globals.currentExpenseChange = false;
      });
      _connect(expense: expense, isCheck: false, isClose: isClose);
    }
  }

  changePrint() async {
    if (_printers == null) {
      await _scan();
    }
    USBPrinter _printer = _printers!.firstWhere(
        (element) => element.address == globals.settings!.printerKassa);
    var paperSize = PaperSize.mm80;
    var profile = await CapabilityProfile.load();
    var manager = USBPrinterManager(_printer, paperSize, profile);
    await manager.connect();
    final content = Demo.getChangeReceiptContent();
    var bytes = await WebcontentConverter.contentToImage(
      content: content,
      executablePath: WebViewHelper.executablePath(),
    );
    var service = ESCPrinterService(bytes);
    var data = await service.getBytes();

    if (manager != null) {
      // print("isConnected ${_manager!.isConnected}");
      manager.writeBytes(data, isDisconnect: false);
    }
    globals.manager = null;

    globals.manager = manager;
  }
}
