import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/distributions/clients/data/models/client_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'clients_data_source.g.dart';

@RestApi(baseUrl: kAPIBaseUrl)
abstract class ClientsDataSource {
  factory ClientsDataSource(Dio dio) = _ClientsDataSource;

  @GET('distributions/clients/get_clients.php')
  Future<HttpResponse<List<ClientModel>>> fetchClients();

  @POST('distributions/clients/add_client.php')
  Future<HttpResponse<ClientModel>> addClient(
      {@Body() required Map<String, dynamic> body});

  @PUT('distributions/clients/update_client.php')
  Future<HttpResponse<void>> updateClient(
      {@Body() required Map<String, dynamic> body});
}
