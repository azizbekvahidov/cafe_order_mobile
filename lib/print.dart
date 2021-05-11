import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:image/image.dart';
import './globals.dart' as globals;

class Print {
  Future<void> printReceipt(NetworkPrinter printer, Map data) async {
    try {
      // Print image
      // final ByteData data = await rootBundle.load('assets/rabbit_black.jpg');
      // final Uint8List bytes = data.buffer.asUint8List();
      // final Image image = decodeImage(bytes);
      // printer.image(image);

      // Uint8List encTxt4 =
      //     await CharsetConverter.encode("CP866", "Russian: Привет мир!");
      // printer.textEncoded(encTxt4, styles: PosStyles(codeTable: "CP866"));

      Uint8List kafeTxt =
          await CharsetConverter.encode("CP866", globals.userData["kafename"]);
      printer.textEncoded(kafeTxt,
          styles: PosStyles(
            align: PosAlign.center,
            codeTable: "CP866",
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          ),
          linesAfter: 1);

      var newFormat = DateFormat("yy-MM-dd HH:mm");

      printer.text(newFormat.format(DateTime.now()),
          styles: PosStyles(align: PosAlign.center), linesAfter: 1);
      Uint8List openTxt = await CharsetConverter.encode(
          "CP866", "Открыт: ${data['expense']["order_date"]}");
      Uint8List check = await CharsetConverter.encode(
          "CP866", "Счет: ${data['expense']["expense_id"]}");
      Uint8List tableTxt = await CharsetConverter.encode(
          "CP866", "Стол №: ${data['expense']["table_name"]}");
      Uint8List waiter = await CharsetConverter.encode(
          "CP866", "Официант: ${data['expense']["employee_name"]}");
      printer.row([
        PosColumn(
            textEncoded: openTxt,
            width: 6,
            styles: PosStyles(align: PosAlign.left, codeTable: "CP866")),
        PosColumn(
            textEncoded: check,
            width: 6,
            styles: PosStyles(align: PosAlign.right, codeTable: "CP866")),
      ]);
      printer.row([
        PosColumn(
            textEncoded: waiter,
            width: 6,
            styles: PosStyles(align: PosAlign.left, codeTable: "CP866")),
        PosColumn(
            textEncoded: tableTxt,
            width: 6,
            styles: PosStyles(align: PosAlign.right, codeTable: "CP866")),
      ]);
      // printer.text('Web: www.example.com',
      //     styles: PosStyles(align: PosAlign.center), linesAfter: 1);

      printer.hr();
      Uint8List nameTxt =
          await CharsetConverter.encode("CP866", "Наименование");
      Uint8List cntTxt = await CharsetConverter.encode("CP866", "Кол");
      Uint8List priceTxt = await CharsetConverter.encode("CP866", "Цена");
      Uint8List totalTxt = await CharsetConverter.encode("CP866", "Всего");
      printer.row([
        PosColumn(
            textEncoded: nameTxt,
            width: 7,
            styles: PosStyles(codeTable: "CP866")),
        PosColumn(
            textEncoded: cntTxt,
            width: 1,
            styles: PosStyles(codeTable: "CP866")),
        PosColumn(
            textEncoded: priceTxt,
            width: 2,
            styles: PosStyles(align: PosAlign.right, codeTable: "CP866")),
        PosColumn(
            textEncoded: totalTxt,
            width: 2,
            styles: PosStyles(align: PosAlign.right, codeTable: "CP866")),
      ]);
      double total = 0;
      printer.hr();
      List orders;
      int i = 0;
      for (var i = 0; i < data["order"].length; i++) {
        var val = data["order"][i];
        List<PosColumn> pr = [
          PosColumn(
              textEncoded: await CharsetConverter.encode("CP866", val["name"]),
              width: 7,
              styles: PosStyles(codeTable: "CP866")),
          PosColumn(text: val["cnt"].toString(), width: 1),
          PosColumn(
              text: val["price"].toString(),
              width: 2,
              styles: PosStyles(align: PosAlign.right)),
          PosColumn(
              text: (val["cnt"] * val["price"]).toString(),
              width: 2,
              styles: PosStyles(align: PosAlign.right)),
        ];
        printer.row(pr);
        total += val["cnt"] * val["price"];
      }
      printer.hr();
      Uint8List summTxt = await CharsetConverter.encode("CP866", "Сумма :");
      printer.row([
        PosColumn(
            textEncoded: summTxt,
            width: 6,
            styles: PosStyles(
                height: PosTextSize.size1,
                width: PosTextSize.size1,
                codeTable: "CP866")),
        PosColumn(
            text: total.toString(),
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              height: PosTextSize.size1,
              width: PosTextSize.size1,
            )),
      ]);

      Uint8List discTxt =
          await CharsetConverter.encode("CP866", "Обслуживание :");
      double percent = total / 100 * globals.userData["percent"];
      printer.row([
        PosColumn(
            textEncoded: discTxt,
            width: 6,
            styles: PosStyles(
                height: PosTextSize.size1,
                width: PosTextSize.size1,
                codeTable: "CP866")),
        PosColumn(
            text: percent.toString(),
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              height: PosTextSize.size1,
              width: PosTextSize.size1,
            )),
      ]);
      printer.hr();
      Uint8List allTxt =
          await CharsetConverter.encode("CP866", "Итог : ${total + percent}");

