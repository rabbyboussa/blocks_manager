import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/administration/sites/domain/entities/country_entity.dart';
import 'package:blocks/features/administration/sites/domain/entities/site_entity.dart';

abstract class SitesRepository {
  const SitesRepository();

  ResultFuture<List<CountryEntity>> fetchCountries();
  ResultFuture<List<SiteEntity>> fetchSites();

  ResultFuture<SiteEntity> addSite({required SiteEntity site});

  ResultFutureVoid updateSite({required SiteEntity site});
}
