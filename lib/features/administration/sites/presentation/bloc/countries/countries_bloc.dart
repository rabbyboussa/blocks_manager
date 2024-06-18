import 'package:bloc/bloc.dart';
import 'package:blocks/features/administration/sites/domain/entities/country_entity.dart';
import 'package:blocks/features/administration/sites/domain/usecases/fetch_countries_usecase.dart';
import 'package:equatable/equatable.dart';

part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  CountriesBloc({required FetchCountriesUsecase fetchCountriesUsecase})
      : _fetchCountriesUsecase = fetchCountriesUsecase,
        super(CountriesInitial()) {
    on<FetchCountriesEvent>(onFetching);
  }

  final FetchCountriesUsecase _fetchCountriesUsecase;

  Future<void> onFetching(
      FetchCountriesEvent event, Emitter<CountriesState> emit) async {
    emit(CountriesFetchingLoadingState());

    final result = await _fetchCountriesUsecase();

    result.fold(
      (failure) {
        emit(CountriesFetchingFailedState(message: failure.message));
      },
      (countries) {
        emit(
          CountriesFetchingDoneState(countries: countries),
        );
      },
    );
  }
}
