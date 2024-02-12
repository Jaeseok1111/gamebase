import 'package:flutter/material.dart';
import 'package:design/styles/styles.dart';

class ButtonStyleForm {
  const ButtonStyleForm({
    this.size,
    this.padding = EdgeInsets.zero,
    this.borderWidth = 1.0,
    this.borderRadius = BorderCircular.base,
    this.borderColor = MyColors.primary,
    this.color = MyColors.primary,
    this.hoverColor = MyColors.baseAlt1Color,
    this.focusedColor = MyColors.baseAlt2Color,
    this.pressedColor = MyColors.baseAlt2Color,
    this.disabledColor = MyColors.baseAlt1Color,
  });

  final Size? size;
  final EdgeInsets padding;

  final double borderWidth;
  final double borderRadius;
  final Color borderColor;

  final Color color;
  final Color hoverColor;
  final Color focusedColor;
  final Color pressedColor;
  final Color disabledColor;
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.child,
    required this.onPressed,
    this.styleForm = const ButtonStyleForm(),
  });

  final Widget child;
  final VoidCallback? onPressed;

  final ButtonStyleForm styleForm;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0.0),
        alignment: Alignment.center,
        fixedSize: MaterialStateProperty.all(styleForm.size),
        padding: MaterialStateProperty.all(styleForm.padding),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          side: BorderSide(
            color: styleForm.borderColor,
            width: styleForm.borderWidth,
          ),
          borderRadius: BorderRadius.circular(styleForm.borderRadius),
        )),
        splashFactory: NoSplash.splashFactory,
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return styleForm.hoverColor;
          }

          if (states.contains(MaterialState.focused)) {
            return styleForm.focusedColor;
          }

          if (states.contains(MaterialState.pressed)) {
            return styleForm.pressedColor;
          }

          if (states.contains(MaterialState.disabled)) {
            return styleForm.disabledColor;
          }

          return styleForm.color;
        }),
      ),
      child: child,
    );
  }
}
