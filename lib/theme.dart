

import 'package:flutter/material.dart';

class MyTheme {
  static final bgColor = Colors.grey[850];
  static final lineColor = Colors.grey[800];
  static final greyText = Colors.grey[400];
  static final textStyle = TextStyle(color: greyText);
  static final selectedTileText = Colors.white;
}

class CustomTheme {
  static ThemeData get lightTheme { //1
    return ThemeData( //2
      // primaryColor: CustomColors.purple,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Montserrat', //3
      buttonTheme: ButtonThemeData( // 4
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        // buttonColor: CustomColors.lightPurple,
      )
    );
  }
}