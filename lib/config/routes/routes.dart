import 'package:blocks/config/routes/routes_names.dart';
import 'package:blocks/features/authentication/presentation/pages/authentication_page.dart';
import 'package:blocks/features/distributions/distribution_creation/presentation/page/distribution_creation_page.dart';
import 'package:blocks/features/distributions/distribution_details/presentation/page/distribution_details_page.dart';
import 'package:blocks/features/distributions/distributions/domain/entities/distribution_entity.dart';
import 'package:blocks/features/home/presentation/page/home_page.dart';
import 'package:blocks/features/productions/production_creation/presentation/page/production_creation_page.dart';
import 'package:blocks/features/productions/production_details/presentation/page/production_details_page.dart';
import 'package:blocks/features/productions/productions/domain/entities/production_entity.dart';
import 'package:blocks/features/supplies/supplies/domain/entities/supply_entity.dart';
import 'package:blocks/features/supplies/supply_creation/presentation/page/supply_creation_page.dart';
import 'package:blocks/features/supplies/supply_details/presentation/page/supply_details_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: RoutesNames.authentication,
      path: '/',
      builder: (context, state) {
        return const AuthenticationPage();
      },
    ),
    GoRoute(
        name: RoutesNames.home,
        path: '/home',
        builder: (context, state) {
          return const HomePage();
        },
        routes: [
          GoRoute(
            name: RoutesNames.supplyCreation,
            path: 'supply_creation',
            builder: (context, state) {
              return const SupplyCreationPage();
            },
          ),
          GoRoute(
            name: RoutesNames.distributionCreation,
            path: 'distribution_creation',
            builder: (context, state) {
              return const DistributionCreationPage();
            },
          ),
          GoRoute(
            name: RoutesNames.productionCreation,
            path: 'production_creation',
            builder: (context, state) {
              return const ProductionCreationPage();
            },
          ),
          GoRoute(
            name: RoutesNames.supplyDetails,
            path: 'supply_details',
            builder: (context, state) {
              final SupplyEntity supply = state.extra as SupplyEntity;
              return SupplyDetailsPage(supply: supply);
            },
          ),
          GoRoute(
            name: RoutesNames.productionDetails,
            path: 'production_details',
            builder: (context, state) {
              final ProductionEntity production =
                  state.extra as ProductionEntity;
              return ProductionDetailsPage(production: production);
            },
          ),
          GoRoute(
            name: RoutesNames.distributionDetails,
            path: 'distribution_details',
            builder: (context, state) {
              final DistributionEntity distribution =
                  state.extra as DistributionEntity;
              return DistributionDetailsPage(distribution: distribution);
            },
          ),
        ]),
  ],
);
