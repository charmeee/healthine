import 'package:healthin/dictionary.dart';
import 'package:healthin/whileExercise.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double buttonheight = 60;
const double buttonwidth = 150;

class QrScanPage extends StatefulWidget {
  QrScanPage({Key? key, this.didexercise, required this.addDidexercise})
      : super(key: key);
  final didexercise;
  final Function(String) addDidexercise;
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QrScanPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool flag = true;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    //print(ModalRoute.of(context)?.isCurrent);
    if (result != null && flag) {
      //Map<String, dynamic> resultjson = jsonDecode(result!.code.toString());
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.addDidexercise(result!.code.toString()); //빌더서 setstate를사용하기위한방법;
        flag = false;
      });

      flag = false;

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  WhileExercise(exerciseName: result!.code.toString())));
      //Navigator.of(context).pop();
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text(
                      'QR코드를 스캔해주세요.',
                      style: TextStyle(fontSize: 10),
                    ),
                  Center(
                      child: Container(
                    padding: EdgeInsets.all(5),
                    height: buttonheight,
                    width: buttonwidth,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black54)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "홈으로 가기",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        )),
                  )),
                  Center(
                      child: Container(
                    padding: EdgeInsets.all(5),
                    height: buttonheight,
                    width: buttonwidth,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black54)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dictionary()));
                        },
                        child: Text(
                          "직접 추가하기",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        )),
                  )),
                  // Center(
                  //     child: TextButton(
                  //         onPressed: () {
                  //           controller?.dispose();
                  //           Navigator.pushReplacement(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => WhileExercise()));
                  //           //Navigator.of(context).pop();
                  //         },
                  //         child: Text("운동중"))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    //log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
