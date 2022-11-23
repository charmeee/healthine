import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/boxStyle.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:healthin/Dictionary/models/dictionary_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DictionaryDetail extends StatelessWidget {
  final ManualData founddata;

  DictionaryDetail({Key? key, required this.founddata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: backgroundColor,
        title: Text(founddata.title.toString()),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            color: darkGrayColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (founddata.imageUrl != null)
              AspectRatio(
                  aspectRatio: 1.0,
                  child: Image.network(imgBaseUrl + founddata.imageUrl!)),
            Container(
              decoration: filledContainer,
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "기구   ",
                        style: bodyBold_14.copyWith(color: primaryColor),
                      ),
                      Text(
                        founddata.equipmentTitle ?? "---",
                        style: bodyBold_14,
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "타입   ",
                        style: bodyBold_14.copyWith(color: primaryColor),
                      ),
                      Text(
                        founddata.type.toString(),
                        style: bodyBold_14,
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "운동 방법",
                        style: bodyBold_16,
                      ),
                    ),
                    for (int i = 0; i < founddata.description!.length; i++) ...[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${(i + 1).toString().padLeft(2, '0')}. ${founddata.description![i]}',
                          style: bodyRegular_16,
                        ),
                      )
                    ],
                    SizedBox(
                      height: 24,
                    ),
                    if (founddata.precaution != null) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "주의점",
                          style: bodyBold_16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${founddata.precaution}',
                          style: bodyRegular_16,
                        ),
                      )
                    ]
                  ]
                  // founddata.description!
                  //     .map((item) => Padding(
                  //           padding: const EdgeInsets.all(4.0),
                  //           child: Text(
                  //             '$item',
                  //             style: bodyRegular_16,
                  //           ),
                  //         ))
                  //     .toList()),
                  ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: TextButton.icon(
                  onPressed: () {
                    if (founddata.videoUrl != null) {
                      launchUrl(Uri.parse(founddata.videoUrl!));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("해당 운동에 대한 영상이 없습니다.")));
                    }
                  },
                  label: Text(
                    "운동영상",
                    style: bodyRegular_14.copyWith(color: lightGrayColor),
                  ),
                  icon: SvgPicture.asset(
                    "assets/icons/video.svg",
                    width: 24,
                    height: 24,
                  ),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.white),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
