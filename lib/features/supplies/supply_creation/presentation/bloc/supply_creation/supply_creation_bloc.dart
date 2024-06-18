import 'package:bloc/bloc.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:blocks/features/supplies/materials/domain/usecases/fetch_materials_usecase.dart';
import 'package:blocks/features/supplies/suppliers/domain/entities/supplier_entity.dart';
import 'package:blocks/features/supplies/suppliers/domain/usecases/fetch_suppliers_usecase.dart';
import 'package:blocks/features/supplies/supply_creation/domain/entities/supply_line_entity.dart';
import 'package:blocks/features/supplies/supply_creation/domain/usecases/create_supply_usecase.dart';
import 'package:equatable/equatable.dart';

part 'supply_creation_event.dart';
part 'supply_creation_state.dart';

class SupplyCreationBloc
    extends Bloc<SupplyCreationEvent, SupplyCreationState> {
  SupplyCreationBloc({
    required FetchMaterialsUsecase fetchMaterialsUsecase,
    required FetchSuppliersUsecase fetchSuppliersUsecase,
    required CreateSupplyUsecase createSupplyUsecase,
  })  : _fetchMaterialsUsecase = fetchMaterialsUsecase,
        _fetchSuppliersUsecase = fetchSuppliersUsecase,
        _createSupplyUsecase = createSupplyUsecase,
        super(SupplyCreationInitial()) {
    on<FetchDataEvent>(onDataFetching);
    on<CreateSupplyEvent>(onSupplyCreation);
  }

  final FetchMaterialsUsecase _fetchMaterialsUsecase;
  final FetchSuppliersUsecase _fetchSuppliersUsecase;

  final CreateSupplyUsecase _createSupplyUsecase;

  Future<void> onSupplyCreation(
      CreateSupplyEvent event, Emitter<SupplyCreationState> emit) async {
    emit(const SupplyCreationLoadingState());

    final result = await _createSupplyUsecase(CreateSupplyUsecaseParams(
      siteId: event.siteId,
      reference: event.reference,
      supplierId: event.supplierId,
      creationDate: event.creationDate,
      accountId: event.accountId,
      materials: event.materials,
      lines: event.lines,
    ));

    result.fold(
        (failure) => emit(SupplyCreationFailedState(message: failure.message)),
        (_) => emit(const SupplyCreationDoneState()));
  }

  Future<void> onDataFetching(
      FetchDataEvent event, Emitter<SupplyCreationState> emit) async {
    emit(DataFetchingLoadingState());

    bool errorOccured = false;
    String errorMessage = '';

    List<MaterialEntity> materials = [];
    List<SupplierEntity> suppliers = [];

    await _fetchMaterialsUsecase().then(
      (materialsResult) => materialsResult.fold(
        (failure) {
          errorOccured = true;
          errorMessage = failure.message;
        },
        (materialsFetched) async {
          materials = materialsFetched;
          materials.retainWhere((element) => element.siteId == event.siteId);
          await _fetchSuppliersUsecase().then(
            (suppliersResult) => suppliersResult.fold(
              (failure) {
                errorOccured = true;
                errorMessage = failure.message;
              },
              (suppliersFetched) async {
                suppliers = suppliersFetched;
                suppliers.retainWhere((element) => element.siteId == event.siteId);
              },
            ),
          );
        },
      ),
    );

    if (errorOccured) {
      emit(DataFetchingFailedState(message: errorMessage));
    } else {
      emit(DataFetchingDoneState(
        materials: materials,
        suppliers: suppliers,
      ));
    }
  }
}
