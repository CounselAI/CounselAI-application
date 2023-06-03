import 'package:counselaicompanion/frontend/screens/counsel_cases.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFWrapper extends StatelessWidget {
  const PDFWrapper({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Viewer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const PDFViewer(title: 'User Generated Report'),
    );
  }
}

class PDFViewer extends StatefulWidget {
  const PDFViewer({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PDFViewerState createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerStateKey = GlobalKey();
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SfPdfViewer.network('https://files.catbox.moe/v6dj0v.pdf',
          controller: _pdfViewerController, key: _pdfViewerStateKey),
      appBar: AppBar(
        leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                )),
        actions: <Widget>[
          IconButton(
              iconSize: 40,
              onPressed: () {
                _pdfViewerStateKey.currentState!.openBookmarkView();
              },
              icon: const Icon(
                Icons.bookmark,
                color: Colors.white,
              )),
          IconButton(
              iconSize: 40,
              onPressed: () {
                _pdfViewerController.jumpToPage(5);
              },
              icon: const Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              )),
          IconButton(
              iconSize: 40,
              onPressed: () {
                _pdfViewerController.zoomLevel += 1.25;
              },
              icon: const Icon(
                Icons.zoom_in,
                color: Colors.white,
              )),
          IconButton(
              iconSize: 40,
              onPressed: () {
                _pdfViewerController.zoomLevel -= 1.25;
              },
              icon: const Icon(
                Icons.zoom_out,
                color: Colors.white,
              ))
        ],
      ),
    ));
  }
}
