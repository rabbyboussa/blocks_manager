import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/administration/accounts/data/models/account_model.dart';
import 'package:blocks/features/administration/accounts/data/models/role_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'accounts_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class AccountsDataSource {
  factory AccountsDataSource(Dio dio) = _AccountsDataSource;

  @GET('administration/accounts/get_accounts.php')
  Future<HttpResponse<List<AccountModel>>> fetchAccounts();

  @GET('administration/accounts/get_roles.php')
  Future<HttpResponse<List<RoleModel>>> fetchRoles();

  @POST('administration/accounts/add_account.php')
  Future<HttpResponse<AccountModel>> addAccount(
      {@Body() required Map<String, dynamic> body});

  @PUT('administration/accounts/update_account.php')
  Future<HttpResponse<void>> updateAccount(
      {@Body() required Map<String, dynamic> body});
}
