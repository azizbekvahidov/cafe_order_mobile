import 'package:cafe_mostbyte/models/department.dart';
import 'package:cafe_mostbyte/models/expense.dart';
import 'package:cafe_mostbyte/models/print_data.dart';
import 'package:cafe_mostbyte/utils/demo.dart';
import 'package:cafe_mostbyte/utils/service.dart';
import 'package:cafe_mostbyte/utils/webview_helper.dart';
import 'package:pos_printer_manager/pos_printer_manager.dart';
import 'package:webcontent_converter/webcontent_converter.dart';

import '../config/globals.dart' as globals;

class PrintService {
  bool _isLoading = false;
  List<USBPrinter>? _printers;

  _scan() async {
    List<USBPrinter> printers = await USBPrinterManager.discover();
    _printers = printers;
  }

  _connect({
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
        element.address == (isCheck ? e!.printer : globals.settings!.printer));
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
    final content = Demo.generateCheck(
        data: printData,
        department: e,
        orderType: orderType,
        time: globals.currentExpense!.delivery != null
            ? globals.currentExpense!.delivery!.delivery_time
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
      list.forEach((e) async {
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
  }

  recieptPrint({Expense? expense}) async {
    _connect(expense: expense, isCheck: false);
  }

  changePrint() async {
    if (_printers == null) {
      await _scan();
    }
    USBPrinter _printer = _printers!
        .firstWhere((element) => element.address == globals.settings!.printer);
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
