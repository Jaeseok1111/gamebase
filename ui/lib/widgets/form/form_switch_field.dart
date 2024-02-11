part of 'forms.dart';

class FormSwitchField extends StatefulWidget {
  const FormSwitchField({
    super.key,
    required this.label,
    required this.onChanged,
  });

  final String label;
  final void Function(bool value) onChanged;

  @override
  State<FormSwitchField> createState() => _FormSwitchFieldState();
}

class _FormSwitchFieldState extends State<FormSwitchField> {
  bool _value = true;

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
              value: _value,
              splashRadius: 0.0,
              onChanged: (value) {
                setState(() {
                  _value = value;
                  widget.onChanged(value);
                });
              },
              activeColor: Colors.white,
              activeTrackColor: MyColors.success,
            ),
          ),
          const Gap(10),
          Text(
            widget.label,
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
