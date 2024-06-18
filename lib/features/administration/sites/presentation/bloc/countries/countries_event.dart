part of 'countries_bloc.dart';

sealed class CountriesEvent extends Equatable {
  const CountriesEvent();

  @override
  List<Object> get props => [];
}

final class FetchCountriesEvent extends CountriesEvent {}
