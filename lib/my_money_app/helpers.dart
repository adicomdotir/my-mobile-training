import 'package:flutter/material.dart';

Color convertHexColorToRgb(String color) {
    Color resultColor = Colors.white;
    try {
      var red = int.parse(color.substring(0, 2), radix: 16);
      var green = int.parse(color.substring(2, 4), radix: 16);
      var blue = int.parse(color.substring(4), radix: 16);
      resultColor = Color.fromRGBO(red, green, blue, 1.0);
    } catch (ex) {
      // change color if you want
    }
    return resultColor;
  }