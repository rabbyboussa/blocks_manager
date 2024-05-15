import 'package:bloc/bloc.dart';
import 'package:blocks/features/distributions/distributions/domain/entities/distribution_entity.dart';
import 'package:blocks/features/distributions/distributions/domain/usecases/fetch_distributions_usecase.dart';
import 'package:equatable/equatable.dart';

part 'distributions_event.dart';
part 'distributions_state.dart';

class DistributionsBloc extends Bloc<DistributionsEvent, DistributionsState> {
  DistributionsBloc(
      {required FetchDistributionsUsecase fetchDistributionsUsecase})
      : _fetchDistributionsUsecase = fetchDistributionsUsecase,
        super(DitributionsInitial()) {
    on<FetchDistributionsEvent>(onFetching);
  }

  final FetchDistributionsUsecase _fetchDistributionsUsecase;

  Future<void> onFetching(
      FetchDistributionsEvent event, Emitter<DistributionsState> emit) async {
    emit(DistributionsFetchingLoadingState());

    final result = await _fetchDistributionsUsecase();

    result.fold(
      (failure) {
        emit(DistributionsFetchingFailedState(message: failure.message));
      },
      (distributions) {
        emit(
          DistributionsFetchingDoneState(distributions: distributions),
        );
      },
    );
  }
}
