import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfScreen extends StatefulWidget {
  final String path;

  const PdfScreen({required this.path});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PDFView(
          filePath: widget.path,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: false,
          onRender: (_pages) {
            print("rendered: $_pages");
          },
          onError: (error) {
            print(error.toString());
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },
          onViewCreated: (PDFViewController pdfViewController) {
            //TODO: can be used to control the PDFView using the PDFViewController
          },
        ),
      ),
    );
  }
}
