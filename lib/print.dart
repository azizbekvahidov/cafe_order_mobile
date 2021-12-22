import 'package:cafe_mostbyte/models/department.dart';
import 'package:cafe_mostbyte/models/order.dart';
import 'package:cafe_mostbyte/models/print_data.dart';
import 'package:cafe_mostbyte/services/translit.dart';
// import 'package:charset_converter/charset_converter.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:intl/intl.dart';
import 'config/globals.dart' as globals;
import 'services/helper.dart' as helper;

class Print {
  // Future<void> printReceipt(NetworkPrinter printer, Map data) async {
  //   try {
  //     // Print image
  //     // final ByteData data = await rootBundle.load('assets/rabbit_black.jpg');
  //     // final Uint8List bytes = data.buffer.asUint8List();
  //     // final Image image = decodeImage(bytes);
  //     // printer.image(image);

  //     // Uint8List encTxt4 =
  //     //     await CharsetConverter.encode("CP866", "Russian: Привет мир!");
  //     // printer.textEncoded(encTxt4, styles: PosStyles(codeTable: "CP866"));

  //     Uint8List kafeTxt =
  //         await CharsetConverter.encode("CP866", globals.settings!.cafe_name);
  //     printer.textEncoded(kafeTxt,
  //         styles: PosStyles(
  //           align: PosAlign.center,
  //           codeTable: "CP866",
  //           height: PosTextSize.size2,
  //           width: PosTextSize.size2,
  //         ),
  //         linesAfter: 1);

  //     var newFormat = DateFormat("yy-MM-dd HH:mm");

  //     printer.text(newFormat.format(DateTime.now()),
  //         styles: PosStyles(align: PosAlign.center), linesAfter: 1);
  //     Uint8List openTxt = await CharsetConverter.encode(
  //         "CP866", "Открыт: ${data['expense']["order_date"]}");
  //     Uint8List check = await CharsetConverter.encode(
  //         "CP866", "Счет: ${data['expense']["expense_id"]}");
  //     Uint8List tableTxt = await CharsetConverter.encode(
  //         "CP866", "Стол №: ${data['expense']["table_name"]}");
  //     Uint8List waiter = await CharsetConverter.encode(
  //         "CP866", "Официант: ${data['expense']["employee_name"]}");
  //     printer.row([
  //       PosColumn(
  //           textEncoded: openTxt,
  //           width: 6,
  //           styles: PosStyles(align: PosAlign.left, codeTable: "CP866")),
  //       PosColumn(
  //           textEncoded: check,
  //           width: 6,
  //           styles: PosStyles(align: PosAlign.right, codeTable: "CP866")),
  //     ]);
  //     printer.row([
  //       PosColumn(
  //           textEncoded: waiter,
  //           width: 6,
  //           styles: PosStyles(align: PosAlign.left, codeTable: "CP866")),
  //       PosColumn(
  //           textEncoded: tableTxt,
  //           width: 6,
  //           styles: PosStyles(align: PosAlign.right, codeTable: "CP866")),
  //     ]);
  //     // printer.text('Web: www.example.com',
  //     //     styles: PosStyles(align: PosAlign.center), linesAfter: 1);

  //     printer.hr();
  //     Uint8List nameTxt =
  //         await CharsetConverter.encode("CP866", "Наименование");
  //     Uint8List cntTxt = await CharsetConverter.encode("CP866", "Кол");
  //     Uint8List priceTxt = await CharsetConverter.encode("CP866", "Цена");
  //     Uint8List totalTxt = await CharsetConverter.encode("CP866", "Всего");
  //     printer.row([
  //       PosColumn(
  //           textEncoded: nameTxt,
  //           width: 7,
  //           styles: PosStyles(codeTable: "CP866")),
  //       PosColumn(
  //           textEncoded: cntTxt,
  //           width: 1,
  //           styles: PosStyles(codeTable: "CP866")),
  //       PosColumn(
  //           textEncoded: priceTxt,
  //           width: 2,
  //           styles: PosStyles(align: PosAlign.right, codeTable: "CP866")),
  //       PosColumn(
  //           textEncoded: totalTxt,
  //           width: 2,
  //           styles: PosStyles(align: PosAlign.right, codeTable: "CP866")),
  //     ]);
  //     double total = 0;
  //     printer.hr();
  //     List orders;
  //     int i = 0;
  //     for (var i = 0; i < data["order"].length; i++) {
  //       var val = data["order"][i];
  //       List<PosColumn> pr = [
  //         PosColumn(
  //             textEncoded: await CharsetConverter.encode("CP866", val["name"]),
  //             width: 7,
  //             styles: PosStyles(codeTable: "CP866")),
  //         PosColumn(text: val["cnt"].toString(), width: 1),
  //         PosColumn(
  //             text: val["price"].toString(),
  //             width: 2,
  //             styles: PosStyles(align: PosAlign.right)),
  //         PosColumn(
  //             text: (val["cnt"] * val["price"]).toString(),
  //             width: 2,
  //             styles: PosStyles(align: PosAlign.right)),
  //       ];
  //       printer.row(pr);
  //       total += val["cnt"] * val["price"];
  //     }
  //     printer.hr();
  //     Uint8List summTxt = await CharsetConverter.encode("CP866", "Сумма :");
  //     printer.row([
  //       PosColumn(
  //           textEncoded: summTxt,
  //           width: 6,
  //           styles: PosStyles(
  //               height: PosTextSize.size1,
  //               width: PosTextSize.size1,
  //               codeTable: "CP866")),
  //       PosColumn(
  //           text: total.toString(),
  //           width: 6,
  //           styles: PosStyles(
  //             align: PosAlign.right,
  //             height: PosTextSize.size1,
  //             width: PosTextSize.size1,
  //           )),
  //     ]);

