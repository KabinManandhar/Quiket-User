import 'package:flutter/material.dart';
import 'package:testawwpp/control/style.dart';

ThemeData themedata() {
  return ThemeData(
      cursorColor: Colors.black45,
      scaffoldBackgroundColor: Colors.grey[300],
      primaryColor: Colors.grey[300],
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(title: appBarText),
      ),
      textTheme: TextTheme(title: titleText, body1: body1Text),
      brightness: Brightness.light,
      accentColor: Colors.black);
}
