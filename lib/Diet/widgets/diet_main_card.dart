import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthin/Common/Const/const.dart';
import 'package:healthin/Common/styles/boxStyle.dart';
import 'package:healthin/Common/styles/textStyle.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/diet_model.dart';
import '../providers/diet_provider.dart';
import '../providers/main_diet_card_provider.dart';
import '../screens/diet_input_screen.dart';

List<Map> nutrientStyle = [
  {"type": "탄수화물", "color": Colors.green, "standard": standardCarbohydrate},
  {"type": "단백질", "color": Colors.blue, "standard": standardProtein},
  {"type": "지방", "color": Colors.red, "standard": standardFat},
];

const int standardCalorie = 2000;
const int standardCarbohydrate = 90;
const int standardProtein = 60;
const int standardFat = 25;

class DietCard extends ConsumerWidget {
  const DietCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dietCardProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "오늘의 음식",
              style: h3Bold_18,
            ),
            Container(
              height: 36,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DietInputScreen()),
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/add_small.svg',
                    color: whiteColor,
                  )),
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: borderContainer,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 56,
                decoration: filledContainer.copyWith(
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "섭취 칼로리",
                      style: bodyRegular_14,
                    ),
                    Row(
                      children: [
                        Text(
                          "${data.totalCalories}kcal",
                          style: h3Bold_18,
                        ),
                        Text(
                          "/" + standardCalorie.toString(),
                          style: bodyRegular_14,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              for (var i = 0; i < 3; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Row(
                      children: [
                        Text(
                          nutrientStyle[i]["type"],
                          style: bodyRegular_14,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          data.nutrientListPerGram[i].toString(),
                          style: bodyBold_14,
                        ),
                        Text(
                          "/${nutrientStyle[i]["standard"]}g",
                          style: bodyRegular_14,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      child: LinearPercentIndicator(
                        padding: const EdgeInsets.all(0),
                        percent: data.nutrientListPerGram[i] >
                                nutrientStyle[i]["standard"]
                            ? 1
                            : data.nutrientListPerGram[i] /
                                nutrientStyle[i]["standard"],
                        lineHeight: 10,
                        progressColor: nutrientStyle[i]["color"],
                        barRadius: Radius.circular(12.0),
                      ),
                    )
                  ]),
                ),
              if (data.dietImgPerType.isNotEmpty)
                SizedBox(
                  height: 88,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.dietImgPerType.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              "$imgBaseUrl${data.dietImgPerType[index]["img"]}",
                              height: 88,
                              width: 88,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      }),
                )
            ],
          ),
        ),
      ],
    );
  }
}
