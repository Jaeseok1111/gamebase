import 'package:flutter/material.dart';
import 'package:gamebase_ui/styles.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.padding,
    required this.child,
    required this.onPressed,
    this.size,
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

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0.0),
        alignment: Alignment.center,
        fixedSize: MaterialStateProperty.all(size),
        padding: MaterialStateProperty.all(padding),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          side: BorderSide(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(borderRadius),
        )),
        splashFactory: NoSplash.splashFactory,
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return hoverColor;
          }

          if (states.contains(MaterialState.focused)) {
            return focusedColor;
          }

          if (states.contains(MaterialState.pressed)) {
            return pressedColor;
          }

          if (states.contains(MaterialState.disabled)) {
            return disabledColor;
          }

          return color;
        }),
      ),
      child: child,
    );
  }
}