  //     Uint8List discTxt =
  //         await CharsetConverter.encode("CP866", "Обслуживание :");
  //     double percent = total / 100 * int.parse(globals.settings!.percent);
  //     printer.row([
  //       PosColumn(
  //           textEncoded: discTxt,
  //           width: 6,
  //           styles: PosStyles(
  //               height: PosTextSize.size1,
  //               width: PosTextSize.size1,
  //               codeTable: "CP866")),
  //       PosColumn(
  //           text: percent.toString(),
  //           width: 6,
  //           styles: PosStyles(
  //             align: PosAlign.right,
  //             height: PosTextSize.size1,
  //             width: PosTextSize.size1,
  //           )),
  //     ]);
  //     printer.hr();
  //     Uint8List allTxt =
  //         await CharsetConverter.encode("CP866", "Итог : ${total + percent}");

  //     printer.textEncoded(
  //       allTxt,
  //       styles: PosStyles(
  //         align: PosAlign.center,
  //         codeTable: "CP866",
  //         height: PosTextSize.size2,
  //         width: PosTextSize.size2,
  //       ),
  //       linesAfter: 1,
  //     );

  //     // printer.hr();

  //     // printer.row([
  //     //   PosColumn(
  //     //       text: 'Cash',
  //     //       width: 8,
  //     //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //     //   PosColumn(
  //     //       text: '\$15.00',
  //     //       width: 4,
  //     //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //     // ]);
  //     // printer.row([
  //     //   PosColumn(
  //     //       text: 'sdasd',
  //     //       width: 8,
  //     //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //     //   PosColumn(
  //     //       text: '\$4.03',
  //     //       width: 4,
  //     //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //     // ]);

  //     // printer.feed(2);
  //     // printer.text('Thank you!',
  //     //     styles: PosStyles(align: PosAlign.center, bold: true));

  //     // final now = DateTime.now();
  //     // final formatter = DateFormat('MM/dd/yyyy H:m');
  //     // final String timestamp = formatter.format(now);
  //     // printer.text(timestamp,
  //     //     styles: PosStyles(align: PosAlign.center), linesAfter: 2);

  //     // Print QR Code from image
  //     // try {
  //     //   const String qrData = 'example.com';
  //     //   const double qrSize = 200;
  //     //   final uiImg = await QrPainter(
  //     //     data: qrData,
  //     //     version: QrVersions.auto,
  //     //     gapless: false,
  //     //   ).toImageData(qrSize);
  //     //   final dir = await getTemporaryDirectory();
  //     //   final pathName = '${dir.path}/qr_tmp.png';
  //     //   final qrFile = File(pathName);
  //     //   final imgFile = await qrFile.writeAsBytes(uiImg.buffer.asUint8List());
  //     //   final img = decodeImage(imgFile.readAsBytesSync());

  //     //   printer.image(img);
  //     // } catch (e) {
  //     //   print(e);
  //     // }

  //     // Print QR Code using native function
  //     // printer.qrcode('example.com');