      printer.textEncoded(
        allTxt,
        styles: PosStyles(
          align: PosAlign.center,
          codeTable: "CP866",
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1,
      );

      // printer.hr();

      // printer.row([
      //   PosColumn(
      //       text: 'Cash',
      //       width: 8,
      //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      //   PosColumn(
      //       text: '\$15.00',
      //       width: 4,
      //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      // ]);
      // printer.row([
      //   PosColumn(
      //       text: 'sdasd',
      //       width: 8,
      //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      //   PosColumn(
      //       text: '\$4.03',
      //       width: 4,
      //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      // ]);

      // printer.feed(2);
      // printer.text('Thank you!',
      //     styles: PosStyles(align: PosAlign.center, bold: true));

      // final now = DateTime.now();
      // final formatter = DateFormat('MM/dd/yyyy H:m');
      // final String timestamp = formatter.format(now);
      // printer.text(timestamp,
      //     styles: PosStyles(align: PosAlign.center), linesAfter: 2);

      // Print QR Code from image
      // try {
      //   const String qrData = 'example.com';
      //   const double qrSize = 200;
      //   final uiImg = await QrPainter(
      //     data: qrData,
      //     version: QrVersions.auto,
      //     gapless: false,
      //   ).toImageData(qrSize);
      //   final dir = await getTemporaryDirectory();
      //   final pathName = '${dir.path}/qr_tmp.png';
      //   final qrFile = File(pathName);
      //   final imgFile = await qrFile.writeAsBytes(uiImg.buffer.asUint8List());
      //   final img = decodeImage(imgFile.readAsBytesSync());

      //   printer.image(img);
      // } catch (e) {
      //   print(e);
      // }

      // Print QR Code using native function
      // printer.qrcode('example.com');

      printer.feed(1);
      printer.cut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> printCheck(NetworkPrinter printer, Map data) async {
    try {
      Uint8List depName =
          await CharsetConverter.encode("CP866", data["department"]);
      printer.textEncoded(depName, styles: PosStyles(codeTable: "CP866"));
      printer.hr();
      for (var i = 0; i < data["order"].length; i++) {
        var val = data["order"][i];
        List<PosColumn> pr = [
          PosColumn(
              textEncoded: await CharsetConverter.encode("CP866", val["name"]),
              width: 11,
              styles: PosStyles(codeTable: "CP866")),
          PosColumn(text: val["cnt"].toString(), width: 1),
        ];
        printer.row(pr);
      }
      printer.hr();

      var newFormat = DateFormat("yy-MM-dd HH:mm");

      printer.text(newFormat.format(DateTime.now()),
          styles: PosStyles(align: PosAlign.center), linesAfter: 1);

      Uint8List tableTxt = await CharsetConverter.encode(
          "CP866", "Стол №: ${data['expense']["table_name"]}");
      Uint8List waiter = await CharsetConverter.encode(
          "CP866", "Официант: ${data['expense']["employee_name"]}");
      printer.row([
        PosColumn(
            textEncoded: waiter,
            width: 6,
            styles: PosStyles(align: PosAlign.left, codeTable: "CP866")),
        PosColumn(
            textEncoded: tableTxt,
            width: 6,
            styles: PosStyles(align: PosAlign.right, codeTable: "CP866")),
      ]);

      printer.cut();
    } catch (e) {
      print(e);
    }
  }

  void testPrint(
      String printerIp, BuildContext ctx, String type, Map data) async {
    // TODO Don't forget to choose printer's paper size
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load(name: "default");
    final printer = NetworkPrinter(paper, profile);
    try {
      if (type == "reciept") {
        final PosPrintResult res = await printer.connect(printerIp, port: 9100);

        if (res == PosPrintResult.success) {
          await printReceipt(printer, data);

          printer.disconnect();
        }
      } else if (type == "check") {
        globals.userData["department"].forEach((val) async {
          printedCheck(printer, val, data);
        });
      }
    } catch (e) {
      print(e);
      printer.disconnect();
    }
  }

  void printedCheck(printer, dep, data) async {
    List list = data["order"]
        .where((temp) => temp["department_id"] == dep["department_id"])
        .toList();
    if (!list.isEmpty) {
      final PosPrintResult res =
          await printer.connect(dep["printer"], port: 9100);

      if (res == PosPrintResult.success) {
        await printCheck(printer, {
          "expense": data["expense"],
          "order": list,
          "department": dep["name"]
        });

        printer.disconnect();
      }
    }
  }
}
