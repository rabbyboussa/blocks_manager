import 'package:blocks/features/authentication/presentation/widgets/authentication_page_form_panel.dart';
import 'package:blocks/features/authentication/presentation/widgets/authentication_page_image_panel.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      content: Row(
        children: [
          AuthenticationPageImagePanel(),
          AuthenticationPageFormPanel(),
        ],
      ),
    );
  }
}
