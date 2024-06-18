part of 'countries_bloc.dart';

sealed class CountriesState extends Equatable {
  const CountriesState({
    this.countries,
    this.message,
  });

  final List<CountryEntity>? countries;
  final String? message;

  @override
  List<Object?> get props => [
        countries,
        message,
      ];
}

final class CountriesInitial extends CountriesState {}

final class CountriesFetchingLoadingState extends CountriesState {}

final class CountriesFetchingFailedState extends CountriesState {
  const CountriesFetchingFailedState({required String message})
      : super(message: message);
}

final class CountriesFetchingDoneState extends CountriesState {
  const CountriesFetchingDoneState({
    required List<CountryEntity> countries,
  }) : super(countries: countries);
}
