import 'package:blocks/core/presentation/bloc/image_picker/image_picker_bloc.dart';
import 'package:blocks/features/administration/accounts/data/data_sources/accounts_data_source.dart';
import 'package:blocks/features/administration/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:blocks/features/administration/accounts/domain/repositories/accounts_repository.dart';
import 'package:blocks/features/administration/accounts/domain/usecases/add_account_usecase.dart';
import 'package:blocks/features/administration/accounts/domain/usecases/fetch_accounts_usecase.dart';
import 'package:blocks/features/administration/accounts/domain/usecases/fetch_roles_usecase.dart';
import 'package:blocks/features/administration/accounts/domain/usecases/update_account_usecase.dart';
import 'package:blocks/features/administration/accounts/presentation/bloc/accounts/accounts_bloc.dart';
import 'package:blocks/features/administration/accounts/presentation/bloc/edit_account/edit_account_bloc.dart';
import 'package:blocks/features/administration/employees/data/data_sources/employees_data_source.dart';
import 'package:blocks/features/administration/employees/data/repositories/employees_repository_impl.dart';
import 'package:blocks/features/administration/employees/domain/repositories/employees_repository.dart';
import 'package:blocks/features/administration/employees/domain/usecases/add_employee_usecase.dart';
import 'package:blocks/features/administration/employees/domain/usecases/fetch_employees_usecase.dart';
import 'package:blocks/features/administration/employees/domain/usecases/update_employee_usecase.dart';
import 'package:blocks/features/administration/employees/presentation/bloc/edit_employee/edit_employee_bloc.dart';
import 'package:blocks/features/administration/employees/presentation/bloc/employees/employees_bloc.dart';
import 'package:blocks/features/administration/sites/data/data_sources/sites_data_source.dart';
import 'package:blocks/features/administration/sites/data/repositories/sites_repository_impl.dart';
import 'package:blocks/features/administration/sites/domain/repositories/sites_repository.dart';
import 'package:blocks/features/administration/sites/domain/usecases/add_site_usecase.dart';
import 'package:blocks/features/administration/sites/domain/usecases/fetch_countries_usecase.dart';
import 'package:blocks/features/administration/sites/domain/usecases/fetch_sites_usecase.dart';
import 'package:blocks/features/administration/sites/domain/usecases/update_site_usecase.dart';
import 'package:blocks/features/administration/sites/presentation/bloc/countries/countries_bloc.dart';
import 'package:blocks/features/administration/sites/presentation/bloc/edit_site/edit_site_bloc.dart';
import 'package:blocks/features/administration/sites/presentation/bloc/sites/sites_bloc.dart';
import 'package:blocks/features/authentication/data/data_sources/authentication_data_source.dart';
import 'package:blocks/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:blocks/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:blocks/features/authentication/domain/usecases/authenticate_usecase.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:blocks/features/distributions/clients/data/data_sources/clients_data_source.dart';
import 'package:blocks/features/distributions/clients/data/repositories/clients_repository_impl.dart';
import 'package:blocks/features/distributions/clients/domain/repositories/clients_repository.dart';
import 'package:blocks/features/distributions/clients/domain/usecases/add_client_usecase.dart';
import 'package:blocks/features/distributions/clients/domain/usecases/fetch_clients_usecase.dart';
import 'package:blocks/features/distributions/clients/domain/usecases/update_client_usecase.dart';
import 'package:blocks/features/distributions/clients/presentation/bloc/clients/clients_bloc.dart';
import 'package:blocks/features/distributions/clients/presentation/bloc/edit_client/edit_client_bloc.dart';
import 'package:blocks/features/distributions/distribution_creation/data/data_sources/distribution_creation_data_source.dart';
import 'package:blocks/features/distributions/distribution_creation/data/repositories/distribution_creation_repository_impl.dart';
import 'package:blocks/features/distributions/distribution_creation/domain/repository/distribution_creation_repository.dart';
import 'package:blocks/features/distributions/distribution_creation/domain/usecases/create_distribution_usecase.dart';
import 'package:blocks/features/distributions/distribution_creation/presentation/bloc/distribution_creation/distribution_creation_bloc.dart';
import 'package:blocks/features/distributions/distribution_creation/presentation/bloc/distribution_lines_data_grid/distribution_lines_data_grid_bloc.dart';
import 'package:blocks/features/distributions/distribution_details/data/data_sources/distribution_details_data_source.dart';
import 'package:blocks/features/distributions/distribution_details/data/repositories/distribution_details_repository_impl.dart';
import 'package:blocks/features/distributions/distribution_details/domain/repository/distribution_details_repository.dart';
import 'package:blocks/features/distributions/distribution_details/domain/usecases/get_distribution_details_usecase.dart';
import 'package:blocks/features/distributions/distribution_details/presentation/bloc/distribution_details/distribution_details_bloc.dart';
import 'package:blocks/features/distributions/distributions/data/data_sources/distributions_data_source.dart';
import 'package:blocks/features/distributions/distributions/data/repositories/distributions_repository_impl.dart';
import 'package:blocks/features/distributions/distributions/domain/repositories/distributions_repository.dart';
import 'package:blocks/features/distributions/distributions/domain/usecases/fetch_distributions_usecase.dart';
import 'package:blocks/features/distributions/distributions/presentation/bloc/distributions/distributions_bloc.dart';
import 'package:blocks/features/productions/production_creation/data/data_sources/production_creation_data_source.dart';
import 'package:blocks/features/productions/production_creation/data/repositories/production_creation_repository_impl.dart';
import 'package:blocks/features/productions/production_creation/domain/repository/production_creation_repository.dart';
import 'package:blocks/features/productions/production_creation/domain/usecases/create_production_usecase.dart';
import 'package:blocks/features/productions/production_creation/presentation/bloc/production_creation/production_creation_bloc.dart';
import 'package:blocks/features/productions/production_details/data/data_sources/production_details_data_source.dart';
import 'package:blocks/features/productions/production_details/data/repositories/production_details_repository_impl.dart';
import 'package:blocks/features/productions/production_details/domain/repository/production_details_repository.dart';
import 'package:blocks/features/productions/production_details/domain/usecases/get_production_lines_usecase%20copy.dart';
import 'package:blocks/features/productions/production_details/domain/usecases/get_production_materials_used_lines_usecase.dart';
import 'package:blocks/features/productions/production_details/presentation/bloc/production_details/production_details_bloc.dart';
import 'package:blocks/features/productions/productions/data/data_sources/productions_data_source.dart';
import 'package:blocks/features/productions/productions/data/repositories/productions_repository_impl.dart';
import 'package:blocks/features/productions/productions/domain/repositories/productions_repository.dart';
import 'package:blocks/features/productions/productions/domain/usecases/fetch_productions_usecase.dart';
import 'package:blocks/features/productions/productions/presentation/bloc/productions/productions_bloc.dart';
import 'package:blocks/features/productions/products/data/data_sources/products_data_source.dart';
import 'package:blocks/features/productions/products/data/repositories/products_repository_impl.dart';
import 'package:blocks/features/productions/products/domain/repositories/products_repository.dart';
import 'package:blocks/features/productions/products/domain/usecases/add_product_usecase.dart';
import 'package:blocks/features/productions/products/domain/usecases/fetch_products_usecase.dart';
import 'package:blocks/features/productions/products/domain/usecases/update_product_usecase.dart';
import 'package:blocks/features/productions/products/presentation/bloc/edit_product/edit_product_bloc.dart';
import 'package:blocks/features/productions/products/presentation/bloc/products/products_bloc.dart';
import 'package:blocks/features/supplies/materials/data/data_sources/materials_data_source.dart';
import 'package:blocks/features/supplies/materials/data/repositories/materials_repository_impl.dart';
import 'package:blocks/features/supplies/materials/domain/repositories/materials_repository.dart';
import 'package:blocks/features/supplies/materials/domain/usecases/add_material_usecase.dart';
import 'package:blocks/features/supplies/materials/domain/usecases/fetch_materials_usecase.dart';
import 'package:blocks/features/supplies/materials/domain/usecases/update_material_usecase.dart';
import 'package:blocks/features/supplies/materials/presentation/bloc/edit_material/edit_material_bloc.dart';
import 'package:blocks/features/supplies/materials/presentation/bloc/materials/materials_bloc.dart';
import 'package:blocks/features/supplies/suppliers/data/data_sources/suppliers_data_source.dart';
import 'package:blocks/features/supplies/suppliers/data/repositories/suppliers_repository_impl.dart';
import 'package:blocks/features/supplies/suppliers/domain/repositories/suppliers_repository.dart';
import 'package:blocks/features/supplies/suppliers/domain/usecases/add_supplier_usecase.dart';
import 'package:blocks/features/supplies/suppliers/domain/usecases/fetch_suppliers_usecase.dart';
import 'package:blocks/features/supplies/suppliers/domain/usecases/update_supplier_usecase.dart';
import 'package:blocks/features/supplies/suppliers/presentation/bloc/edit_supplier/edit_supplier_bloc.dart';
import 'package:blocks/features/supplies/suppliers/presentation/bloc/suppliers/suppliers_bloc.dart';
import 'package:blocks/features/supplies/supplies/data/data_sources/supplies_data_source.dart';
import 'package:blocks/features/supplies/supplies/data/repositories/supplies_repository_impl.dart';
import 'package:blocks/features/supplies/supplies/domain/repositories/supplies_repository.dart';
import 'package:blocks/features/supplies/supplies/domain/usecases/fetch_supplies_usecase.dart';
import 'package:blocks/features/supplies/supplies/presentation/bloc/suppliers/supplies_bloc.dart';
import 'package:blocks/features/supplies/supply_creation/data/data_sources/supply_creation_data_source.dart';
import 'package:blocks/features/supplies/supply_creation/data/repositories/supply_creation_repository_impl.dart';
import 'package:blocks/features/supplies/supply_creation/domain/repository/supply_creation_repository.dart';
import 'package:blocks/features/supplies/supply_creation/domain/usecases/create_supply_usecase.dart';
import 'package:blocks/features/supplies/supply_creation/presentation/bloc/supply_creation/supply_creation_bloc.dart';
import 'package:blocks/features/supplies/supply_creation/presentation/bloc/supply_lines_data_grid/supply_lines_data_grid_bloc.dart';
import 'package:blocks/features/supplies/supply_details/data/data_sources/supply_details_data_source.dart';
import 'package:blocks/features/supplies/supply_details/data/repositories/supply_details_repository_impl.dart';
import 'package:blocks/features/supplies/supply_details/domain/repository/supply_details_repository.dart';
import 'package:blocks/features/supplies/supply_details/domain/usecases/get_supply_details_usecase.dart';
import 'package:blocks/features/supplies/supply_details/presentation/bloc/supply_details/supply_details_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/productions/production_creation/presentation/bloc/materials_used_lines_data_grid/materials_used_lines_data_grid_bloc.dart';
import '../../features/productions/production_creation/presentation/bloc/production_lines_data_grid/production_lines_data_grid_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerFactory(() => ImagePickerBloc());
  sl.registerLazySingleton(() => Supabase.instance.client);

  sl
    ..registerFactory(() => AuthenticationBloc(
          authenticateUsecase: sl(),
          fetchEmployeesUsecase: sl(),
          fetchRolesUsecase: sl(),
        ))
    ..registerLazySingleton(() => AuthenticateUsecase(repository: sl()))
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton(() => AuthenticationDataSource(sl()));

  sl
    ..registerFactory(() => MaterialsBloc(fetchMaterialsUsecase: sl()))
    ..registerLazySingleton(() => FetchMaterialsUsecase(repository: sl()))
    ..registerLazySingleton(() => AddMaterialUsecase(repository: sl()))
    ..registerLazySingleton(() => UpdateMaterialUsecase(repository: sl()))
    ..registerLazySingleton<MaterialsRepository>(
        () => MaterialsRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton(() => MaterialsDataSource(sl()))
    ..registerLazySingleton(() => Dio(BaseOptions(
          contentType: 'application/json',
          validateStatus: (int? status) => status != null,
        )));

  sl
    ..registerFactory(() => SuppliesBloc(fetchSuppliesUsecase: sl()))
    ..registerLazySingleton(() => FetchSuppliesUsecase(repository: sl()))
    ..registerLazySingleton<SuppliesRepository>(
        () => SuppliesRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton(() => SuppliesDataSource(sl()));

  sl
    ..registerFactory(() => ProductionsBloc(fetchProductionsUsecase: sl()))
    ..registerLazySingleton(() => FetchProductsUsecase(repository: sl()))
    ..registerLazySingleton<ProductionsRepository>(
        () => ProductionsRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton(() => ProductionsDataSource(sl()));

  sl
    ..registerFactory(() => DistributionsBloc(fetchDistributionsUsecase: sl()))
    ..registerLazySingleton(() => FetchDistributionsUsecase(repository: sl()))
    ..registerLazySingleton<DistributionsRepository>(
        () => DistributionsRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton(() => DistributionsDataSource(sl()));

  sl
    ..registerFactory(() => ProductsBloc(fetchProductsUsecase: sl()))
    ..registerLazySingleton(() => FetchProductionsUsecase(repository: sl()))
    ..registerLazySingleton<ProductsRepository>(
        () => ProductsRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton(() => ProductsDataSource(sl()));

  sl
    ..registerFactory(() => EmployeesBloc(fetchEmployeesUsecase: sl()))
    ..registerLazySingleton(() => FetchEmployeesUsecase(repository: sl()))
    ..registerLazySingleton<EmployeesRepository>(
        () => EmployeesRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton(() => EmployeesDataSource(sl()));

  sl
    ..registerFactory(() => AccountsBloc(
        fetchEmployeesUsecase: sl(),
        fetchAccountsUsecase: sl(),
        fetchRolesUsecase: sl(),
        fetchClientsUsecase: sl()))
    ..registerLazySingleton(() => FetchAccountsUsecase(repository: sl()))
    ..registerLazySingleton(() => FetchRolesUsecase(repository: sl()))
    ..registerLazySingleton<AccountsRepository>(
        () => AccountsRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton(() => AccountsDataSource(sl()));

  sl
    ..registerFactory(() => SuppliersBloc(fetchSuppliersUsecase: sl()))
    ..registerLazySingleton(() => FetchSuppliersUsecase(repository: sl()))
    ..registerLazySingleton(() => AddSupplierUsecase(repository: sl()))
    ..registerLazySingleton(() => UpdateSupplierUsecase(repository: sl()))
    ..registerLazySingleton<SuppliersRepository>(
        () => SuppliersRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton(() => SuppliersDataSource(sl()));

  sl
    ..registerFactory(() => ClientsBloc(fetchClientsUsecase: sl()))
    ..registerLazySingleton(() => FetchClientsUsecase(repository: sl()))
    ..registerLazySingleton(() => AddClientUsecase(repository: sl()))
    ..registerLazySingleton(() => UpdateClientUsecase(repository: sl()))
    ..registerLazySingleton<ClientsRepository>(
        () => ClientsRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton(() => ClientsDataSource(sl()));

  sl.registerFactory(() => EditMaterialBloc(
        addMaterialsUsecase: sl(),
        updateMaterialUsecase: sl(),
      ));

  sl
    ..registerFactory(() => SupplyCreationBloc(
        fetchMaterialsUsecase: sl(),
        fetchSuppliersUsecase: sl(),
        createSupplyUsecase: sl()))
    ..registerLazySingleton(() => CreateSupplyUsecase(repository: sl()))
    ..registerLazySingleton<SupplyCreationRepository>(
        () => SupplyCreationRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton(() => SupplyCreationDataSource(sl()));

  sl
    ..registerFactory(() => DistributionCreationBloc(
        fetchProductsUsecase: sl(),
        fetchClientsUsecase: sl(),
        createDistributionUsecase: sl()))
    ..registerLazySingleton(() => CreateDistributionUsecase(repository: sl()))
    ..registerLazySingleton<DistributionCreationRepository>(
        () => DistributionCreationRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton(() => DistributionCreationDataSource(sl()));

  sl
    ..registerFactory(() => ProductionCreationBloc(
        fetchProductsUsecase: sl(),
        fetchMaterialsUsecase: sl(),
        createProductionUsecase: sl()))
    ..registerLazySingleton(() => CreateProductionUsecase(repository: sl()))
    ..registerLazySingleton<ProductionCreationRepository>(
        () => ProductionCreationRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton(() => ProductionCreationDataSource(sl()));

  sl
    ..registerFactory(() => SupplyDetailsBloc(getSupplyDetailsUsecase: sl()))
    ..registerLazySingleton(() => GetSupplyDetailsUsecase(repository: sl()))
    ..registerLazySingleton<SupplyDetailsRepository>(
        () => SupplyDetailsRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton(() => SupplyDetailsDataSource(sl()));

  sl
    ..registerFactory(() => ProductionDetailsBloc(
          getProductionMaterialsUsedLinesUsecase: sl(),
          getProductionLinesUsecase: sl(),
        ))
    ..registerLazySingleton(
        () => GetProductionMaterialsUsedLinesUsecase(repository: sl()))
    ..registerLazySingleton(() => GetProductionLinesUsecase(repository: sl()))
    ..registerLazySingleton<ProductionDetailsRepository>(
        () => ProductionDetailsRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton(() => ProductionDetailsDataSource(sl()));

  sl
    ..registerFactory(
        () => DistributionDetailsBloc(getDistributionDetailsUsecase: sl()))
    ..registerLazySingleton(
        () => GetDistributionDetailsUsecase(repository: sl()))
    ..registerLazySingleton<DistributionDetailsRepository>(
        () => DistributionDetailsRepositoryImpl(dataSource: sl()))
    ..registerLazySingleton(() => DistributionDetailsDataSource(sl()));

  sl.registerFactory(() => SupplyLinesDataGridBloc());
  sl.registerFactory(() => DistributionLinesDataGridBloc());
  sl.registerFactory(() => ProductionLinesDataGridBloc());
  sl.registerFactory(() => MaterialsUsedLinesDataGridBloc());

  sl
    ..registerFactory(() => EditProductBloc(
          addProductUsecase: sl(),
          updateProductUsecase: sl(),
        ))
    ..registerLazySingleton(() => AddProductUsecase(repository: sl()))
    ..registerLazySingleton(() => UpdateProductUsecase(repository: sl()));

  sl.registerFactory(() => EditSupplierBloc(
        addSupplierUsecase: sl(),
        updateSupplierUsecase: sl(),
      ));

  sl.registerFactory(() => EditClientBloc(
        addClientUsecase: sl(),
        updateClientUsecase: sl(),
      ));

  sl
    ..registerFactory(() => EditEmployeeBloc(
          addEmployeeUsecase: sl(),
          updateEmployeeUsecase: sl(),
        ))
    ..registerLazySingleton(() => AddEmployeeUsecase(repository: sl()))
    ..registerLazySingleton(() => UpdateEmployeeUsecase(repository: sl()));

  sl
    ..registerFactory(() => EditAccountBloc(
          addAccountUsecase: sl(),
          updateAccountUsecase: sl(),
        ))
    ..registerLazySingleton(() => AddAccountUsecase(repository: sl()))
    ..registerLazySingleton(() => UpdateAccountUsecase(repository: sl()));

  sl
    ..registerFactory(() => CountriesBloc(
          fetchCountriesUsecase: sl(),
        ))
    ..registerLazySingleton(() => FetchCountriesUsecase(repository: sl()))
    ..registerLazySingleton<SitesRepository>(
        () => SitesRepositoryImpl(dataSource: SitesDataSource(sl())));

  sl
    ..registerFactory(() => SitesBloc(
          fetchSitesUsecase: sl(),
        ))
    ..registerLazySingleton(() => FetchSitesUsecase(repository: sl()));

  sl
    ..registerFactory(() => EditSiteBloc(
          addSiteUsecase: sl(),
          updateSiteUsecase: sl(),
        ))
    ..registerLazySingleton(() => AddSiteUsecase(repository: sl()))
    ..registerLazySingleton(() => UpdateSiteUsecase(repository: sl()));
}
