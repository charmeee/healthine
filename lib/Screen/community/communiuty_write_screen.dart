import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'package:healthin/Model/routine_models.dart';

class CommunityWrite extends ConsumerStatefulWidget {
  const CommunityWrite({Key? key}) : super(key: key);

  @override
  CommunityWriteState createState() => CommunityWriteState();
}

class CommunityWriteState extends ConsumerState<CommunityWrite> {
  @override
  void initState() {
    super.initState();
    // "ref"는 StatefulWidget의 모든 생명주기 상에서 사용할 수 있습니다.
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
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextField(
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
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusColor: Colors.grey,
                          hintText: '내용을 입력해주세요'),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('저장'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
