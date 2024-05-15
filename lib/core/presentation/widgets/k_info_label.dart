import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

class KInfoLabel extends StatelessWidget {
  const KInfoLabel({
    super.key,
    required this.label,
    this.child,
    this.isMandatory = false,
  });

  final String label;
  final Widget? child;
  final bool isMandatory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: !isMandatory
              ? Text(label)
              : EasyRichText(
                  '$label *',
                  patternList: [
                    EasyRichTextPattern(
                      targetString: '*',
                      hasSpecialCharacters: true,
                      style: const TextStyle(color: Colors.red),
                    )
                  ],
                ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          child: child,
        )
      ],
    );
  }
}
