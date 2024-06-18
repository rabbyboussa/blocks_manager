import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/administration/sites/data/data_sources/sites_data_source.dart';
import 'package:blocks/features/administration/sites/data/models/country_model.dart';
import 'package:blocks/features/administration/sites/data/models/site_model.dart';
import 'package:blocks/features/administration/sites/domain/entities/site_entity.dart';
import 'package:blocks/features/administration/sites/domain/repositories/sites_repository.dart';
import 'package:dartz/dartz.dart';

class SitesRepositoryImpl implements SitesRepository {
  SitesRepositoryImpl({required SitesDataSource dataSource})
      : _dataSource = dataSource;

  final SitesDataSource _dataSource;

  @override
  ResultFuture<List<SiteModel>> fetchSites() async {
    try {
      final httpResponse = await _dataSource.fetchSites();

      if (httpResponse.response.statusCode == 200) {
        return Right(httpResponse.data);
      } else {
        throw ApiException(
          statusCode: httpResponse.response.statusCode!,
          message: httpResponse.response.statusMessage!,
        );
      }
    } on ApiException catch (e) {
      return Left(ApiFailure(statusCode: e.statusCode, message: e.message));
    } catch (e) {
      return Left(ApiFailure(statusCode: 505, message: e.toString()));
    }
  }

  @override
  ResultFuture<List<CountryModel>> fetchCountries() async {
    try {
      final httpResponse = await _dataSource.fetchCountries();

      if (httpResponse.response.statusCode == 200) {
        return Right(httpResponse.data);
      } else {
        throw ApiException(
          statusCode: httpResponse.response.statusCode!,
          message: httpResponse.response.statusMessage!,
        );
      }
    } on ApiException catch (e) {
      return Left(ApiFailure(statusCode: e.statusCode, message: e.message));
    } catch (e) {
      return Left(ApiFailure(statusCode: 505, message: e.toString()));
    }
  }

  @override
  ResultFuture<SiteModel> addSite({required SiteEntity site}) async {
    try {
      final httpResponse = await _dataSource.addSite(
        body: {
          'name': site.name,
          'active': site.active,
          'address': site.address,
          'city': site.city,
          'countryId': site.countryId,
          'phoneNumber': site.phoneNumber,
          'email': site.email,
          'fax': site.fax,
          'website': site.website,
          'notes': site.notes,
        },
      );

      if (httpResponse.response.statusCode == 200) {
        return Right(httpResponse.data);
      } else {
        throw ApiException(
          statusCode: httpResponse.response.statusCode!,
          message: httpResponse.response.statusMessage!,
        );
      }
    } on ApiException catch (e) {
      return Left(ApiFailure(statusCode: e.statusCode, message: e.message));
    } catch (e) {
      return Left(ApiFailure(statusCode: 505, message: e.toString()));
    }
  }

  @override
  ResultFutureVoid updateSite({required SiteEntity site}) async {
    try {
      final httpResponse = await _dataSource.updateSite(
        body: {
          'idToUpdate': site.id,
          'newDenomination': site.name,
          'newActive': site.active,
          'newAddress': site.address,
          'newCity': site.city,
          'newCountryId': site.countryId,
          'newPhoneNumber': site.phoneNumber,
          'newEmail': site.email,
          'newFax': site.fax,
          'newWebsite': site.website,
          'newNotes': site.notes,
        },
      );

      if (httpResponse.response.statusCode == 200) {
        return Right(httpResponse.data);
      } else {
        throw ApiException(
          statusCode: httpResponse.response.statusCode!,
          message: httpResponse.response.statusMessage!,
        );
      }
    } on ApiException catch (e) {
      return Left(ApiFailure(statusCode: e.statusCode, message: e.message));
    } catch (e) {
      return Left(ApiFailure(statusCode: 505, message: e.toString()));
    }
  }
}
