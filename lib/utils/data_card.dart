import 'package:boozin_fitness/app/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DataCard extends StatelessWidget {
  final String title;
  final String icon;
  final int goal;
  final int value;

  const DataCard(
      {super.key,
      required this.title,
      required this.value,
      required this.icon,
      required this.goal});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: SizedBox(
        height: Get.height * 0.17,
        width: Get.width * 0.9,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width * 0.6,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "$title: ",
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text: formatUnit(value),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    backgroundColor: Get.isDarkMode
                        ? const Color(0xff8A8A8A)
                        : const Color(0xFFC4C4C4),
                    value: (value / goal).toDouble(),
                    borderRadius: BorderRadius.circular(13),
                    color: Theme.of(context).focusColor,
                    minHeight: 16,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text(
                          "0",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        "${'goal'.tr}:${formatUnit(goal)}",
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            SvgPicture.asset(
              "assets/icons/$icon.svg",
              colorFilter: ColorFilter.mode(
                Theme.of(context).focusColor,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
