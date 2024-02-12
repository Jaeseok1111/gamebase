import 'package:flutter/material.dart' hide TextButton;
import 'package:design/styles/styles.dart';

import 'button.dart';

class TextButtonStyleForm extends ButtonStyleForm {
  const TextButtonStyleForm({
    this.fontColor = Colors.white,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    super.size = const Size.fromHeight(40),
    super.padding = const EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 5.0,
    ),
    super.color = Colors.transparent,
    super.hoverColor,
    super.focusedColor,
    super.pressedColor,
    super.borderColor = Colors.transparent,
    super.borderRadius,
  });

  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;
}

class TextButton extends StatelessWidget {
  const TextButton(
    String label, {
    super.key,
    required this.onPressed,
    this.styleForm = const TextButtonStyleForm(),
  }) : text = label;

  final String text;
  final VoidCallback? onPressed;

  final TextButtonStyleForm styleForm;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      styleForm: styleForm,
      child: Text(
        text,
        style: TextStyle(
          color: onPressed != null ? styleForm.fontColor : MyColors.disabled,
          fontSize: styleForm.fontSize,
          fontWeight: styleForm.fontWeight,
        ),
      ),
    );
  }
}
