import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/app_colors.dart';

class NotificationCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final isMorning = currentTime.hour > 12;

    String greetingText = isMorning ? "صباح الخير " : "مساء الخير";
    String messageText = isMorning
        ? "أنت تعمل الآن في الفترة الصباحية.\n أحرص على انجاز المهام و تدقيقها بشكل صحيح."
        : "أنت تعمل ضمن الفترة المسائية. \nأحرص على انجاز العمل بشكل صحيح.";
    String imageAsset = isMorning ? "assets/m.png" : "assets/n.png";

    return Container(
      decoration: BoxDecoration(
        color: AppColor.yellow,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  style: TextStyle(fontSize: 16, color: AppColor.white),
                  children: [
                    TextSpan(text: greetingText),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                messageText,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.white,
                  height: 1.5,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          if (MediaQuery.of(context).size.width >= 620) ...{
            Spacer(),
            Image.asset(
              imageAsset,
              height: 160,
            )
          }
        ],
      ),
    );
  }
}
