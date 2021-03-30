import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:image/image.dart';

class Print {
  Future<void> printReceipt(NetworkPrinter printer) async {
    try {
      // Print image
      // final ByteData data = await rootBundle.load('assets/rabbit_black.jpg');
      // final Uint8List bytes = data.buffer.asUint8List();
      // final Image image = decodeImage(bytes);
      // printer.image(image);

      Uint8List encTxt4 =
          await CharsetConverter.encode("CP866", "Russian: Привет мир!");
      printer.textEncoded(encTxt4, styles: PosStyles(codeTable: "CP866"));
      printer.text('New Braunfels, TX',
          styles: PosStyles(align: PosAlign.center));
      printer.text('Tel: 830-221-1234',
          styles: PosStyles(align: PosAlign.center));
      printer.text('Web: www.example.com',
          styles: PosStyles(align: PosAlign.center), linesAfter: 1);

      printer.hr();
      printer.row([
        PosColumn(text: 'Qty', width: 1),
        PosColumn(text: 'Item', width: 7),
        PosColumn(
            text: 'Price', width: 2, styles: PosStyles(align: PosAlign.right)),
        PosColumn(
            text: 'Total', width: 2, styles: PosStyles(align: PosAlign.right)),
      ]);

      printer.row([
        PosColumn(text: '2', width: 1),
        PosColumn(text: 'ONION RINGS', width: 7),
        PosColumn(
            text: '0.99', width: 2, styles: PosStyles(align: PosAlign.right)),
        PosColumn(
            text: '1.98', width: 2, styles: PosStyles(align: PosAlign.right)),
      ]);
      printer.row([
        PosColumn(text: '1', width: 1),
        PosColumn(text: 'PIZZA', width: 7),
        PosColumn(
            text: '3.45', width: 2, styles: PosStyles(align: PosAlign.right)),
        PosColumn(
            text: '3.45', width: 2, styles: PosStyles(align: PosAlign.right)),
      ]);
      printer.row([
        PosColumn(text: '1', width: 1),
        PosColumn(text: 'SPRING ROLLS', width: 7),
        PosColumn(
            text: '2.99', width: 2, styles: PosStyles(align: PosAlign.right)),
        PosColumn(
            text: '2.99', width: 2, styles: PosStyles(align: PosAlign.right)),
      ]);
      printer.row([
        PosColumn(text: '3', width: 1),
        PosColumn(text: 'CRUNCHY STICKS', width: 7),
        PosColumn(
            text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
        PosColumn(
            text: '2.55', width: 2, styles: PosStyles(align: PosAlign.right)),
      ]);
      printer.hr();

      printer.row([
        PosColumn(
            text: 'TOTAL',
            width: 6,
            styles: PosStyles(
              height: PosTextSize.size2,
              width: PosTextSize.size2,
            )),
        PosColumn(
            text: '\$10.97',
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              height: PosTextSize.size2,
              width: PosTextSize.size2,
            )),
      ]);

      printer.hr(ch: '=', linesAfter: 1);

      printer.row([
        PosColumn(
            text: 'Cash',
            width: 8,
            styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
        PosColumn(
            text: '\$15.00',
            width: 4,
            styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      ]);
      printer.row([
        PosColumn(
            text: 'sdasd',
            width: 8,
            styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
        PosColumn(
            text: '\$4.03',
            width: 4,
            styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      ]);

      printer.feed(2);
      printer.text('Thank you!',
          styles: PosStyles(align: PosAlign.center, bold: true));

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

  void testPrint(String printerIp, BuildContext ctx) async {
    // TODO Don't forget to choose printer's paper size
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load(name: "default");
    final printer = NetworkPrinter(paper, profile);
    try {
      final PosPrintResult res = await printer.connect(printerIp, port: 9100);

      if (res == PosPrintResult.success) {
        // DEMO RECEIPT
        // await printDemoReceipt(printer);
        // TEST PRINT
        await printReceipt(printer);
        printer.disconnect();
      }
    } catch (e) {
      print(e);
      printer.disconnect();
    }
  }
}
