import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/widgets/k_back_button.dart';
import 'package:blocks/core/presentation/widgets/k_textfield_with_description.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart'
    as authentication;
import 'package:blocks/features/distributions/clients/domain/entities/client_entity.dart';
import 'package:blocks/features/distributions/distribution_creation/domain/entities/distribution_line_entity.dart';
import 'package:blocks/features/distributions/distribution_creation/presentation/bloc/distribution_creation/distribution_creation_bloc.dart';
import 'package:blocks/features/distributions/distribution_creation/presentation/bloc/distribution_lines_data_grid/distribution_lines_data_grid_bloc.dart';
import 'package:blocks/features/distributions/distribution_creation/presentation/widgets/distribution_lines_data_grid.dart';
import 'package:blocks/features/distributions/distributions/presentation/bloc/distributions/distributions_bloc.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';

class DistributionCreationPage extends StatefulWidget {
  const DistributionCreationPage({super.key});

  @override
  State<DistributionCreationPage> createState() =>
      _DistributionCreationPageState();
}

class _DistributionCreationPageState extends State<DistributionCreationPage> {
  ProductEntity? _selectedProduct;
  ClientEntity? _selectedClient;
  final TextEditingController _quantityController =
      TextEditingController(text: '0');

  List<ProductEntity> _products = [];
  List<ClientEntity> _clients = [];

  List<DistributionLineEntity> distributionLines = [];
  List<String> productsDistributedNames = [];

