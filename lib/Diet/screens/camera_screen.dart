import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Diet/models/diet_model.dart';
import 'package:image_picker/image_picker.dart';

import '../services/diet_api.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;
  final picker = ImagePicker();
  List<DietResult>? result;
  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(
        source: imageSource, maxHeight: 500, maxWidth: 500, imageQuality: 50);

    setState(() {
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
            backgroundColor: primaryColor,
          ),
          backgroundColor: const Color(0xfff4f3f9),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: showImageWidget(),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // 카메라 촬영 버튼
                  ElevatedButton(
                    child: Icon(Icons.add_a_photo),
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                  ),

                  // 갤러리에서 이미지를 가져오는 버튼
                  ElevatedButton(
                    child: Icon(Icons.wallpaper),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              showDataWidget(),
            ],
          )),
    );
  }

  // 이미지를 보여주는 위젯
  Widget showImageWidget() {
    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Center(
            child: _image == null
                ? Text('이미지가 선택되지 않았습니다.')
                : Image.file(File(_image!.path))));
  }

  Widget showDataWidget() {
    if (_image == null) {
      return Text("식단을 등록해주세요.");
    } else {
      return DietResultWidget(image: _image!);
    }
  }
}

class DietResultWidget extends StatelessWidget {
  final File image;
  const DietResultWidget({Key? key, required this.image}) : super(key: key);

//result = await getDietData(_image!.path);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DietResult>>(
        future: getDietData(image.path), //<List<DietResult>>
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // final List<bool> _selected = List.generate(snapshot.data!.length,
            //     (i) => false); // Fill it with false initially
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  DietResult item = snapshot.data![index];
                  return ListTile(
                    tileColor: Colors.white,
                    onTap: () {},
                    title: Text(item.name.toString()),
                    trailing: Text(item.calories.toString()),
                    subtitle: Text(
                        '탄: ${item.carbohydrate} 단: ${item.protein} 지: ${item.fat}'),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
