import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/widgets/k_back_button.dart';
import 'package:blocks/core/presentation/widgets/k_textfield_with_description.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart'
    as authentication;
import 'package:blocks/features/productions/production_creation/domain/entities/material_used_line_entity.dart';
import 'package:blocks/features/productions/production_creation/domain/entities/production_line_entity.dart';
import 'package:blocks/features/productions/production_creation/presentation/bloc/materials_used_lines_data_grid/materials_used_lines_data_grid_bloc.dart'
    as materials_used_bloc;
import 'package:blocks/features/productions/production_creation/presentation/bloc/production_creation/production_creation_bloc.dart';
import 'package:blocks/features/productions/production_creation/presentation/bloc/production_lines_data_grid/production_lines_data_grid_bloc.dart';
import 'package:blocks/features/productions/production_creation/presentation/widgets/materials_used_lines_data_grid.dart';
import 'package:blocks/features/productions/production_creation/presentation/widgets/production_lines_data_grid.dart';
import 'package:blocks/features/productions/productions/presentation/bloc/productions/productions_bloc.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';

class ProductionCreationPage extends StatefulWidget {
  const ProductionCreationPage({super.key});

  @override
  State<ProductionCreationPage> createState() => _ProductionCreationPageState();
}

class _ProductionCreationPageState extends State<ProductionCreationPage> {
  ProductEntity? _selectedProduct;
  MaterialEntity? _selectedMaterial;
  final TextEditingController _materialQuantityController =
      TextEditingController(text: '0');

  final TextEditingController _productQuantityController =
  TextEditingController(text: '0');

  List<ProductEntity> _products = [];
  List<MaterialEntity> _materials = [];

  List<ProductionLineEntity> productionLines = [];
  List<MaterialUsedLineEntity> materialsUsedLines = [];
  List<String> productsAddedNames = [];
  List<String> materialsUsedNames = [];