  @override
  void initState() {
    super.initState();
    context.read<DistributionCreationBloc>().add(FetchDataEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DistributionCreationBloc, DistributionCreationState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case DistributionCreationLoadingState:
            {
              showProgressDialog(context, message: 'Veuillez patienter');
              break;
            }

          case DistributionCreationFailedState:
            {
              context.pop();
              final failedState = state as DistributionCreationFailedState;
              showInfoBar(
                context,
                title: 'Une erreur est survenue',
                message: failedState.message,
                severity: InfoBarSeverity.error,
              );
              break;
            }
          case DistributionCreationDoneState:
            {
              context.read<DistributionsBloc>().add(FetchDistributionsEvent());
              context.pop();
              showInfoBar(
                context,
                title: 'Opération réussie',
                message: 'Distribution enregistrée avec succès.',
                severity: InfoBarSeverity.success,
              );
              break;
            }
          case DataFetchingFailedState:
            {
              final failedState = state as DataFetchingFailedState;
              showInfoBar(
                context,
                title: 'Une erreur est survenue',
                message: failedState.message,
                severity: InfoBarSeverity.error,
              );
              break;
            }
          case DataFetchingDoneState:
            {
              final doneState = state as DataFetchingDoneState;
              _products = doneState.products;
              _clients = doneState.clients;
              break;
            }
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case DataFetchingDoneState:
          case DistributionCreationLoadingState:
          case DistributionCreationFailedState:
          case DistributionCreationDoneState:
            {
              return ScaffoldPage.scrollable(
                header: PageHeader(
                  leading: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: const KBackButton(),
                  ),
                  title: const Text('Ajouter une distribution'),
                ),
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Distribuer un matériau',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Veuillez sélectionner les produits qui constituent la distribution tout en reseignant pour chaque produit la quantité.',
                              style: TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 16),
                            Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KInputFieldWithDescription(
                                    label: 'Produit',
                                    inputWidget: ComboBox<ProductEntity>(
                                      onChanged: (product) {
                                        setState(() {
                                          _selectedProduct = product;
                                        });
                                      },
                                      value: _selectedProduct,
                                      isExpanded: true,
                                      items: _products
                                          .map(
                                            (product) => ComboBoxItem(
                                              value: product,
                                              child: Text(product.designation),
                                            ),
                                          )
                                          .toList(),
                                      placeholder:
                                          const Text('Selectionnez un produit'),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  KInputFieldWithDescription(
                                    label: 'Quantité',
                                    inputWidget: TextBox(
                                      controller: _quantityController,
                                    ),
                                    description: _selectedProduct == null
                                        ? ''
                                        : 'Quantité en stock: «${_selectedProduct?.quantity}»',
                                  ),
                                  const SizedBox(height: 16),
                                  BlocConsumer<DistributionLinesDataGridBloc,
                                      DistributionLinesDataGridState>(
                                    listener: (context, state) {
                                      switch (state.runtimeType) {
                                        case LinesEditedState:
                                          {
                                            productsDistributedNames.clear();
                                            final editedState =
                                                state as LinesEditedState;
                                            for (DistributionLineEntity line
                                                in editedState.lines) {
                                              productsDistributedNames
                                                  .add(line.product);
                                            }

                                            break;
                                          }
                                      }
                                    },
                                    builder: (context, state) {
                                      return Button(
                                        onPressed: () {
                                          if (_selectedProduct == null ||
                                              _quantityController.text
                                                  .trim()
                                                  .isEmpty) {
                                            showInfoBar(context,
                                                title: 'Attention',
                                                message:
                                                    'Veuillez sélectionner un produit et la quantité.',
                                                severity:
                                                    InfoBarSeverity.warning);
                                          } else {
                                            final DistributionLineEntity line =
                                                DistributionLineEntity(
                                              product:
                                                  _selectedProduct!.designation,
                                              quantity: double.parse(
                                                  _quantityController.text),
                                            );
                                            if (distributionLines.isEmpty) {
                                              if (double.parse(
                                                      _quantityController
                                                          .text) ==
                                                  0) {
                                                showInfoBar(context,
                                                    title: 'Attention',
                                                    message:
                                                        'La quantité doit être supérieur à 0',
                                                    severity: InfoBarSeverity
                                                        .warning);
                                              } else {
                                                if (double.parse(
                                                        _quantityController
                                                            .text) >
                                                    _selectedProduct!
                                                        .quantity) {
                                                  showInfoBar(context,
                                                      title: 'Attention',
                                                      message:
                                                          'La quantité ne peut pas être supérieur à la quantité du produit en stock.',
                                                      severity: InfoBarSeverity
                                                          .warning);
                                                } else {
                                                  distributionLines.add(line);
                                                  productsDistributedNames.add(
                                                      _selectedProduct!
                                                          .designation);
                                                  context
                                                      .read<
                                                          DistributionLinesDataGridBloc>()
                                                      .add(LinesEditedEvent(
                                                          lines:
                                                              distributionLines));
                                                }
                                              }
                                            } else {
                                              if (productsDistributedNames
                                                  .contains(_selectedProduct!
                                                      .designation)) {
                                                showInfoBar(
                                                  context,
                                                  title: 'Attention',
                                                  message:
                                                      'Ce produit a déjà été ajouté.',
                                                  severity:
                                                      InfoBarSeverity.warning,
                                                );
                                              } else {
                                                if (double.parse(
                                                        _quantityController
                                                            .text) ==
                                                    0) {
                                                  showInfoBar(context,
                                                      title: 'Attention',
                                                      message:
                                                          'La quantité doit être supérieur à 0',
                                                      severity: InfoBarSeverity
                                                          .warning);
                                                } else {
                                                  if (double.parse(
                                                          _quantityController
                                                              .text) >
                                                      _selectedProduct!
                                                          .quantity) {
                                                    showInfoBar(context,
                                                        title: 'Attention',
                                                        message:
                                                            'La quantité ne peut pas être supérieur à la quantité du produit en stock.',
                                                        severity:
                                                            InfoBarSeverity
                                                                .warning);
                                                  } else {
                                                    distributionLines.add(line);
                                                    productsDistributedNames
                                                        .add(_selectedProduct!
                                                            .designation);
                                                    context
                                                        .read<
                                                            DistributionLinesDataGridBloc>()
                                                        .add(LinesEditedEvent(
                                                            lines:
                                                                distributionLines));
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        },
                                        child: const Text(
                                            'Ajouter à la distribution'),
                                      );
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 15.w(context)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 640,
                            child: KInputFieldWithDescription(
                              label: 'Client',
                              inputWidget: ComboBox<ClientEntity>(
                                onChanged: (client) {
                                  setState(() {
                                    _selectedClient = client;
                                  });
                                },
                                value: _selectedClient,
                                isExpanded: true,
                                items: _clients
                                    .map(
                                      (supplier) => ComboBoxItem(
                                        value: supplier,
                                        child: Text(supplier.denomination),
                                      ),
                                    )
                                    .toList(),
                                placeholder:
                                    const Text('Selectionnez un client'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          DistributionLinesDataGrid(lines: distributionLines),
                          FilledButton(
                              child: const Text('Créer la distribution'),
                              onPressed: () {
                                if (distributionLines.isEmpty) {
                                  showInfoBar(context,
                                      title: 'Attention',
                                      message:
                                          'La distribution ne peut pas être vide.',
                                      severity: InfoBarSeverity.warning);
                                } else {
                                  if (_selectedClient == null) {
                                    showInfoBar(context,
                                        title: 'Attention',
                                        message:
                                            'Veuillez sélectionner le client',
                                        severity: InfoBarSeverity.warning);
                                  } else {
                                    context
                                        .read<DistributionCreationBloc>()
                                        .add(CreateDistributionEvent(
                                          reference:
                                              'DT${DateTime.now().millisecondsSinceEpoch.remainder(10000000).toString()}',
                                          clientId: _selectedClient!.id!,
                                          creationDate: DateFormat(
                                                  'dd/MM/yyyy à HH:mm:ss')
                                              .format(DateTime.now()),
                                          accountId: context
                                              .read<
                                                  authentication
                                                  .AuthenticationBloc>()
                                              .state
                                              .account!
                                              .id!,
                                          products: _products,
                                          lines: distributionLines,
                                        ));
                                  }
                                }
                              })
                        ],
                      ),
                    ],
                  )
                ],
              );
            }
          case DataFetchingLoadingState:
            {
              return const material.Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: ProgressRing(
                    activeColor: kBrown,
                  ),
                ),
              );
            }
          default:
            return const SizedBox();
        }
      },
    );
  }
}
