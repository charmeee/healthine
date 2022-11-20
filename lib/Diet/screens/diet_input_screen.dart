import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Diet/models/diet_model.dart';
import 'package:healthin/Diet/widgets/diet_type_chip.dart';
import 'package:image_picker/image_picker.dart';

import '../../Common/styles/textStyle.dart';
import '../services/diet_api.dart';
import '../widgets/diet_input_form.dart';
import '../widgets/diet_result_tile.dart';
import 'package:flutter/cupertino.dart';

class DietInputScreen extends StatefulWidget {
  const DietInputScreen({Key? key}) : super(key: key);

  @override
  _DietInputScreenState createState() => _DietInputScreenState();
}

class _DietInputScreenState extends State<DietInputScreen> {
  File? _image;
  final picker = ImagePicker();
  var imagePath = '';
  XFile? image;
  int nowHour = DateTime.now().hour;

  DietType nowDietType = DietType.breakfast;
  void initState() {
    // TODO: implement initState
    super.initState();
    if (nowHour >= 5 && nowHour < 11) {
      nowDietType = DietType.breakfast;
    } else if (nowHour >= 11 && nowHour < 14) {
      nowDietType = DietType.lunch;
    } else if (nowHour >= 17 && nowHour < 20) {
      nowDietType = DietType.dinner;
    } else {
      nowDietType = DietType.snack;
    }
  }

  setDietType(DietType dietType) {
    setState(() {
      nowDietType = dietType;
    });
  }

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    image = await picker.pickImage(
        source: imageSource, maxHeight: 500, maxWidth: 500, imageQuality: 50);
    setState(() {
      //imagePath = image!.path;
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
    //사진보내는 api.
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('식단 등록하기'),
          backgroundColor: backgroundColor,
          shadowColor: darkGrayColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                showImageWidget(),
                SizedBox(
                  height: 20.0,
                ),
                DietTypeChips(
                    setDietType: setDietType, nowDietType: nowDietType),
                SizedBox(
                  height: 16,
                ),
                showDataWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 이미지를 보여주는 위젯
  Widget showImageWidget() {
    return AspectRatio(
      aspectRatio: 1.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: image == null
            ? Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: darkGrayColor),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                        child: Container(
                          height: 36,
                          width: 36,
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset("assets/icons/add_small.svg"),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                          ),
                        ),
                        onTap: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) => CupertinoTheme(
                                    data: CupertinoThemeData(
                                        textTheme: CupertinoTextThemeData(
                                            primaryColor: secondaryColor)),
                                    child: CupertinoActionSheet(
                                      actions: [
                                        CupertinoActionSheetAction(
                                          child: Text(
                                            '카메라',
                                            style: h3Regular_18,
                                          ),
                                          onPressed: () {
                                            getImage(ImageSource.camera);
                                            Navigator.pop(context);
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Text(
                                            '갤러리',
                                            style: h3Regular_18,
                                          ),
                                          onPressed: () {
                                            getImage(ImageSource.gallery);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        child: Text(
                                          "취소",
                                          style: h3Regular_18,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ));
                        }),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "추가",
                        style: bodyRegular_14,
                      ),
                    )
                  ],
                ),
              )
            : Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomRight,
                children: [
                    Image.file(File(_image!.path), fit: BoxFit.cover),
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: InkWell(
                          child: Container(
                            height: 28,
                            width: 28,
                            padding: const EdgeInsets.all(4),
                            child: SvgPicture.asset("assets/icons/close.svg"),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: backgroundColor,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              image = null;
                            });
                          }),
                    )
                  ]),
      ),
    );
  }

  Widget showDataWidget() {
    if (image == null) {
      return Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Text("식단을 등록해주세요.", style: h3Regular_18),
      );
    } else {
      return DietResultWidget(image: image!);
    }
  }
}
