import 'package:flutter/material.dart' as material;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

import 'package:wecare_logistics/models/styles.dart';

class Label {
  final String mailType;
  final double weight;
  final String senderName;
  final String reciverName;
  final String pickUp;
  final String drop;
  final String orderId;
  /* final String trackingId; */

  Label({
    required this.mailType,
    required this.weight,
    required this.senderName,
    required this.reciverName,
    required this.pickUp,
    required this.drop,
    required this.orderId,
  });

  void generateLableClass(context) async {
    final pw.Document pdf = pw.Document();

    pdf.addPage(pw.Page(
      orientation: pw.PageOrientation.portrait,
      build: (context) {
        return addContainer(height: 800, width: 0, child: [
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(width: 2),
              ),
            ),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(width: 2),
                    ),
                  ),
                  padding: pw.EdgeInsets.symmetric(horizontal: 20),
                  child: pw.Text(
                    "P",
                    textScaleFactor: 7,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Container(
                  padding:
                      pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: pw.Text(
                    "Weigth: $weight",
                    textScaleFactor: 1.4,
                    style: pw.TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            alignment: pw.Alignment.center,
            width: double.infinity,
            padding: pw.EdgeInsets.symmetric(vertical: 20),
            decoration: pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(width: 2),
              ),
            ),
            child: pw.Text(
              "$mailType",
              textScaleFactor: 2.5,
              style: textStyle1(),
            ),
          ),
          pw.Container(
            width: 240,
            alignment: pw.Alignment.bottomLeft,
            padding: pw.EdgeInsets.only(top: 40, left: 10),
            child: pw.Text(
                "$senderName \n $pickUp",
                style: textStyle3()),
          ),
          pw.Container(
            width: 230,
            alignment: pw.Alignment.bottomLeft,
            padding: pw.EdgeInsets.only(top: 30, left: 10),
            child: pw.Column(
              children: [
                pw.Text(
                  "Ship To:  " + "                              ",
                  textScaleFactor: 1.7,
                ),
                pw.Text(
                  "$reciverName \n H/7 $drop",
                  style: textStyle2(),
                ),
              ],
            ),
          ),
          createQrCode(orderId),
          pw.Container(
            padding: pw.EdgeInsets.symmetric(vertical: 10),
            alignment: pw.Alignment.center,
            child: pw.Text(
              "Tracking #: DX-PV54",
              style: textStyle4(),
            ),
          ),
        ]);
      },
    ));

    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/label90.pdf';
    final File file = File(path);
    await file.writeAsBytes((await pdf.save()));
    material.Navigator.of(context).push(
        material.MaterialPageRoute(builder: (_) => PdfViewer(path: path)));
  }
}



pw.Widget addContainer(
    {required double height,
    required int width,
    required List<pw.Widget> child}) {
  return pw.Center(
    child: pw.Container(
      margin: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: height,
      width: double.infinity,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 4, color: PdfColors.black),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [...child],
      ),
    ),
  );
}

pw.TextStyle textStyle1() {
  return pw.TextStyle(
    color: PdfColors.black,
    fontWeight: pw.FontWeight.bold,
  );
}

pw.TextStyle textStyle4() {
  return pw.TextStyle(
    color: PdfColors.black,
    fontSize: 20,
    fontWeight: pw.FontWeight.bold,
  );
}

pw.TextStyle textStyle2() {
  return pw.TextStyle(
    fontStyle: pw.FontStyle.normal,
    fontSize: 20,
    fontWeight: pw.FontWeight.bold,
  );
}

pw.TextStyle textStyle3() {
  return pw.TextStyle(
    fontStyle: pw.FontStyle.normal,
    fontSize: 18,
    fontWeight: pw.FontWeight.bold,
  );
}

pw.Widget createQrCode(String orderId) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border(
        top: pw.BorderSide(width: 3),
        bottom: pw.BorderSide(width: 3),
      ),
    ),
    width: double.infinity,
    margin: pw.EdgeInsets.only(top: 30),
    padding: pw.EdgeInsets.symmetric(vertical: 15),
    child: pw.Column(
      children: [
        pw.BarcodeWidget(
            color: PdfColors.black,
            barcode: pw.Barcode.qrCode(),
            data:orderId,
            width: 150,
            height: 170)
      ],
    ),
  );
}
