import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/administration/sites/domain/entities/site_entity.dart';
import 'package:blocks/features/administration/sites/domain/repositories/sites_repository.dart';
import 'package:equatable/equatable.dart';

class AddSiteUsecase
    extends Usecase<ResultFuture<SiteEntity>, AddSiteUsecaseParams> {
  const AddSiteUsecase({required SitesRepository repository})
      : _repository = repository;

  final SitesRepository _repository;

  @override
  ResultFuture<SiteEntity> call(AddSiteUsecaseParams params) async =>
      _repository.addSite(site: params.site);
}

class AddSiteUsecaseParams extends Equatable {
  const AddSiteUsecaseParams({required this.site});

  final SiteEntity site;

  @override
  List<SiteEntity> get props => [site];
}
