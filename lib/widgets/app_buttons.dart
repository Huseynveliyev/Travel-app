import 'package:flutter/material.dart';
import 'package:traveler_app/misc/colors.dart';
import 'package:traveler_app/widgets/app_text.dart';

class AppButtons extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  double size;
  final Color borderColor;
  String? text;
  IconData? icon;
  bool? isIcon;

  AppButtons({
    this.isIcon = false,
    this.text = 'hi',
    this.icon,
    required this.size,
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
        ),
        child: isIcon == false
            ? Center(child: AppText(text: text!, color: color))
            : Center(child: Icon(icon, color: color)));
  }
}
