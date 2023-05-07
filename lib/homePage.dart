import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_generator_and_viewer_in_flutter/pdfscreen.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? pdfPath;

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    final Uint8List logoBytes =
        (await rootBundle.load('assets/images/Logo.png')).buffer.asUint8List();

    final image = pw.MemoryImage(logoBytes);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Image(image, height: 100, width: 100),
                pw.Text(
                  'Generated PDF',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Name: Faiq Ahmad',
                  style: const pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  'Email: ahmadfaiq46@gmail.com',
                  style: const pw.TextStyle(fontSize: 18),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Hi! this is my first pdf',
                  style: const pw.TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/example.pdf');
    await file.writeAsBytes(await pdf.save());

    setState(() {
      pdfPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          InkWell(
            onTap: () {
              generatePdf();
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.blue),
              child: const Center(child: Text('Generate PDF!')),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PdfScreen(path: pdfPath!)));
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.blue),
              child: const Center(child: Text('View PDF!')),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              final pdf = pdfPath;

              await Share.shareXFiles([XFile(pdf!)],
                  text: 'Check out my PDF File');
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.blue),
              child: const Center(child: Text('Send PDF on whatsapp')),
            ),
          ),
        ],
      )),
    );
  }
}
