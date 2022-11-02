import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Community/models/community_model.dart';
import 'package:healthin/Routine/models/routine_models.dart';
import 'package:healthin/User/models/user_model.dart';
import 'package:healthin/User/providers/user_provider.dart';
import 'package:healthin/Community/services/community_api.dart';

import '../providers/community_provider.dart';
import '../widgets/community_detail_body_widget.dart';

class CommunityDetail extends ConsumerStatefulWidget {
  final String boardId;
  final String postId;
  final String boardTitle;
  const CommunityDetail(
      {Key? key,
      required this.postId,
      required this.boardId,
      required this.boardTitle})
      : super(key: key);

  @override
  ConsumerState<CommunityDetail> createState() => _CommunityDetailState();
}

class _CommunityDetailState extends ConsumerState<CommunityDetail> {
  late UserInfo user;
  CommunityBoard? board;
  List<CommunityBoardComment> comments = [];
  String? replyId;
  final _controller = TextEditingController();
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
    _controller.dispose();
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

  addLike() async {
    log('addLike');
    bool data = await postLikes(widget.boardId, widget.postId);
    if (data) {
      setState(() {
        board!.likesCount++;
      });
    }
  }

  setReplyId(String? id) {
    setState(() {
      replyId = id;
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
            title: Text('${widget.boardTitle} 게시판'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              )
            ],
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: board == null
                        ? const Center(child: CircularProgressIndicator())
                        : CommunityDetailBody(
                            board: board!,
                            comments: comments,
                            user: user,
                            replyId: replyId,
                            addLike: addLike,
                            setReplyId: setReplyId)),
                if (replyId != null) Text("$replyId 에 댓글을 답니다."),
                Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: _controller,
                          decoration:
                              const InputDecoration(labelText: "댓글을 입력해주세요"),
                        )),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () async {
                            if (user.nickname == null) {
                              log("로그인이 필요합니다");
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text("로그인이 필요한 서비스입니다"),
                                        content: const Text("로그인을 해주세요"),
                                        actions: [
                                          ElevatedButton(
                                            child: const Text("확인"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ));
                            } else {
                              try {
                                if (replyId == null) {
                                  await postCommunityBoardComment(
                                      widget.boardId,
                                      widget.postId,
                                      _controller.text);
                                } else {
                                  await postReplyComment(
                                      widget.boardId,
                                      widget.postId,
                                      replyId!,
                                      _controller.text);
                                }
                                await getComment();
                              } catch (e) {
                                log(e.toString());
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text("댓글 작성에 실패했습니다"),
                                          content: const Text("잠시 후 다시 시도해주세요"),
                                          actions: [
                                            ElevatedButton(
                                              child: const Text("확인"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        ));
                              }
                              setState(() {
                                _controller.text = "";
                              });
                            }
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
