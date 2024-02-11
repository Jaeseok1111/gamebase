import 'package:flutter/material.dart';
import 'package:gamebase_ui/styles.dart';

class _SmartTextPattern {
  const _SmartTextPattern({
    required this.regex,
    required this.builder,
  });

  final String regex;
  final Widget Function(String match) builder;
}

class _SmartTextString {
  const _SmartTextString({
    required this.start,
    required this.end,
    required this.builder,
  });

  final int start;
  final int end;
  final Widget Function(String match) builder;
}

class SmartText extends StatelessWidget {
  SmartText(
    this.text, {
    super.key,
    this.style = const TextStyle(
      color: MyColors.hintColor,
      fontSize: 13,
    ),
  });

  final String text;
  final TextStyle style;

  final List<_SmartTextPattern> _patternList = [
    _SmartTextPattern(
      regex: "(<code>)(.*?)(<code>)",
      builder: (match) {
        return Container(
          decoration: ShapeDecoration(
            color: MyColors.baseAlt2Color,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: MyColors.baseAlt2Color),
              borderRadius: BorderRadius.circular(BorderCircular.base),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            match.replaceAll("<code>", ""),
            style: const TextStyle(
              color: MyColors.hintColor,
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
          ),
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<String> lines = text.split("\n");

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) => _toString(line)).toList(),
    );
  }

  Row _toString(String string) {
    List<_SmartTextString> strings = _toSmartString(string);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: strings.map((x) {
        String match = string.substring(x.start, x.end);
        return x.builder(match);
      }).toList(),
    );
  }

  List<_SmartTextString> _toSmartString(String string) {
    List<_SmartTextString> patternMatches = [];

    for (_SmartTextPattern pattern in _patternList) {
      for (Match match in RegExp(pattern.regex).allMatches(string)) {
        patternMatches.add(_SmartTextString(
          start: match.start,
          end: match.end,
          builder: pattern.builder,
        ));
      }
    }

    patternMatches.sort((a, b) => a.start.compareTo(b.start));

    int index = 0;
    List<_SmartTextString> strings = [...patternMatches];

    for (_SmartTextString match in patternMatches) {
      strings.add(_SmartTextString(
        start: index,
        end: match.start,
        builder: (match) {
          return Text(match, style: style);
        },
      ));

      index = match.end;
    }

    if (index < string.length) {
      strings.add(_SmartTextString(
        start: index,
        end: string.length,
        builder: (match) {
          return Text(match, style: style);
        },
      ));
    }

    strings.sort((a, b) => a.start.compareTo(b.start));

    return strings;
  }
}
