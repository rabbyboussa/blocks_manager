import 'package:bloc/bloc.dart';
import 'package:blocks/features/distributions/clients/domain/entities/client_entity.dart';
import 'package:blocks/features/distributions/clients/domain/usecases/fetch_clients_usecase.dart';
import 'package:blocks/features/distributions/distribution_creation/domain/entities/distribution_line_entity.dart';
import 'package:blocks/features/distributions/distribution_creation/domain/usecases/create_distribution_usecase.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:blocks/features/productions/products/domain/usecases/fetch_products_usecase.dart';
import 'package:equatable/equatable.dart';

part 'distribution_creation_event.dart';
part 'distribution_creation_state.dart';

class DistributionCreationBloc
    extends Bloc<DistributionCreationEvent, DistributionCreationState> {
  DistributionCreationBloc({
    required FetchProductsUsecase fetchProductsUsecase,
    required FetchClientsUsecase fetchClientsUsecase,
    required CreateDistributionUsecase createDistributionUsecase,
  })  : _fetchProductsUsecase = fetchProductsUsecase,
        _fetchClientsUsecase = fetchClientsUsecase,
        _createDistributionUsecase = createDistributionUsecase,
        super(DistributionCreationInitial()) {
    on<FetchDataEvent>(onDataFetching);
    on<CreateDistributionEvent>(onDistributionCreation);
  }

  final FetchProductsUsecase _fetchProductsUsecase;
  final FetchClientsUsecase _fetchClientsUsecase;

  final CreateDistributionUsecase _createDistributionUsecase;

  Future<void> onDistributionCreation(CreateDistributionEvent event,
      Emitter<DistributionCreationState> emit) async {
    emit(const DistributionCreationLoadingState());

    final result =
        await _createDistributionUsecase(CreateDistributionUsecaseParams(
      reference: event.reference,
      clientId: event.clientId,
      creationDate: event.creationDate,
      accountId: event.accountId,
      products: event.products,
      lines: event.lines,
    ));

    result.fold(
        (failure) =>
            emit(DistributionCreationFailedState(message: failure.message)),
        (_) => emit(const DistributionCreationDoneState()));
  }

  Future<void> onDataFetching(
      FetchDataEvent event, Emitter<DistributionCreationState> emit) async {
    emit(DataFetchingLoadingState());

    bool errorOccured = false;
    String errorMessage = '';

    List<ProductEntity> products = [];
    List<ClientEntity> clients = [];

    await _fetchProductsUsecase().then(
      (productsResult) => productsResult.fold(
        (failure) {
          errorOccured = true;
          errorMessage = failure.message;
        },
        (productsFetched) async {
          products = productsFetched;
          await _fetchClientsUsecase().then(
            (clientsResult) => clientsResult.fold(
              (failure) {
                errorOccured = true;
                errorMessage = failure.message;
              },
              (clientsFetched) async {
                clients = clientsFetched;
              },
            ),
          );
        },
      ),
    );

    if (errorOccured) {
      emit(DataFetchingFailedState(message: errorMessage));
    } else {
      emit(DataFetchingDoneState(
        products: products,
        clients: clients,
      ));
    }
  }
}
