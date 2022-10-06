import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/community_model.dart';
import 'package:healthin/Model/routine_models.dart';
import 'package:healthin/Model/user_model.dart';
import 'package:healthin/Provider/user_provider.dart';
import 'package:healthin/Service/community_api.dart';

import '../../Provider/community_provider.dart';
import 'community_detail_body_widget.dart';

class CommunityDetail extends ConsumerStatefulWidget {
  final String boardId;
  final String postId;
  const CommunityDetail({Key? key, required this.postId, required this.boardId})
      : super(key: key);

  @override
  ConsumerState<CommunityDetail> createState() => _CommunityDetailState();
}

class _CommunityDetailState extends ConsumerState<CommunityDetail> {
  late UserInfo user;
  CommunityBoard? board;
  List<CommunityBoardComment> comments = [];
  final _Controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = ref.read(userProfileNotifierProvider);
    getBoard();
    getComment();
  }

  @override
  dispose() {
    _Controller.dispose();
    super.dispose();
  }

  getBoard() async {
    CommunityBoard tmp =
        await getCommunityBoardData(widget.boardId, widget.postId);
    setState(() {
      board = tmp;
    });
  }

  getComment() async {
    List<CommunityBoardComment> tmp =
        await getCommunityBoardComment(widget.boardId, widget.postId);
    setState(() {
      comments = tmp;
    });
  }

  // addComment() async {
  //   await addCommunityBoardComment(widget.boardId, widget.postId, _Controller.text);
  //   getComment();
  // }

  @override
  Widget build(BuildContext context) {
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
                    child: board == null
                        ? Center(child: CircularProgressIndicator())
                        : CommunityDetailBody(
                            board: board!,
                            comments: comments,
                            user: user,
                          )),
                Container(
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: _Controller,
                          decoration: InputDecoration(labelText: "댓글을 입력해주세요"),
                        )),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () async {
                            if (user.nickname == null) {
                              log("로그인이 필요합니다");
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: Text("로그인이 필요한 서비스입니다"),
                                        content: Text("로그인을 해주세요"),
                                        actions: [
                                          ElevatedButton(
                                            child: Text("확인"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ));
                            } else {
                              try {
                                await postCommunityBoardComment(widget.boardId,
                                    widget.postId, _Controller.text);
                                await getComment();
                              } catch (e) {
                                log(e.toString());
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: Text("댓글 작성에 실패했습니다"),
                                          content: Text("잠시 후 다시 시도해주세요"),
                                          actions: [
                                            ElevatedButton(
                                              child: Text("확인"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        ));
                              }

                              setState(() {
                                _Controller.text = "";
                                //_Controller.text
                              });
                            }
                            // ref
                            //     .read(CommunityDataNotifierProvider.notifier)
                            //     .addComment(widget.id, user.nickname.toString(),
                            //         _Controller.text);
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        )
                      ],
                    )),
              ],
            ),
          )),
    );
  }
}

// class Communitydetail extends ConsumerStatefulWidget {
//   const Communitydetail({Key? key, required this.id}) : super(key: key);
//   final String id;
//   @override
//   ConsumerState<Communitydetail> createState() => _CommunitydetailState();
// }
//
// class _CommunitydetailState extends ConsumerState<Communitydetail> {
//   Map<String, dynamic> communityData = {};
//   final _Controller = TextEditingController();
//   late UserInfo user;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     ref.read(CommunityDataNotifierProvider.notifier).getComunnity(widget.id);
//     user = ref.read(userProfileNotifierProvider);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.indigo,
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ),
//           body: Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.all(8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Expanded(child: _CommunityBody()),
//                 Container(
//                     margin: EdgeInsets.only(top: 8),
//                     padding: EdgeInsets.all(8),
//                     child: Row(
//                       children: [
//                         Expanded(
//                             child: TextField(
//                           controller: _Controller,
//                           decoration: InputDecoration(labelText: "댓글을 입력해주세요"),
//                         )),
//                         IconButton(
//                           icon: Icon(Icons.send),
//                           onPressed: () {
//                             if (user.nickname == null) {
//                               log("로그인이 필요합니다");
//                               showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) =>
//                                       AlertDialog(
//                                         title: Text("로그인이 필요한 서비스입니다"),
//                                         content: Text("로그인을 해주세요"),
//                                         actions: [
//                                           ElevatedButton(
//                                             child: Text("확인"),
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                           )
//                                         ],
//                                       ));
//                             }
//                             ref
//                                 .read(CommunityDataNotifierProvider.notifier)
//                                 .addComment(widget.id, user.nickname.toString(),
//                                     _Controller.text);
//                             setState(() {
//                               _Controller.text = "";
//                             });
//                             FocusManager.instance.primaryFocus?.unfocus();
//                           },
//                         )
//                       ],
//                     )),
//               ],
//             ),
//           )),
//     );
//   }
// }
//
// class _CommunityBody extends ConsumerWidget {
//   const _CommunityBody({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     CommunityBoardList? boardData = ref.watch(CommunityDataNotifierProvider);
//     if (boardData != null) {
//       // int length =
//       //     (boardData.comment != null) ? boardData.comment!.length + 2 : 2;
//       //log(length.toString());
//       return ListView.separated(
//         itemCount: boardData.comment.length + 2,
//         itemBuilder: (context, index) {
//           if (index == 0) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: Text(boardData.title,
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
//             );
//           } else if (index == 1) {
//             return Container(
//               constraints: BoxConstraints(minHeight: 250),
//               padding: EdgeInsets.symmetric(vertical: 10),
//               child: Text(
//                 boardData.content,
//                 style: TextStyle(fontSize: 18),
//               ),
//             );
//           } else {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 boardData.comment[index - 2]["nickname"] +
//                     ' : ' +
//                     boardData.comment[index - 2]["text"],
//                 style: TextStyle(fontSize: 15),
//               ),
//             );
//           }
//         },
//         separatorBuilder: (BuildContext context, int index) => _divider,
//       );
//     } else {
//       return Center(
//         child: Text("로딩중"),
//       );
//     }
//   }
// }
