import 'package:bloc/bloc.dart';
import 'package:blocks/features/productions/productions/domain/entities/production_entity.dart';
import 'package:blocks/features/productions/productions/domain/usecases/fetch_productions_usecase.dart';
import 'package:equatable/equatable.dart';

part 'productions_event.dart';
part 'productions_state.dart';

class ProductionsBloc extends Bloc<ProductionsEvent, ProductionsState> {
  ProductionsBloc({required FetchProductionsUsecase fetchProductionsUsecase})
      : _fetchProductionsUsecase = fetchProductionsUsecase,
        super(ProductionsInitial()) {
    on<FetchProductionsEvent>(onFetching);
  }

  final FetchProductionsUsecase _fetchProductionsUsecase;

  Future<void> onFetching(
      FetchProductionsEvent event, Emitter<ProductionsState> emit) async {
    emit(ProductionsFetchingLoadingState());

    final result = await _fetchProductionsUsecase();

    result.fold(
      (failure) {
        emit(ProductionsFetchingFailedState(message: failure.message));
      },
      (productions) {
        emit(
          ProductionsFetchingDoneState(productions: productions),
        );
      },
    );
  }
}
