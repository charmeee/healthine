import 'package:flutter/material.dart';

class UserSetting extends StatefulWidget {
  const UserSetting({Key? key}) : super(key: key);

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  final formKey = GlobalKey<FormState>();

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
              "전민지",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Form(
              key: this.formKey,
              child: Column(
                children: [
                  ListTile(
                    leading: Text("전화번호"),
                    title: Text("01020202020"),
                    trailing: Icon(Icons.edit),
                  ),
                  ListTile(
                    leading: Text("닉네임"),
                    title: Text("와라라랄"),
                    trailing: Icon(Icons.edit),
                  ),
                  ListTile(
                    leading: Text("등록핼스장"),
                    title: Text("관악관악헭스"),
                  ),
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