  @override
  void initState() {
    super.initState();
    context.read<ProductionCreationBloc>().add(FetchDataEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _materialQuantityController.dispose();
    _productQuantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductionCreationBloc, ProductionCreationState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case ProductionCreationLoadingState:
            {
              showProgressDialog(context, message: 'Veuillez patienter');
              break;
            }

          case ProductionCreationFailedState:
            {
              context.pop();
              final failedState = state as ProductionCreationFailedState;
              showInfoBar(
                context,
                title: 'Une erreur est survenue',
                message: failedState.message,
                severity: InfoBarSeverity.error,
              );
              break;
            }
          case ProductionCreationDoneState:
            {
              context.read<ProductionsBloc>().add(FetchProductionsEvent(siteId: context.read<authentication.AuthenticationBloc>().state.account!.siteId!));
              context.pop();
              showInfoBar(
                context,
                title: 'Opération réussie',
                message: 'Production enregistrée avec succès.',
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
              _materials = doneState.materials;
              break;
            }
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case DataFetchingDoneState:
          case ProductionCreationLoadingState:
          case ProductionCreationFailedState:
          case ProductionCreationDoneState:
            {
              return ScaffoldPage.scrollable(
                header: PageHeader(
                  leading: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: const KBackButton(),
                  ),
                  title: const Text('Ajouter une production'),
                ),
                children: [
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  'Matériaux utilisés',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Veuillez sélectionner les matéraiux utilisés pour la distribution tout en reseignant pour chaque matériau la quantité.',
                                  style: TextStyle(fontSize: 13),
                                ),
                                const SizedBox(height: 16),
                                Form(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      KInputFieldWithDescription(
                                        label: 'Matériaux',
                                        inputWidget: ComboBox<MaterialEntity>(
                                          onChanged: (material) {
                                            setState(() {
                                              _selectedMaterial = material;
                                            });
                                          },
                                          value: _selectedMaterial,
                                          isExpanded: true,
                                          items: _materials
                                              .map(
                                                (material) => ComboBoxItem(
                                                  value: material,
                                                  child: Text(
                                                      material.designation),
                                                ),
                                              )
                                              .toList(),
                                          placeholder: const Text(
                                              'Selectionnez un matériau'),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      KInputFieldWithDescription(
                                        label: 'Quantité',
                                        inputWidget: TextBox(
                                          controller: _materialQuantityController,
                                        ),
                                        description: _selectedMaterial == null
                                            ? ''
                                            : 'Unité de mesure: «${_selectedMaterial?.measurementUnit}» / Quantité en stock: ${_selectedMaterial!.quantity}',
                                      ),
                                      const SizedBox(height: 16),
                                      BlocConsumer<
                                          materials_used_bloc
                                          .MaterialsUsedLinesDataGridBloc,
                                          materials_used_bloc
                                          .MaterialsUsedLinesDataGridState>(
                                        listener: (context, state) {
                                          switch (state.runtimeType) {
                                            case materials_used_bloc
                                                  .LinesEditedState:
                                              {
                                                materialsUsedNames.clear();
                                                final editedState = state
                                                    as materials_used_bloc
                                                    .LinesEditedState;
                                                for (MaterialUsedLineEntity line
                                                    in editedState.lines) {
                                                  materialsUsedNames
                                                      .add(line.material);
                                                }

                                                break;
                                              }
                                          }
                                        },
                                        builder: (context, state) {
                                          return Button(
                                            onPressed: () {
                                              if (_selectedMaterial == null ||
                                                  _materialQuantityController.text
                                                      .trim()
                                                      .isEmpty) {
                                                showInfoBar(context,
                                                    title: 'Attention',
                                                    message:
                                                        'Veuillez sélectionner un matériau et la quantité.',
                                                    severity: InfoBarSeverity
                                                        .warning);
                                              } else {
                                                final MaterialUsedLineEntity
                                                    line =
                                                    MaterialUsedLineEntity(
                                                  material: _selectedMaterial!
                                                      .designation,
                                                  quantity: double.parse(
                                                      _materialQuantityController.text),
                                                );
                                                if (materialsUsedLines.isEmpty) {
                                                  if (double.parse(
                                                          _materialQuantityController
                                                              .text) ==
                                                      0) {
                                                    showInfoBar(context,
                                                        title: 'Attention',
                                                        message:
                                                            'La quantité doit être supérieur à 0',
                                                        severity:
                                                            InfoBarSeverity
                                                                .warning);
                                                  } else {
                                                    if (double.parse(
                                                        _materialQuantityController
                                                            .text) >
                                                        _selectedMaterial!
                                                            .quantity) {
                                                      showInfoBar(context,
                                                          title: 'Attention',
                                                          message:
                                                          'La quantité ne peut pas être supérieur à la quantité du matériau en stock.',
                                                          severity:
                                                          InfoBarSeverity
                                                              .warning);
                                                    } else {
                                                      materialsUsedLines
                                                          .add(line);
                                                      materialsUsedNames.add(
                                                          _selectedMaterial!
                                                              .designation);
                                                      context
                                                          .read<
                                                          materials_used_bloc
                                                              .MaterialsUsedLinesDataGridBloc>()
                                                          .add(materials_used_bloc
                                                          .LinesEditedEvent(
                                                          lines:
                                                          materialsUsedLines));
                                                    }

                                                  }
                                                } else {
                                                  if (materialsUsedNames
                                                      .contains(
                                                          _selectedMaterial!
                                                              .designation)) {
                                                    showInfoBar(
                                                      context,
                                                      title: 'Attention',
                                                      message:
                                                          'Ce matériau a déjà été ajouté.',
                                                      severity: InfoBarSeverity
                                                          .warning,
                                                    );
                                                  } else {
                                                    if (double.parse(
                                                            _materialQuantityController
                                                                .text) ==
                                                        0) {
                                                      showInfoBar(context,
                                                          title: 'Attention',
                                                          message:
                                                              'La quantité doit être supérieur à 0',
                                                          severity:
                                                              InfoBarSeverity
                                                                  .warning);
                                                    } else {
                                                      if (double.parse(
                                                          _materialQuantityController
                                                              .text) >
                                                          _selectedMaterial!
                                                              .quantity) {
                                                        showInfoBar(context,
                                                            title: 'Attention',
                                                            message:
                                                            'La quantité ne peut pas être supérieur à la quantité du matériau en stock.',
                                                            severity:
                                                            InfoBarSeverity
                                                                .warning);
                                                      } else {
                                                        materialsUsedLines
                                                            .add(line);
                                                        materialsUsedNames.add(
                                                            _selectedMaterial!
                                                                .designation);
                                                        context
                                                            .read<
                                                            materials_used_bloc
                                                                .MaterialsUsedLinesDataGridBloc>()
                                                            .add(materials_used_bloc
                                                            .LinesEditedEvent(
                                                            lines:
                                                            materialsUsedLines));
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            },
                                            child: const Text(
                                                'Ajouter à la production'),
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
                              MaterialsUsedLinesDataGrid(
                                  lines: materialsUsedLines),
                            ],
                          ),
                        ],
                      ),

////////////////////////////////////////////////////////////////////////

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
                                  'Produits',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Veuillez sélectionner les produits qui constituent la production tout en reseignant pour chaque produit la quantité.',
                                  style: TextStyle(fontSize: 13),
                                ),
                                const SizedBox(height: 16),
                                Form(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  child:
                                                      Text(product.designation),
                                                ),
                                              )
                                              .toList(),
                                          placeholder: const Text(
                                              'Selectionnez un produit'),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      KInputFieldWithDescription(
                                        label: 'Quantité',
                                        inputWidget: TextBox(
                                          controller: _productQuantityController,
                                        ),
                                        description: _selectedProduct == null
                                            ? ''
                                            : 'Quantité en stock: «${_selectedProduct?.quantity}»',
                                      ),
                                      const SizedBox(height: 16),
                                      BlocConsumer<ProductionLinesDataGridBloc,
                                          ProductionLinesDataGridState>(
                                        listener: (context, state) {
                                          switch (state.runtimeType) {
                                            case LinesEditedState:
                                              {
                                                productsAddedNames.clear();
                                                final editedState =
                                                    state as LinesEditedState;
                                                for (ProductionLineEntity line
                                                    in editedState.lines) {
                                                  productsAddedNames
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
                                                  _productQuantityController.text
                                                      .trim()
                                                      .isEmpty) {
                                                showInfoBar(context,
                                                    title: 'Attention',
                                                    message:
                                                        'Veuillez sélectionner un produit et la quantité.',
                                                    severity: InfoBarSeverity
                                                        .warning);
                                              } else {
                                                final ProductionLineEntity
                                                    line = ProductionLineEntity(
                                                  product: _selectedProduct!
                                                      .designation,
                                                  quantity: double.parse(
                                                      _productQuantityController.text),
                                                );
                                                if (productionLines.isEmpty) {
                                                  if (double.parse(
                                                          _productQuantityController
                                                              .text) ==
                                                      0) {
                                                    showInfoBar(context,
                                                        title: 'Attention',
                                                        message:
                                                            'La quantité doit être supérieur à 0',
                                                        severity:
                                                            InfoBarSeverity
                                                                .warning);
                                                  } else {
                                                    productionLines.add(line);
                                                    productsAddedNames.add(
                                                        _selectedProduct!
                                                            .designation);
                                                    context
                                                        .read<
                                                            ProductionLinesDataGridBloc>()
                                                        .add(LinesEditedEvent(
                                                            lines:
                                                                productionLines));
                                                  }
                                                } else {
                                                  if (productsAddedNames
                                                      .contains(
                                                          _selectedProduct!
                                                              .designation)) {
                                                    showInfoBar(
                                                      context,
                                                      title: 'Attention',
                                                      message:
                                                          'Ce produit a déjà été ajouté.',
                                                      severity: InfoBarSeverity
                                                          .warning,
                                                    );
                                                  } else {
                                                    if (double.parse(
                                                            _productQuantityController
                                                                .text) ==
                                                        0) {
                                                      showInfoBar(context,
                                                          title: 'Attention',
                                                          message:
                                                              'La quantité doit être supérieur à 0',
                                                          severity:
                                                              InfoBarSeverity
                                                                  .warning);
                                                    } else {
                                                      productionLines.add(line);
                                                      productsAddedNames.add(
                                                          _selectedProduct!
                                                              .designation);
                                                      context
                                                          .read<
                                                              ProductionLinesDataGridBloc>()
                                                          .add(LinesEditedEvent(
                                                              lines:
                                                                  productionLines));
                                                    }
                                                  }
                                                }
                                              }
                                            },
                                            child: const Text(
                                                'Ajouter à la production'),
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
                              ProductionLinesDataGrid(lines: productionLines),
                              FilledButton(
                                  child: const Text('Créer la production'),
                                  onPressed: () {
                                    if (productionLines.isEmpty || materialsUsedLines.isEmpty) {
                                      showInfoBar(context,
                                          title: 'Attention',
                                          message:
                                              'Vous devez renseigner la liste des produits produits ainsi que la liste des matériaux utilisés.',
                                          severity: InfoBarSeverity.warning);
                                    } else {
                                      context
                                          .read<ProductionCreationBloc>()
                                          .add(CreateProductionEvent(
                                              reference:
                                                  'PR${DateTime.now().millisecondsSinceEpoch.remainder(10000000).toString()}',
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
                                              siteId: context
                                                  .read<
                                                  authentication
                                                      .AuthenticationBloc>()
                                                  .state
                                                  .account!
                                                  .siteId!,
                                              products: _products,
                                              materials: _materials,
                                              productionLines: productionLines,
                                              materialsUsedLines:
                                                  materialsUsedLines));
                                    }
                                  })
                            ],
                          ),
                        ],
                      )
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
