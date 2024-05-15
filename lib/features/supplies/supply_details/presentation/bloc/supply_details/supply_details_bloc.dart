import 'package:bloc/bloc.dart';
import 'package:blocks/features/supplies/supply_creation/domain/entities/supply_line_entity.dart';
import 'package:blocks/features/supplies/supply_details/domain/usecases/get_supply_details_usecase.dart';
import 'package:equatable/equatable.dart';

part 'supply_details_event.dart';
part 'supply_details_state.dart';

class SupplyDetailsBloc extends Bloc<SupplyDetailsEvent, SupplyDetailsState> {
  SupplyDetailsBloc({required GetSupplyDetailsUsecase getSupplyDetailsUsecase})
      : _getSupplyDetailsUsecase = getSupplyDetailsUsecase,
        super(ProductsInitial()) {
    on<FetchSupplyDetailsEvent>(onFetching);
  }

  final GetSupplyDetailsUsecase _getSupplyDetailsUsecase;

  Future<void> onFetching(
      FetchSupplyDetailsEvent event, Emitter<SupplyDetailsState> emit) async {
    emit(SupplyDetailsFetchingLoadingState());

    final result = await _getSupplyDetailsUsecase(
        GetSupplyDetailsUsecaseParams(supplyId: event.supplyId));

    result.fold(
      (failure) {
        emit(SupplyDetailsFetchingFailedState(message: failure.message));
      },
      (lines) {
        emit(
          SupplyDetailsFetchingDoneState(lines: lines),
        );
      },
    );
  }
}
