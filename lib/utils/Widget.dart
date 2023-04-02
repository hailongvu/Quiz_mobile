import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'Colors.dart';

Widget appButton(BuildContext context,
    {required String btnText,
    Color? bgColor,
    required double width,
    required double shape,
    Function? onPress,
    Color? txtColor}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      elevation: 0.0,
      padding: const EdgeInsets.all(14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(shape)),
    ),
    onPressed: () {
      if (onPress != null) {
        onPress.call();
      }
    },
    child: Text(btnText, style: boldTextStyle(color: txtColor, size: 14)),
  ).withWidth(width);
}
final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  elevation: 0, backgroundColor: blue,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(50)),
  ),
);
