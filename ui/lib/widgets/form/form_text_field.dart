part of 'forms.dart';

class FormTextField extends StatefulWidget {
  const FormTextField({
    super.key,
    required this.label,
    required this.required,
    required this.helpText,
  });

  final String label;
  final bool required;
  final String? helpText;

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  late FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode();
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_focus);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: ShapeDecoration(
              color: _focus.hasFocus
                  ? MyColors.baseAlt2Color
                  : MyColors.baseAlt1Color,
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(
                  Radius.circular(BorderCircular.base),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: widget.label),
                      if (widget.required)
                        const TextSpan(
                          text: " * ",
                          style: TextStyle(color: MyColors.danger),
                        )
                    ],
                    style: TextStyle(
                      color: _focus.hasFocus
                          ? MyColors.primary
                          : MyColors.hintColor,
                      fontSize: 13,
                      fontWeight:
                          _focus.hasFocus ? FontWeight.bold : FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  height: 35,
                  margin: const EdgeInsets.only(top: 5),
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    onTap: () => setState(() {}),
                    focusNode: _focus,
                    cursorColor: MyColors.hintColor,
                    cursorHeight: 20,
                    cursorWidth: 1.5,
                    style: const TextStyle(
                      color: MyColors.primary,
                      fontSize: 15,
                      height: 20 / 15,
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.helpText != null) const Gap(10),
        if (widget.helpText != null) SmartText(widget.helpText!)
      ],
    );
  }
}
