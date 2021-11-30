import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kerjain/component/button_secondary.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Lato',
      primaryColor: ColorsCustom.primary2,
      primarySwatch: MaterialColor(ColorsCustom.primary1.value, {
        50: ColorsCustom.primary1.withOpacity(0.9),
        100: ColorsCustom.primary1.withOpacity(0.8),
        200: ColorsCustom.primary1.withOpacity(0.7),
        300: ColorsCustom.primary1.withOpacity(0.6),
        400: ColorsCustom.primary1.withOpacity(0.5),
        500: ColorsCustom.primary1,
        600: ColorsCustom.primary1.withOpacity(0.1),
        700: ColorsCustom.primary1.withOpacity(0.2),
        800: ColorsCustom.primary1.withOpacity(0.3),
        900: ColorsCustom.primary1.withOpacity(0.4),
      }),
      scaffoldBackgroundColor: Colors.white,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: ColorsCustom.primary2,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Lato',
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: Colors.pink[50],
        ));
  }

  static AppBar appBar({List<Widget>? actions, Widget? title}) {
    return AppBar(
      centerTitle: true,
      title: title,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: ButtonSecondary(
            child: Icon(Icons.arrow_back, color: ColorsCustom.textPrimary),
            onPressed: () => Get.back()),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: actions,
      foregroundColor: ColorsCustom.textPrimary,
    );
  }
}
