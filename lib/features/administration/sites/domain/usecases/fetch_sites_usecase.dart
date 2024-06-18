import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/administration/sites/domain/entities/site_entity.dart';
import 'package:blocks/features/administration/sites/domain/repositories/sites_repository.dart';

class FetchSitesUsecase
    extends UsecaseWithoutParams<ResultFuture<List<SiteEntity>>> {
  const FetchSitesUsecase({required SitesRepository repository})
      : _repository = repository;

  final SitesRepository _repository;

  @override
  ResultFuture<List<SiteEntity>> call() async => _repository.fetchSites();
}
