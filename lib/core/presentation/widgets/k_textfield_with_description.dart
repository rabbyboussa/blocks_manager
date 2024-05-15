import 'package:blocks/core/presentation/widgets/k_info_label.dart';
import 'package:fluent_ui/fluent_ui.dart';

class KInputFieldWithDescription extends StatelessWidget {
  const KInputFieldWithDescription({
    super.key,
    required this.label,
    this.isMandatory = false,
    this.description = '',
    required this.inputWidget,
  });

  final String label;
  final bool isMandatory;
  final String description;
  final Widget inputWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KInfoLabel(
          label: label,
          isMandatory: isMandatory,
          child: inputWidget,
        ),
        SizedBox(height: description.isEmpty ? 0 : 6),
        SizedBox(
          child: description.isNotEmpty
              ? Text(
                  description,
                  style: TextStyle(color: Colors.grey[120]),
                )
              : const SizedBox(),
        )
      ],
    );
  }
}
