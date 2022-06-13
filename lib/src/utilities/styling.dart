
import 'package:flutter/material.dart';

  TextStyle fontStyle(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Colors.black);
  }
