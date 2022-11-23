import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:healthin/Community/models/community_model.dart';
import 'package:healthin/Community/services/community_api.dart';
import 'package:image_picker/image_picker.dart';

//import 'package:healthin/Model/routine_models.dart';

class CommunityWrite extends ConsumerStatefulWidget {
  final List<CommunityBoardsType>? boardType;
  final CommunityBoard? initBoard;
  final String? postId;
  final String? boardId;
  //boardType ||||| initBoard,postId,boardId
  const CommunityWrite(
      {Key? key, this.boardType, this.initBoard, this.postId, this.boardId})
      : super(key: key);

  @override
  CommunityWriteState createState() => CommunityWriteState();
}

class CommunityWriteState extends ConsumerState<CommunityWrite> {
  final formKey = GlobalKey<FormState>();
  String title = "";
  String content = "";
  late String thisBoardId;
  String? photoId;
  File? _image;
  final picker = ImagePicker();
  var imagePath = '';
  XFile? image;
  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    image = await picker.pickImage(
        source: imageSource, maxHeight: 500, maxWidth: 500, imageQuality: 50);
    if (image != null) {
      String data = await postCommunityImage(thisBoardId, image!);
      setState(() {
        //imagePath = image!.path;
        photoId = data;
        _image = File(image!.path); // 가져온 이미지를 _image에 저장
      });
    }
    //사진보내는 api.
  }

  @override
  void initState() {
    super.initState();
    // "ref"는 StatefulWidget의 모든 생명주기 상에서 사용할 수 있습니다.
    if (widget.boardType != null) {
      thisBoardId = widget.boardType![0].id;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("글 작성하기", style: h3Bold_18),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    List<String> images = [];
                    if (photoId != null) {
                      images.add(photoId!);
                    }
                    if (widget.initBoard == null) {
                      await postCommunityBoardData(
                          thisBoardId, title, content, images);
                    } else {
                      await patchCommunityBoardData(widget.boardId!,
                          widget.postId!, title, content, images);
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  '등록',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.boardType != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: DropdownButton(
                        value: thisBoardId,
                        dropdownColor: Colors.black45,
                        items: widget.boardType?.map((e) {
                          return DropdownMenuItem(
                            child: Text(
                              e.title.toString(),
                              style: bodyRegular_16,
                            ),
                            value: e.id,
                          );
                        }).toList(),
                        onChanged: (Object? value) {
                          setState(() {
                            thisBoardId = value.toString();
                          });
                        },
                      ),
                    ),
                  TextFormField(
                    style: bodyRegular_16,
                    onSaved: (value) {
                      title = value.toString();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '제목을 입력해주세요';
                      }
                      return null;
                    },
                    initialValue: widget.initBoard?.title,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusColor: Colors.grey,
                      hintText: '제목을 입력해주세요',
                      hintStyle:
                          bodyRegular_16.copyWith(color: mediumGrayColor),
                    ),
                  ),
                  Divider(
                    height: 10,
                    color: Colors.indigo,
                  ),
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: mediumGrayColor,
                          ),
                          onPressed: () {
                            getImage(ImageSource.camera);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.image,
                            color: mediumGrayColor,
                          ),
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 10,
                    color: Colors.indigo,
                  ),
                  TextFormField(
                    style: bodyRegular_16,
                    onSaved: (value) {
                      content = value.toString();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '내용을 입력해주세요';
                      }
                      return null;
                    },
                    initialValue: widget.initBoard?.content,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusColor: Colors.grey,
                      hintText: '내용을 입력해주세요',
                      hintStyle:
                          bodyRegular_16.copyWith(color: mediumGrayColor),
                    ),
                  ),
                  if (_image != null) Image.file(_image!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
