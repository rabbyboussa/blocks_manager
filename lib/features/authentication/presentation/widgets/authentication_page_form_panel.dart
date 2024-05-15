import 'package:blocks/config/routes/routes_names.dart';
import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/widgets/k_textfield_with_description.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';

class AuthenticationPageFormPanel extends StatefulWidget {
  const
  AuthenticationPageFormPanel({Key? key}) : super(key: key);

  @override
  State<AuthenticationPageFormPanel> createState() =>
      _AuthenticationPageFormPanelState();
}

class _AuthenticationPageFormPanelState
    extends State<AuthenticationPageFormPanel> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        switch (state.runtimeType) {
          case AuthenticationLoadingState:
            showProgressDialog(
              context,
              message: 'Veuillez patienter...',
            );
            break;
          case AuthenticationFailedState:
            context.pop();
            showInfoBar(
              context,
              title: 'Authentification échoué',
              message: state.message!,
              severity: InfoBarSeverity.error,
            );
            break;
          case AuthenticationDoneState:
            context.pop();

            context.goNamed(RoutesNames.home);

            break;
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 50.w(context),
          child: Form(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w(context)),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container(
                        //   width: 60,
                        //   height: 60,
                        //   decoration: const BoxDecoration(
                        //       image: DecorationImage(
                        //     image: AssetImage('assets/images/sambo.png'),
                        //     fit: BoxFit.contain,
                        //   )),
                        // ),
                        const SizedBox(height: 48),
                        const Text(
                          'Authentification',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                            'Veuillez saisir vos identifiants de connexion afin d\'accéder au système.'),
                        const SizedBox(height: 32),
                        KInputFieldWithDescription(
                          label: 'Nom d\'utilisateur',
                          isMandatory: true,
                          inputWidget: TextBox(
                            controller: _userNameController,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        KInputFieldWithDescription(
                          label: 'Mot de passe',
                          isMandatory: true,
                          inputWidget: TextBox(
                            controller: _passwordController,
                            obscureText: obscurePassword,
                            suffix: IconButton(
                                icon: Icon(
                                  obscurePassword
                                      ? FluentIcons.view
                                      : FluentIcons.hide3,
                                  size: 18,
                                ),
                                focusable: false,
                                onPressed: () => setState(
                                    () => obscurePassword = !obscurePassword)),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('Mot de passe oublié ? '),
                            HyperlinkButton(
                              child:
                                  const Text('Réinitialiser le mot de passe'),
                              onPressed: () {},
                            )
                          ],
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: FilledButton(
                                style: ButtonStyle(
                                  padding: ButtonState.all(
                                    const EdgeInsets.symmetric(vertical: 8),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_userNameController.text.trim().isEmpty ||
                                      _passwordController.text.trim().isEmpty) {
                                    showInfoBar(
                                      context,
                                      title: 'Attention',
                                      message:
                                          'Veuillez renseigner votre nom d\'utilisateur et votre mot de passe avant de poursuivre.',
                                      severity: InfoBarSeverity.warning,
                                    );
                                  } else {
                                    context.read<AuthenticationBloc>().add(
                                          AuthenticateEvent(
                                            username: _userNameController.text,
                                            password: _passwordController.text,
                                          ),
                                        );
                                  }
                                },
                                child: const Text('Continuer'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Text('Version 1.24.1 Sambo © 2024'),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
