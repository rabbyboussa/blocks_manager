import 'package:bloc/bloc.dart';
import 'package:blocks/features/distributions/distribution_creation/domain/entities/distribution_line_entity.dart';
import 'package:blocks/features/distributions/distribution_details/domain/usecases/get_distribution_details_usecase.dart';
import 'package:equatable/equatable.dart';

part 'distribution_details_event.dart';
part 'distribution_details_state.dart';

class DistributionDetailsBloc
    extends Bloc<DistributionDetailsEvent, DistributionDetailsState> {
  DistributionDetailsBloc(
      {required GetDistributionDetailsUsecase getDistributionDetailsUsecase})
      : _getDistributionDetailsUsecase = getDistributionDetailsUsecase,
        super(DistributionDetailsInitial()) {
    on<FetchDistributionDetailsEvent>(onFetching);
  }

  final GetDistributionDetailsUsecase _getDistributionDetailsUsecase;

  Future<void> onFetching(FetchDistributionDetailsEvent event,
      Emitter<DistributionDetailsState> emit) async {
    emit(DistributionDetailsFetchingLoadingState());

    final result = await _getDistributionDetailsUsecase(
        GetDistributionDetailsUsecaseParams(
            distributionId: event.distributionId));

    result.fold(
      (failure) {
        emit(DistributionDetailsFetchingFailedState(message: failure.message));
      },
      (lines) {
        emit(
          DistributionDetailsFetchingDoneState(lines: lines),
        );
      },
    );
  }
}
