import 'package:flutter/material.dart' hide TextButton;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamebase_ui/styles.dart';
import 'package:gamebase_ui/widgets/button/text_button.dart';
import 'package:gamebase_ui/widgets/text/smart_text.dart';
import 'package:gap/gap.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_focusNode),
          child: Container(
            width: double.maxFinite,
            height: 45,
            decoration: ShapeDecoration(
              color: MyColors.baseAlt1Color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  BorderCircular.buttonHeight,
                ),
              ),
            ),
            padding: const EdgeInsets.only(
              left: 20,
              right: 10,
              top: 5,
              bottom: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: MyColors.hintColor,
                  size: 17,
                ),
                const Gap(10),
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    cursorColor: MyColors.primary,
                    cursorHeight: 17,
                    cursorWidth: 1.5,
                    style: const TextStyle(
                      color: MyColors.primary,
                      fontSize: FontSize.base,
                      height: 17 / FontSize.base,
                    ),
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      contentPadding: EdgeInsets.only(top: 2.0),
                      hintText:
                          "Search term or filter like `level > 0 && data.auth = 'guest'`",
                      hintStyle: TextStyle(
                        color: MyColors.hintColor,
                        fontSize: FontSize.base,
                        height: 17 / FontSize.base,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onChanged: (value) {},
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    TextButton(
                      "Search",
                      onPressed: () {},
                      styleForm: const TextButtonStyleForm(
                        color: MyColors.warning,
                        hoverColor: MyColors.warning,
                        focusedColor: MyColors.warning,
                        pressedColor: MyColors.warning,
                        fontSize: FontSize.sm,
                        fontColor: Colors.white,
                        fontWeight: FontWeight.w600,
                        size: Size.fromHeight(20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        borderRadius: BorderCircular.buttonHeight,
                      ),
                    ),
                    const Gap(5),
                    TextButton(
                      "Clear",
                      onPressed: () {},
                      styleForm: const TextButtonStyleForm(
                        color: MyColors.baseAlt2Color,
                        hoverColor: MyColors.baseAlt2Color,
                        fontSize: FontSize.sm,
                        fontColor: MyColors.disabled,
                        fontWeight: FontWeight.w400,
                        size: Size.fromHeight(20),
                        padding: EdgeInsets.zero,
                        borderRadius: BorderCircular.buttonHeight,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        const Gap(10),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SmartText(
            "Default log levels: <code>-4:DEBUG<code> <code>0:INFO<code> <code>4:WARN<code> <code>8:ERROR<code>",
            style: const TextStyle(
              color: MyColors.hintColor,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
