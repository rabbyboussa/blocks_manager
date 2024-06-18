import 'package:blocks/features/administration/accounts/presentation/page/accounts_page.dart';
import 'package:blocks/features/administration/employees/presentation/page/employees_page.dart';
import 'package:blocks/features/administration/sites/presentation/page/sites_page.dart';
import 'package:blocks/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:blocks/features/distributions/clients/presentation/page/clients_page.dart';
import 'package:blocks/features/distributions/distributions/presentation/page/distributions_page.dart';
import 'package:blocks/features/productions/productions/presentation/page/productions_page.dart';
import 'package:blocks/features/productions/products/presentation/page/products_page.dart';
import 'package:blocks/features/supplies/materials/presentation/page/materials_page.dart';
import 'package:blocks/features/supplies/suppliers/presentation/page/suppliers_page.dart';
import 'package:blocks/features/supplies/supplies/presentation/page/supplies_page.dart';
import 'package:fluent_ui/fluent_ui.dart';

final List<NavigationPaneItem> productorMenuItems = [
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

final List<NavigationPaneItem> distributorMenuItems = [
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

final List<NavigationPaneItem> supervisorMenuItems = [
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

final List<NavigationPaneItem> administratorMenuItems = [
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

final List<NavigationPaneItem> superadminMenuItems = [
  PaneItem(
    icon: const Icon(FluentIcons.processing),
    title: const Text('Sites de productions'),
    body: const SitesPage(),
  ),
  // PaneItemExpander(
  //   icon: const Icon(FluentIcons.delivery_truck),
  //   title: const Text('Approvisionnements'),
  //   initiallyExpanded: true,
  //   body: const SuppliesPage(),
  //   items: [
  //     PaneItem(
  //       icon: const SizedBox(),
  //       title: const Text('Tous les approvisionnements'),
  //       body: const SuppliesPage(),
  //     ),
  //     PaneItem(
  //       icon: const SizedBox(),
  //       title: const Text('Matériaux'),
  //       body: const MaterialsPage(),
  //     ),
  //     PaneItem(
  //       icon: const SizedBox(),
  //       title: const Text('Fournisseurs'),
  //       body: const SuppliersPage(),
  //     ),
  //   ],
  // ),
  // PaneItemExpander(
  //   icon: const Icon(FluentIcons.product_variant),
  //   title: const Text('Productions'),
  //   initiallyExpanded: true,
  //   body: const ProductionsPage(),
  //   items: [
  //     PaneItem(
  //       icon: const SizedBox(),
  //       title: const Text('Toutes les productions'),
  //       body: const ProductionsPage(),
  //     ),
  //     PaneItem(
  //       icon: const SizedBox(),
  //       title: const Text('Produits'),
  //       body: const ProductsPage(),
  //     ),
  //   ],
  // ),
  // PaneItemExpander(
  //   icon: const Icon(FluentIcons.bill),
  //   title: const Text('Distributions'),
  //   initiallyExpanded: true,
  //   body: const SizedBox(),
  //   items: [
  //     PaneItem(
  //       icon: const SizedBox(),
  //       title: const Text('Toutes les distributions'),
  //       body: const DistributionsPage(),
  //     ),
  //     PaneItem(
  //       icon: const SizedBox(),
  //       title: const Text('Clients'),
  //       body: const ClientsPage(),
  //     ),
  //   ],
  // ),
  // PaneItemExpander(
  //   icon: const Icon(FluentIcons.people),
  //   title: const Text('Admininstration'),
  //   initiallyExpanded: true,
  //   body: const EmployeesPage(),
  //   items: [
  //     PaneItem(
  //       icon: const SizedBox(),
  //       title: const Text('Employés'),
  //       body: const EmployeesPage(),
  //     ),
  //     PaneItem(
  //       icon: const SizedBox(),
  //       title: const Text('Comptes utilisateurs'),
  //       body: const AccountsPage(),
  //     ),
  //     PaneItem(
  //       icon: const SizedBox(),
  //       title: const Text('Sites de productions'),
  //       body: const SitesPage(),
  //     ),
  //   ],
  // ),
];

enum Roles {
  producteur,
  distributeur,
  superviseur,
  administrateur,
  superadmin,
}

Map<String, List<NavigationPaneItem>> menu = <String, List<NavigationPaneItem>>{
  Roles.producteur.name: productorMenuItems,
  Roles.distributeur.name: distributorMenuItems,
  Roles.superviseur.name: supervisorMenuItems,
  Roles.administrateur.name: administratorMenuItems,
  Roles.superadmin.name: superadminMenuItems,
};
