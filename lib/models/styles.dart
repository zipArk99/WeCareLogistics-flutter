import 'package:flutter/cupertino.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PdfViewer extends StatelessWidget {
  final String path;
  PdfViewer({required this.path});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      path: path,
    );
  }
}
