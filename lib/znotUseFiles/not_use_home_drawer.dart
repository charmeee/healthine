import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/User/providers/user_provider.dart';
import 'package:healthin/User/screens/userSetting_screen.dart';
import 'package:healthin/Routine/routine_models.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("빌드시작");
    final _userdata = ref.watch(userProfileNotifierProvider);
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            accountName: Text("닉네임: ${_userdata.nickname}"),
            //accountEmail: Text("닉네임: ${_userdata.nickname}"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              //backgroundImage: null,
            ),
            accountEmail: null,
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.grey[850],
            ),
            title: Text('헬스장 정보'),
            onTap: () {
              print('Home is clicked');
            },
            trailing: Icon(Icons.add),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.grey[850],
            ),
            title: Text('설정'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserSetting()));
              print('Setting is clicked');
            },
            trailing: Icon(Icons.add),
          ),
          ListTile(
            leading: Icon(
              Icons.question_answer,
              color: Colors.grey[850],
            ),
            title: Text('Q&A'),
            onTap: () {
              print('Q&A is clicked');
            },
            trailing: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
