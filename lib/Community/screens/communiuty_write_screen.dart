import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Community/models/community_model.dart';
import 'package:healthin/Community/providers/community_provider.dart';
import 'package:healthin/Community/services/community_api.dart';

//import 'package:healthin/Model/routine_models.dart';

class CommunityWrite extends ConsumerStatefulWidget {
  final List<CommunityBoardsType> boardType;
  const CommunityWrite({Key? key, required this.boardType}) : super(key: key);

  @override
  CommunityWriteState createState() => CommunityWriteState();
}

class CommunityWriteState extends ConsumerState<CommunityWrite> {
  final formKey = GlobalKey<FormState>();
  String title = "";
  String content = "";
  late String thisBoardId;
  @override
  void initState() {
    super.initState();
    // "ref"는 StatefulWidget의 모든 생명주기 상에서 사용할 수 있습니다.
    thisBoardId = widget.boardType[0].id;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // "ref"는 build 메소드 안에서 프로바이더를 구독(listen)하기위해 사용할 수 있습니다.
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (await postCommunityBoardData(
                        thisBoardId, title, content)) {
                      await ref
                          .read(communityProvider.notifier)
                          .reloadBoard(thisBoardId); //새로고침
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: Text(
                  '저장',
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
                  DropdownButton(
                    value: thisBoardId,
                    items: widget.boardType.map((e) {
                      return DropdownMenuItem(
                        child: Text(e.title.toString()),
                        value: e.id,
                      );
                    }).toList(),
                    onChanged: (Object? value) {
                      setState(() {
                        thisBoardId = value.toString();
                      });
                    },
                  ),
                  TextFormField(
                    onSaved: (value) {
                      title = value.toString();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '제목을 입력해주세요';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusColor: Colors.grey,
                      hintText: '제목을 입력해주세요',
                    ),
                  ),
                  Divider(
                    height: 10,
                    color: Colors.indigo,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      content = value.toString();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '내용을 입력해주세요';
                      }
                      return null;
                    },
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusColor: Colors.grey,
                        hintText: '내용을 입력해주세요'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
