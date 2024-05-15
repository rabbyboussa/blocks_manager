import 'package:blocks/config/routes/routes.dart';
import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/bloc/image_picker/image_picker_bloc.dart';
import 'package:blocks/core/services/injection_container.dart';
import 'package:blocks/features/administration/accounts/presentation/bloc/accounts/accounts_bloc.dart';
import 'package:blocks/features/administration/accounts/presentation/bloc/edit_account/edit_account_bloc.dart';
import 'package:blocks/features/administration/employees/presentation/bloc/edit_employee/edit_employee_bloc.dart';
import 'package:blocks/features/administration/employees/presentation/bloc/employees/employees_bloc.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:blocks/features/distributions/clients/presentation/bloc/clients/clients_bloc.dart';
import 'package:blocks/features/distributions/clients/presentation/bloc/edit_client/edit_client_bloc.dart';
import 'package:blocks/features/distributions/distribution_creation/presentation/bloc/distribution_creation/distribution_creation_bloc.dart';
import 'package:blocks/features/distributions/distribution_creation/presentation/bloc/distribution_lines_data_grid/distribution_lines_data_grid_bloc.dart';
import 'package:blocks/features/distributions/distribution_details/presentation/bloc/distribution_details/distribution_details_bloc.dart';
import 'package:blocks/features/distributions/distributions/presentation/bloc/distributions/distributions_bloc.dart';
import 'package:blocks/features/productions/production_creation/presentation/bloc/materials_used_lines_data_grid/materials_used_lines_data_grid_bloc.dart';
import 'package:blocks/features/productions/production_creation/presentation/bloc/production_creation/production_creation_bloc.dart';
import 'package:blocks/features/productions/production_details/presentation/bloc/production_details/production_details_bloc.dart';
import 'package:blocks/features/productions/productions/presentation/bloc/productions/productions_bloc.dart';
import 'package:blocks/features/productions/products/presentation/bloc/edit_product/edit_product_bloc.dart';
import 'package:blocks/features/productions/products/presentation/bloc/products/products_bloc.dart';
import 'package:blocks/features/supplies/materials/presentation/bloc/edit_material/edit_material_bloc.dart';
import 'package:blocks/features/supplies/materials/presentation/bloc/materials/materials_bloc.dart';
import 'package:blocks/features/supplies/suppliers/presentation/bloc/edit_supplier/edit_supplier_bloc.dart';
import 'package:blocks/features/supplies/suppliers/presentation/bloc/suppliers/suppliers_bloc.dart';
import 'package:blocks/features/supplies/supplies/presentation/bloc/suppliers/supplies_bloc.dart';
import 'package:blocks/features/supplies/supply_creation/presentation/bloc/supply_creation/supply_creation_bloc.dart';
import 'package:blocks/features/supplies/supply_creation/presentation/bloc/supply_lines_data_grid/supply_lines_data_grid_bloc.dart';
import 'package:blocks/features/supplies/supply_details/presentation/bloc/supply_details/supply_details_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/productions/production_creation/presentation/bloc/production_lines_data_grid/production_lines_data_grid_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseURL,
    anonKey: supabaseKey,
  );

  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (context) => sl<AuthenticationBloc>()),
        BlocProvider<ImagePickerBloc>(
            create: (context) => sl<ImagePickerBloc>()),
        BlocProvider<EmployeesBloc>(create: (context) => sl<EmployeesBloc>()),
        BlocProvider<AccountsBloc>(create: (context) => sl<AccountsBloc>()),
        BlocProvider<MaterialsBloc>(create: (context) => sl<MaterialsBloc>()),
        BlocProvider<SuppliesBloc>(create: (context) => sl<SuppliesBloc>()),
        BlocProvider<ProductionsBloc>(
            create: (context) => sl<ProductionsBloc>()),
        BlocProvider<DistributionsBloc>(
            create: (context) => sl<DistributionsBloc>()),
        BlocProvider<SupplyCreationBloc>(
            create: (context) => sl<SupplyCreationBloc>()),
        BlocProvider<ProductionCreationBloc>(
            create: (context) => sl<ProductionCreationBloc>()),
        BlocProvider<DistributionCreationBloc>(
            create: (context) => sl<DistributionCreationBloc>()),
        BlocProvider<SupplyDetailsBloc>(
            create: (context) => sl<SupplyDetailsBloc>()),
        BlocProvider<ProductionDetailsBloc>(
            create: (context) => sl<ProductionDetailsBloc>()),
        BlocProvider<DistributionDetailsBloc>(
            create: (context) => sl<DistributionDetailsBloc>()),
        BlocProvider<SupplyLinesDataGridBloc>(
            create: (context) => sl<SupplyLinesDataGridBloc>()),
        BlocProvider<DistributionLinesDataGridBloc>(
            create: (context) => sl<DistributionLinesDataGridBloc>()),
        BlocProvider<ProductionLinesDataGridBloc>(
            create: (context) => sl<ProductionLinesDataGridBloc>()),
        BlocProvider<MaterialsUsedLinesDataGridBloc>(
            create: (context) => sl<MaterialsUsedLinesDataGridBloc>()),
        BlocProvider<ProductsBloc>(create: (context) => sl<ProductsBloc>()),
        BlocProvider<SuppliersBloc>(create: (context) => sl<SuppliersBloc>()),
        BlocProvider<ClientsBloc>(create: (context) => sl<ClientsBloc>()),
        BlocProvider<EditMaterialBloc>(
            create: (context) => sl<EditMaterialBloc>()),
        BlocProvider<EditProductBloc>(
            create: (context) => sl<EditProductBloc>()),
        BlocProvider<EditSupplierBloc>(
            create: (context) => sl<EditSupplierBloc>()),
        BlocProvider<EditClientBloc>(create: (context) => sl<EditClientBloc>()),
        BlocProvider<EditEmployeeBloc>(
            create: (context) => sl<EditEmployeeBloc>()),
        BlocProvider<EditAccountBloc>(
            create: (context) => sl<EditAccountBloc>()),
      ],
      child: FluentApp.router(
        title: 'Blocks',
        debugShowCheckedModeBanner: false,
        theme: FluentThemeData(
          accentColor: kBrown.toAccentColor(),
          dialogTheme: const ContentDialogThemeData(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.zero),
                  color: Colors.white)),
          navigationPaneTheme: const NavigationPaneThemeData(
            backgroundColor: Color.fromARGB(255, 249, 241, 232),
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 252, 248, 244),
        ),
        routerConfig: router,
      ),
    );
  }
}
