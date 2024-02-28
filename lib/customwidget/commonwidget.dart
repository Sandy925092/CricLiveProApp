import 'package:flutter/cupertino.dart';

Widget commonText({
  Color? color,
  TextAlign? alignment,
  int? maxLines,
  TextOverflow? overflow,
  required String data,
  required double fontSize,
  FontWeight? fontWeight,
  String? fontFamily,
}) {
  return Text(
    data,
    textAlign: alignment,
    maxLines: maxLines,
    style: TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      overflow: overflow,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}
