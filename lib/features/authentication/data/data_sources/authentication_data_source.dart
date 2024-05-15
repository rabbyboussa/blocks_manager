import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/administration/accounts/data/models/account_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'authentication_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class AuthenticationDataSource {
  factory AuthenticationDataSource(Dio dio) = _AuthenticationDataSource;

  @POST('authentication/authenticate.php')
  Future<HttpResponse<AccountModel?>> authenticate({
    @Body() required Map<String, dynamic> body,
  });
}
