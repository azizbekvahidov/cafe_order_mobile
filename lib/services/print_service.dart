import 'package:cafe_mostbyte/models/department.dart';
import 'package:cafe_mostbyte/models/print_data.dart';
import 'package:cafe_mostbyte/utils/demo.dart';
import 'package:cafe_mostbyte/utils/service.dart';
import 'package:cafe_mostbyte/utils/webview_helper.dart';
import 'package:pos_printer_manager/models/usb_printer.dart';
import 'package:pos_printer_manager/pos_printer_manager.dart';
import 'package:webcontent_converter/webcontent_converter.dart';

class PrintService {
  bool _isLoading = false;
  USBPrinterManager? _manager;
  List<USBPrinter>? _printers;

  _scan() async {
    List<USBPrinter> printers = await USBPrinterManager.discover();
    _printers = printers;
  }

  _connect(Department e, PrintData printData) async {
    if (_printers == null) {
      await _scan();
    }
    USBPrinter _printer =
        _printers!.firstWhere((element) => element.address == e.printer);
    var paperSize = PaperSize.mm80;
    var profile = await CapabilityProfile.load();
    var manager = USBPrinterManager(_printer, paperSize, profile);
    await manager.connect();
    _manager = null;
    setCheckPrint(e, printData, manager);
    _manager = manager;
  }

  setCheckPrint(
      Department e, PrintData printData, USBPrinterManager manager) async {
    final content = Demo.generateCheck(data: printData, department: e);
    var bytes = await WebcontentConverter.contentToImage(
      content: content,
      executablePath: WebViewHelper.executablePath(),
    );
    var service = ESCPrinterService(bytes);
    var data = await service.getBytes();

    if (manager != null) {
      print("isConnected ${e.printer} ${_manager!.isConnected}");
      manager.writeBytes(data, isDisconnect: false);
    }
  }

  checkPrinter({PrintData? printData}) async {
    List<Department>? list = printData!.departments;

    if (list != null) {
      list.forEach((e) async {
        _connect(e, printData);
      });
    }
  }
}
