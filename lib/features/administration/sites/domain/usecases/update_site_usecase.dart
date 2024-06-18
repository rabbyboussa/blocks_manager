import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/core/usecases/usecase.dart';
import 'package:blocks/features/administration/sites/domain/entities/site_entity.dart';
import 'package:blocks/features/administration/sites/domain/repositories/sites_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateSiteUsecase
    extends Usecase<ResultFutureVoid, UpdateSiteUsecaseParams> {
  const UpdateSiteUsecase({required SitesRepository repository})
      : _repository = repository;

  final SitesRepository _repository;

  @override
  ResultFutureVoid call(UpdateSiteUsecaseParams params) async =>
      _repository.updateSite(site: params.site);
}

class UpdateSiteUsecaseParams extends Equatable {
  const UpdateSiteUsecaseParams({required this.site});

  final SiteEntity site;

  @override
  List<SiteEntity> get props => [site];
}
