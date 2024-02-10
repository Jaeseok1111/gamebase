import 'package:flutter/material.dart';
import 'package:gamebase_ui/styles.dart';
import 'package:gap/gap.dart';

class FormSwitchField extends StatelessWidget {
  const FormSwitchField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final void Function(bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.fitHeight,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: MyColors.success,
            ),
          ),
          const Gap(10),
          Text(
            label,
            style: const TextStyle(
              color: MyColors.hintColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
