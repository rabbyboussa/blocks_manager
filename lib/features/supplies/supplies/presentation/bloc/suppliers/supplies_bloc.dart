import 'package:bloc/bloc.dart';
import 'package:blocks/features/supplies/supplies/domain/entities/supply_entity.dart';
import 'package:blocks/features/supplies/supplies/domain/usecases/fetch_supplies_usecase.dart';
import 'package:equatable/equatable.dart';

part 'supplies_event.dart';
part 'supplies_state.dart';

class SuppliesBloc extends Bloc<SuppliesEvent, SuppliesState> {
  SuppliesBloc({required FetchSuppliesUsecase fetchSuppliesUsecase})
      : _fetchSuppliesUsecase = fetchSuppliesUsecase,
        super(ProductsInitial()) {
    on<FetchSuppliesEvent>(onFetching);
    on<SupplyAddedEvent>(onSupplyAdded);
    on<SupplyUpdatedEvent>(onSupplyUpdated);
  }

  final FetchSuppliesUsecase _fetchSuppliesUsecase;

  Future<void> onSupplyAdded(
      SupplyAddedEvent event, Emitter<SuppliesState> emit) async {
    List<SupplyEntity> supplies = List<SupplyEntity>.from(state.supplies!);
    SupplyEntity supply = event.supply.copyWith();
    supplies.add(supply);
    emit(SuppliesFetchingDoneState(supplies: supplies));
  }

  Future<void> onSupplyUpdated(
      SupplyUpdatedEvent event, Emitter<SuppliesState> emit) async {
    List<SupplyEntity> supplies = List<SupplyEntity>.from(state.supplies!);
    final SupplyEntity supply = event.supply.copyWith();
    final int index = supplies.indexWhere((element) => element.id == supply.id);
    supplies[index] = supply;
    emit(SuppliesFetchingDoneState(supplies: supplies));
  }

  Future<void> onFetching(
      FetchSuppliesEvent event, Emitter<SuppliesState> emit) async {
    emit(SuppliesFetchingLoadingState());

    final result = await _fetchSuppliesUsecase();

    result.fold(
      (failure) {
        emit(SuppliesFetchingFailedState(message: failure.message));
      },
      (supplies) {
        supplies.retainWhere((element) => element.siteId == event.siteId);

        emit(
          SuppliesFetchingDoneState(supplies: supplies),
        );
      },
    );
  }
}
