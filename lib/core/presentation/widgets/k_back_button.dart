import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

class KBackButton extends StatelessWidget {
  const KBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(FluentIcons.chevron_left_small),
      onPressed: () => context.pop(),
    );
  }
}
