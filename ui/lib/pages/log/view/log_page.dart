import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamebase_ui/appbar.dart';
import 'package:gamebase_ui/layout.dart';
import 'package:gamebase_ui/styles.dart';
import 'package:gamebase_ui/widgets/dialog/settings_dialog.dart';
import 'package:gamebase_ui/widgets/form/form_switch_field.dart';
import 'package:gamebase_ui/widgets/form/form_text_field.dart';
import 'package:gap/gap.dart';

class LogViewPage extends StatelessWidget {
  const LogViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      menu: AppMenu.logs,
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.base,
              vertical: Spacing.base - 5,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ToolBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolBar extends StatelessWidget {
  const _ToolBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Logs",
          style: TextStyle(
            color: MyColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Gap(Spacing.xs),
        IconButton(
          icon: const Icon(
            FontAwesomeIcons.gear,
            size: 19,
          ),
          tooltip: "Logs Settings",
          style: IconButton.styleFrom(
            fixedSize: const Size(40, 40),
          ),
          onPressed: () async {
            await showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return SettingsDialog(
                  future: Future.delayed(const Duration(milliseconds: 500)),
                  title: "Logs settings",
                  children: [
                    const FormTextField(
                      label: "Max days retention",
                      required: true,
                      helpText:
                          "Set to <code>0<code> to disable logs persistence.",
                    ),
                    const Gap(Spacing.base),
                    const FormTextField(
                      label: "Min log level",
                      required: false,
                      helpText:
                          "Logs with level below the minimum will be ignored.\nDefault log levels: <code>-4:DEBUG<code>  <code>0:INFO<code>  <code>4:WARN<code>  <code>8:ERROR<code>",
                    ),
                    const Gap(Spacing.base),
                    FormSwitchField(
                      label: "Enable IP logging",
                      value: true,
                      onChanged: (value) {},
                    )
                  ],
                );
              },
            );
          },
        ),
        const Gap(Spacing.xs),
        IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.arrowsRotate,
            size: 19,
          ),
          tooltip: "Refresh",
          style: IconButton.styleFrom(
            fixedSize: const Size(40, 40),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
