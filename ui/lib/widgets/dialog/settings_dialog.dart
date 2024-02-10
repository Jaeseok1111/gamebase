import 'package:flutter/material.dart' hide TextButton;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamebase_ui/styles.dart';
import 'package:gamebase_ui/widgets/animation/rotate.dart';
import 'package:gamebase_ui/widgets/button/text_button.dart';
import 'package:gap/gap.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({
    super.key,
    required this.future,
    required this.title,
    required this.children,
  });

  final Future<void> future;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BorderCircular.base),
      ),
      child: SizedBox(
        width: 600,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Header(title: title),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.base,
                  ),
                  child: FutureBuilder(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const RotateAnimation(
                          duration: Duration(milliseconds: 500),
                          child: FaIcon(
                            FontAwesomeIcons.circleNotch,
                            color: MyColors.primary,
                            size: 40,
                          ),
                        );
                      }

                      return Column(children: children);
                    },
                  ),
                ),
              ),
            ),
            const _Footer(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.base,
        vertical: Spacing.base - 7.0,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: MyColors.primary,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: IconButton.styleFrom(
              fixedSize: const Size(20, 20),
            ),
            icon: const FaIcon(
              FontAwesomeIcons.xmark,
              color: MyColors.primary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.base,
        vertical: Spacing.base - 7.0,
      ),
      decoration: const BoxDecoration(
        color: MyColors.body,
        border: Border(
          top: BorderSide(
            width: 1,
            color: MyColors.baseAlt2Color,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 13, 0),
            offset: Offset(-4, 5),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            "Cancel",
            fontColor: MyColors.primary,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          const Gap(Spacing.sm),
          const TextButton(
            "Save Changes",
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
