import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class TelaPoliticaPrivacidade extends StatelessWidget {

  final pdfController = PdfController(
    document: PdfDocument.openAsset('assets/politicadeprivacidade.pdf'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Política de privacidade'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: PdfView(
          controller: pdfController,
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}
