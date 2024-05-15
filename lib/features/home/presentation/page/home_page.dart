import 'package:blocks/config/routes/routes_names.dart';
import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/administration/accounts/domain/entities/role_entity.dart';
import 'package:blocks/features/administration/accounts/presentation/page/accounts_page.dart';
import 'package:blocks/features/administration/employees/domain/entities/employee_entity.dart';
import 'package:blocks/features/administration/employees/presentation/page/employees_page.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:blocks/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:blocks/features/distributions/clients/presentation/page/clients_page.dart';
import 'package:blocks/features/distributions/distributions/presentation/page/distributions_page.dart';
import 'package:blocks/features/productions/productions/presentation/page/productions_page.dart';
import 'package:blocks/features/productions/products/presentation/page/products_page.dart';
import 'package:blocks/features/supplies/materials/presentation/page/materials_page.dart';
import 'package:blocks/features/supplies/suppliers/presentation/page/suppliers_page.dart';
import 'package:blocks/features/supplies/supplies/presentation/page/supplies_page.dart';
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

  final List<NavigationPaneItem> _productorItems = [
    PaneItemExpander(
      icon: const Icon(FluentIcons.delivery_truck),
      title: const Text('Approvisionnements'),
      initiallyExpanded: true,
      body: const SuppliesPage(),
      items: [
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Tous les approvisionnements'),
          body: const SuppliesPage(),
        ),
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Matériaux'),
          body: const MaterialsPage(),
        ),
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Fournisseurs'),
          body: const SuppliersPage(),
        ),
      ],
    ),
    PaneItemExpander(
      icon: const Icon(FluentIcons.product_variant),
      title: const Text('Productions'),
      initiallyExpanded: true,
      body: const ProductionsPage(),
      items: [
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Toutes les productions'),
          body: const ProductionsPage(),
        ),
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Produits'),
          body: const ProductsPage(),
        ),
      ],
    ),
  ];

  final List<NavigationPaneItem> _distributorItems = [
    PaneItem(
      icon: const SizedBox(),
      title: const Text('Produits'),
      body: const ProductsPage(),
    ),
    PaneItemExpander(
      icon: const Icon(FluentIcons.bill),
      title: const Text('Distributions'),
      initiallyExpanded: true,
      body: const SizedBox(),
      items: [
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Toutes les distributions'),
          body: const DistributionsPage(),
        ),
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Clients'),
          body: const ClientsPage(),
        ),
      ],
    ),
  ];

  final List<NavigationPaneItem> _supervisorItems = [
    PaneItem(
      icon: const Icon(FluentIcons.b_i_dashboard),
      title: const Text('Tableau de bord'),
      body: const DashboardPage(),
    ),
    PaneItemExpander(
      icon: const Icon(FluentIcons.delivery_truck),
      title: const Text('Approvisionnements'),
      initiallyExpanded: true,
      body: const SuppliesPage(),
      items: [
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Tous les approvisionnements'),
          body: const SuppliesPage(),
        ),
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Matériaux'),
          body: const MaterialsPage(),
        ),
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Fournisseurs'),
          body: const SuppliersPage(),
        ),
      ],
    ),
    PaneItemExpander(
      icon: const Icon(FluentIcons.product_variant),
      title: const Text('Productions'),
      initiallyExpanded: true,
      body: const ProductionsPage(),
      items: [
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Toutes les productions'),
          body: const ProductionsPage(),
        ),
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Produits'),
          body: const ProductsPage(),
        ),
      ],
    ),
    PaneItemExpander(
      icon: const Icon(FluentIcons.bill),
      title: const Text('Distributions'),
      initiallyExpanded: true,
      body: const DistributionsPage(),
      items: [
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Toutes les distributions'),
          body: const DistributionsPage(),
        ),
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Clients'),
          body: const ClientsPage(),
        ),
      ],
    ),
  ];

  final List<NavigationPaneItem> _administratorItems = [
    PaneItem(
      icon: const Icon(FluentIcons.b_i_dashboard),
      title: const Text('Tableau de bord'),
      body: const DashboardPage(),
    ),
    PaneItemExpander(
      icon: const Icon(FluentIcons.delivery_truck),
      title: const Text('Approvisionnements'),
      initiallyExpanded: true,
      body: const SuppliesPage(),
      items: [
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Tous les approvisionnements'),
          body: const SuppliesPage(),
        ),
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Matériaux'),
          body: const MaterialsPage(),
        ),
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Fournisseurs'),
          body: const SuppliersPage(),
        ),
      ],
    ),
    PaneItemExpander(
      icon: const Icon(FluentIcons.product_variant),
      title: const Text('Productions'),
      initiallyExpanded: true,
      body: const ProductionsPage(),
      items: [
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Toutes les productions'),
          body: const ProductionsPage(),
        ),
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Produits'),
          body: const ProductsPage(),
        ),
      ],
    ),
    PaneItemExpander(
      icon: const Icon(FluentIcons.bill),
      title: const Text('Distributions'),
      initiallyExpanded: true,
      body: const SizedBox(),
      items: [
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Toutes les distributions'),
          body: const DistributionsPage(),
        ),
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Clients'),
          body: const ClientsPage(),
        ),
      ],
    ),
    PaneItemExpander(
      icon: const Icon(FluentIcons.people),
      title: const Text('Admininstration'),
      initiallyExpanded: true,
      body: const EmployeesPage(),
      items: [
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Employés'),
          body: const EmployeesPage(),
        ),
        PaneItem(
          icon: const SizedBox(),
          title: const Text('Comptes utilisateurs'),
          body: const AccountsPage(),
        ),
      ],
    ),
  ];

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
                  items: role.name == 'Producteur'
                      ? _productorItems
                      : role.name == 'Distributeur'
                          ? _distributorItems
                          : role.name == 'Superviseur'
                              ? _supervisorItems
                              : _administratorItems,
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
