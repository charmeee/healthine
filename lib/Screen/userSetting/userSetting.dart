import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthin/Model/routine_models.dart';
import 'package:healthin/Model/user_model.dart';
import 'package:healthin/Provider/user_provider.dart';

class UserSetting extends ConsumerStatefulWidget {
  const UserSetting({Key? key}) : super(key: key);

  @override
  ConsumerState<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends ConsumerState<UserSetting> {
  final formKey = GlobalKey<FormState>();
  @override
  late UserInfo _userinfo;
  void initState() {
    // TODO: implement initState
    _userinfo = ref.read(userStateProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.backspace),
        ),
        title: Text("사용자 설정"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              color: Colors.grey,
              size: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _userinfo.nickname.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Form(
              key: this.formKey,
              child: Column(
                children: [
                  ListTile(
                    leading: Text("아이디"),
                    title: Text(_userinfo.username.toString()),
                  ),
                  ListTile(
                    leading: Text("닉네임"),
                    title: Text(_userinfo.nickname.toString()),
                    trailing: Icon(Icons.edit),
                  ),
                  ListTile(
                    leading: Text("등록핼스장"),
                    title: Text("관악관악헬스"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("비밀번호 변경"),
                      style: ElevatedButton.styleFrom(primary: Colors.indigo),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  // renderTextFormField({
  //   required String label,
  //   required FormFieldSetter onSaved,
  //   required FormFieldValidator validator,
  // }) {
  //   assert(onSaved != null);
  //   assert(validator != null);
  //
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           Text(
  //             label,
  //             style: TextStyle(
  //               fontSize: 12.0,
  //               fontWeight: FontWeight.w700,
  //             ),
  //           ),
  //         ],
  //       ),
  //       TextFormField(
  //         onSaved: onSaved,
  //         validator: validator,
  //       ),
  //       Container(height: 16.0),
  //     ],
  //   );
  // }
}
