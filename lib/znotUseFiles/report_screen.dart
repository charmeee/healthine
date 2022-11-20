import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReportScreen extends StatefulWidget {
  final String id;
  const ReportScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl:
            'https://report.be-healthy.life/reports/fe779182-10de-4765-bf3b-9daa7e37bdc8',
        //initialUrl: 'https://report.be-healthy.life/reports/${widget.id}',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