  //     printer.feed(1);
  //     printer.cut();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> printCheck(
      NetworkPrinter printer, Department data, PrintData printData) async {
    try {
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm80, profile);
      List<int> bytes = [];
      // Uint8List depName = await CharsetConverter.encode("CP866", data.name);
      bytes += generator.text(Translit().toTranslit(
          source: data
              .name)); //textEncoded(depName, styles: PosStyles(codeTable: "CP866"));
      bytes += generator.hr();
      for (var i = 0; i < data.orders!.length; i++) {
        Order val = data.orders![i];
        List<PosColumn> pr = [
          PosColumn(
              text: Translit().toTranslit(source: val.product!.name),
              //await CharsetConverter.encode("CP866", val.product!.name),
              width: 10,
              styles: PosStyles(codeTable: "CP866")),
          PosColumn(text: val.amount.toString(), width: 2),
        ];
        bytes += generator.row(pr);
        if (val.comment != null && val.comment != "") {
          bytes += generator.row([
            PosColumn(
                text: Translit().toTranslit(source: val.comment!),
                //await CharsetConverter.encode("CP866", val.product!.name),
                width: 12,
                styles: PosStyles(codeTable: "CP866"))
          ]);
        }
      }

      bytes += generator.hr();

      var newFormat = DateFormat("yy-MM-dd HH:mm");

      bytes += generator.text(newFormat.format(DateTime.now()),
          styles: PosStyles(align: PosAlign.center), linesAfter: 1);

      // Uint8List tableTxt = await CharsetConverter.encode(
      //     "CP866", "Стол №: ${globals.orderState!.table}");
      // Uint8List waiter = await CharsetConverter.encode(
      //     "CP866", "Официант: ${globals.orderState!.employee}");
      bytes += generator.row([
        PosColumn(
            text: Translit()
                .toTranslit(source: "Официант: ${printData.employee}"),
            width: 6,
            styles: PosStyles(align: PosAlign.left, codeTable: "CP866")),
        PosColumn(
            text: Translit().toTranslit(source: "Стол: ${printData.table}"),
            width: 6,
            styles: PosStyles(align: PosAlign.right, codeTable: "CP866")),
      ]);

      generator.cut();
      printer.rawBytes(bytes);
      printer.cut();
    } catch (e) {
      print(e);
    }
  }

  test(printer) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];

    // bytes += generator.text(
    //     'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    // bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
    //     styles: PosStyles(codeTable: 'CP1252'));
    bytes += generator.text("", styles: PosStyles(codeTable: 'CP1251'));

    // bytes += generator.text('Special 2: blåbærgrød',
    //     styles: PosStyles(codeTable: 'CP1252'));

    // bytes += generator.text('Bold text', styles: PosStyles(bold: true));
    // bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
    // bytes += generator.text('Underlined text',
    //     styles: PosStyles(underline: true), linesAfter: 1);
    // bytes +=
    //     generator.text('Align left', styles: PosStyles(align: PosAlign.left));
    // bytes += generator.text('Align center',
    //     styles: PosStyles(align: PosAlign.center));
    // bytes += generator.text('Align right',
    //     styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    // bytes += generator.row([
    //   PosColumn(
    //     text: 'col3',
    //     width: 3,
    //     styles: PosStyles(align: PosAlign.center, underline: true),
    //   ),
    //   PosColumn(
    //     text: 'col6',
    //     width: 6,
    //     styles: PosStyles(align: PosAlign.center, underline: true),
    //   ),
    //   PosColumn(
    //     text: 'col3',
    //     width: 3,
    //     styles: PosStyles(align: PosAlign.center, underline: true),
    //   ),
    // ]);

    // bytes += generator.text('Text size 200%',
    //     styles: PosStyles(
    //       height: PosTextSize.size2,
    //       width: PosTextSize.size2,
    //     ));

    // Print image:
    // final ByteData data =
    //     await rootBundle.load('assets/img/logo-transparent.png');
    // final Uint8List imgBytes = data.buffer.asUint8List();
    // final Image image = decodeImage(imgBytes)!;
    // bytes += generator.image(image);
    // Print image using an alternative (obsolette) command
    // bytes += generator.imageRaster(image);

    // Print barcode
    // final List<dynamic> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    // bytes += generator.barcode(Barcode.code128(barData));
    // bytes += generator.qrcode("asdasdasdasd");

    // Print mixed (chinese + latin) text. Only for printers supporting Kanji mode
    // ticket.text(
    //   'hello ! 中文字 # world @ éphémère &',
    //   styles: PosStyles(codeTable: PosCodeTable.westEur),
    //   containsChinese: true,
    // );

    bytes += generator.feed(2);
    bytes += generator.cut();
    printer.rawBytes(bytes);
  }
  // void testPrint(
  //     String printerIp, BuildContext ctx, String type, Map data) async {
  //   const PaperSize paper = PaperSize.mm80;
  //   final profile = await CapabilityProfile.load(name: "default");
  //   final printer = NetworkPrinter(paper, profile);
  //   try {
  //     // if (type == "reciept") {
  //     final PosPrintResult res = await printer.connect(printerIp, port: 9100);

  //     if (res == PosPrintResult.success) {
  //       await printReceipt(printer, data);

  //       printer.disconnect();
  //     }
  //     // } else if (type == "check") {
  //     //   globals.userData!.department.forEach((val) async {
  //     //     printedCheck(printer, val, data);
  //     //   });
  //     // }
  //   } catch (e) {
  //     print(e);
  //     printer.disconnect();
  //   }
  // }

  printedCheck({ctx, required PrintData? data}) async {
    if (data != null) {
      const PaperSize paper = PaperSize.mm80;
      final profile = await CapabilityProfile.load(name: "default");
      final printer = NetworkPrinter(paper, profile);
      List<Department>? list = globals.orderState!.departments;

      if (list != null) {
        list.forEach((e) async {
          final PosPrintResult res =
              await printer.connect(e.printer!, port: 9100);

          if (res == PosPrintResult.success) {
            await printCheck(printer, e, data);
            printer.disconnect();
          } else {
            printer.disconnect();
            helper.getToast(res.msg, ctx);
          }
        });
      }
    } else {
      helper.getToast("нет данных для печати", ctx);
    }
  }
}
