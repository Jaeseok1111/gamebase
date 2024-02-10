import 'package:flutter/material.dart' hide TextButton;
import 'package:gamebase_ui/styles.dart';

import 'button.dart';

class TextButton extends StatelessWidget {
  const TextButton(
    String label, {
    super.key,
    required this.onPressed,
    this.fontColor = Colors.white,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
  }) : text = label;

  final String text;
  final VoidCallback? onPressed;

  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      size: const Size.fromHeight(40),
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 5.0,
      ),
      color: Colors.transparent,
      borderColor: Colors.transparent,
      child: Text(
        text,
        style: TextStyle(
          color: onPressed != null ? fontColor : MyColors.disabled,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
