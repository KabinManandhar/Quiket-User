import 'package:flutter/material.dart';

const largeTextSize = 65.0;
const midTextSize = 25.0;
const bodyTextSize = 20.0;

const String fontName = 'NunitoSans';

const TextStyle appBarText = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w300,
    fontSize: largeTextSize,
    color: Colors.black54);

final TextStyle titleText = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: midTextSize,
    color: Colors.grey[700]);

final TextStyle body1Text = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: bodyTextSize,
    color: Colors.grey[700]);

final TextStyle labelTextStyle =
    TextStyle(fontSize: 20, color: Colors.grey, fontFamily: fontName);
final TextStyle labelTextSmallStyle =
    TextStyle(fontSize: 15, color: Colors.grey, fontFamily: fontName);
final double buttonSize = 25;
final Color buttonColor = Colors.grey[700];
