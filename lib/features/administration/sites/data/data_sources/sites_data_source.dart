import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/administration/sites/data/models/country_model.dart';
import 'package:blocks/features/administration/sites/data/models/site_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'sites_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class SitesDataSource {
  factory SitesDataSource(Dio dio) = _SitesDataSource;

  @GET('administration/sites/get_sites.php')
  Future<HttpResponse<List<SiteModel>>> fetchSites();

  @GET('administration/sites/get_countries.php')
  Future<HttpResponse<List<CountryModel>>> fetchCountries();

  @POST('administration/sites/add_site.php')
  Future<HttpResponse<SiteModel>> addSite(
      {@Body() required Map<String, dynamic> body});

  @PUT('administration/sites/update_site.php')
  Future<HttpResponse<void>> updateSite(
      {@Body() required Map<String, dynamic> body});
}
