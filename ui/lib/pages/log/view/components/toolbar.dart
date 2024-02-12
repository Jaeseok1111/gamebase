import 'package:design/design.dart';
import 'package:flutter/material.dart' hide AlertDialog;

class ToolBar extends StatelessWidget {
  const ToolBar({
    super.key,
    required this.onRefresh,
  });

  final void Function() onRefresh;

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
                return AlertDialog(
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
                          "Logs with level below the minimum will be ignored.\n"
                          "Default log levels: <code>-4:DEBUG<code>  <code>0:INFO<code>  <code>4:WARN<code>  <code>8:ERROR<code>",
                    ),
                    const Gap(Spacing.base),
                    FormSwitchField(
                      label: "Enable IP logging",
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
          onPressed: onRefresh,
        ),
      ],
    );
  }
}
