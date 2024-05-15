import 'package:bloc/bloc.dart';
import 'package:blocks/features/supplies/suppliers/domain/entities/supplier_entity.dart';
import 'package:blocks/features/supplies/suppliers/domain/usecases/fetch_suppliers_usecase.dart';
import 'package:equatable/equatable.dart';

part 'suppliers_event.dart';
part 'suppliers_state.dart';

class SuppliersBloc extends Bloc<SuppliersEvent, SuppliersState> {
  SuppliersBloc({required FetchSuppliersUsecase fetchSuppliersUsecase})
      : _fetchSuppliersUsecase = fetchSuppliersUsecase,
        super(SuppliersInitial()) {
    on<FetchSuppliersEvent>(onFetching);
    on<SupplierAddedEvent>(onSupplierAdded);
    on<SupplierUpdatedEvent>(onSupplierUpdated);
  }

  final FetchSuppliersUsecase _fetchSuppliersUsecase;

  Future<void> onSupplierAdded(
      SupplierAddedEvent event, Emitter<SuppliersState> emit) async {
    List<SupplierEntity> suppliers =
        List<SupplierEntity>.from(state.suppliers!);
    SupplierEntity supplier = event.supplier.copyWith();
    suppliers.add(supplier);
    emit(SuppliersFetchingDoneState(suppliers: suppliers));
  }

  Future<void> onSupplierUpdated(
      SupplierUpdatedEvent event, Emitter<SuppliersState> emit) async {
    List<SupplierEntity> suppliers =
        List<SupplierEntity>.from(state.suppliers!);
    final SupplierEntity supplier = event.supplier.copyWith();
    final int index =
        suppliers.indexWhere((element) => element.id == supplier.id);
    suppliers[index] = supplier;
    emit(SuppliersFetchingDoneState(suppliers: suppliers));
  }

  Future<void> onFetching(
      FetchSuppliersEvent event, Emitter<SuppliersState> emit) async {
    emit(SuppliersFetchingLoadingState());

    final result = await _fetchSuppliersUsecase();

    result.fold(
      (failure) {
        emit(SuppliersFetchingFailedState(message: failure.message));
      },
      (suppliers) {
        emit(
          SuppliersFetchingDoneState(suppliers: suppliers),
        );
      },
    );
  }
}
