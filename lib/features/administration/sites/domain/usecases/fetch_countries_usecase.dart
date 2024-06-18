import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/administration/sites/domain/entities/country_entity.dart';
import 'package:blocks/features/administration/sites/domain/repositories/sites_repository.dart';

class FetchCountriesUsecase
    extends UsecaseWithoutParams<ResultFuture<List<CountryEntity>>> {
  const FetchCountriesUsecase({required SitesRepository repository})
      : _repository = repository;

  final SitesRepository _repository;

  @override
  ResultFuture<List<CountryEntity>> call() async =>
      _repository.fetchCountries();
}
