import 'package:blocks/config/routes/routes_names.dart';
import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/constants/menu.dart';
import 'package:blocks/features/administration/accounts/domain/entities/role_entity.dart';
import 'package:blocks/features/administration/employees/domain/entities/employee_entity.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final _accountMenuController = FlyoutController();

  @override
  void initState() {
    super.initState();

    context.read<AuthenticationBloc>().add(FetchDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case FetchingDataDoneState:
            {
              context.pop();
            }
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case AuthenticationLoadingState:
            {
              return const material.Scaffold(
                body: Center(
                  child: ProgressRing(
                    activeColor: kBrown,
                  ),
                ),
              );
            }
          case FetchingDataDoneState:
            {
              EmployeeEntity employee = state.employees!.firstWhere(
                  (element) => element.id == state.account?.employeeId);

              RoleEntity role = state.roles!
                  .firstWhere((element) => element.id == state.account?.roleId);

              return NavigationView(
                appBar: const NavigationAppBar(
                  title: Text(
                      'Blocks: Solution de gestion professionnelle pour briqueterie'),
                  automaticallyImplyLeading: false,
                ),
                pane: NavigationPane(
                  selected: _selectedIndex,
                  displayMode: PaneDisplayMode.open,
                  size: NavigationPaneSize(openWidth: 18.w(context)),
                  onChanged: (index) {
                    setState(() => _selectedIndex = index);
                  },
                  items: menu[role.name.toLowerCase()]!,
                  footerItems: [
                    _buildAccountMenuPane(
                      context,
                      employee: employee,
                      role: role,
                    ),
                  ],
                ),
              );
            }
          default:
            return const SizedBox();
        }
      },
    );
  }

  PaneItemAction _buildAccountMenuPane(
    BuildContext context, {
    required EmployeeEntity employee,
    required RoleEntity role,
  }) {
    return PaneItemAction(
      icon: FlyoutTarget(
        controller: _accountMenuController,
        child: SizedBox(
          width: 12.w(context),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(10),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(FluentIcons.contact),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${employee.lastname} ${employee.firstname}',
                      maxLines: 1,
                    ),
                    Text(
                      role.name,
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              const Icon(
                FluentIcons.chevron_down,
                size: 8,
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _accountMenuController.showFlyout(
          autoModeConfiguration: FlyoutAutoConfiguration(
            preferredMode: FlyoutPlacementMode.topCenter,
          ),
          barrierDismissible: true,
          dismissOnPointerMoveAway: false,
          dismissWithEsc: true,
          builder: (context) {
            return MenuFlyout(
              items: [
                MenuFlyoutItem(
                  leading: const Icon(FluentIcons.sign_out),
                  text: const Text('Déconnexion'),
                  onPressed: () {
                    context.pop();
                    showDialog<String>(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => ContentDialog(
                        title: const Text('Déconnexion'),
                        content: const Text(
                            'Êtes-vous sûr de vouloir vous déconnecter ?'),
                        actions: [
                          FilledButton(
                            onPressed: () => context.pop(),
                            child: const Text('Non'),
                          ),
                          Button(
                            onPressed: () async {
                              context.pop();

                              context.goNamed(RoutesNames.authentication);
                            },
                            child: const Text('Oui'),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
