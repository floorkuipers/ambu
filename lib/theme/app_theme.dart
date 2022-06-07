import 'package:ambu/theme/colors.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static const colors = AppColors();

  const AppTheme._();

  static ThemeData define(){
    return ThemeData(
      fontFamily: "Roboto",

    );
  }
}