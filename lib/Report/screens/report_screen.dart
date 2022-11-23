import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
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

  static const platform = MethodChannel('life.healthy.be/android');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl:
            'https://report.be-healthy.life/reports/fe779182-10de-4765-bf3b-9daa7e37bdc8',
        //initialUrl: 'https://report.be-healthy.life/reports/${widget.id}',
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) async {
          if (request.url.startsWith('intent')) {
            print('blocking navigation to $request}');
            // if (Platform.isAndroid) {
            //   //await platform.invokeMethod('shareReport', {"url": request.url});
            //   if (await canLaunchUrl(Uri.parse(request.url))) {
            //     log("launching ${request.url}");
            //     await launchUrl(
            //       Uri.parse(request.url),
            //       mode: LaunchMode.externalApplication,
            //     );
            //   }
            // }
            return NavigationDecision.prevent;
          }
          print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
