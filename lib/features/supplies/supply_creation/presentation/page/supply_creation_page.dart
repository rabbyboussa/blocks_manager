import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/widgets/k_back_button.dart';
import 'package:blocks/core/presentation/widgets/k_textfield_with_description.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart'
    as authentication;
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:blocks/features/supplies/suppliers/domain/entities/supplier_entity.dart';
import 'package:blocks/features/supplies/supplies/presentation/bloc/suppliers/supplies_bloc.dart';
import 'package:blocks/features/supplies/supply_creation/domain/entities/supply_line_entity.dart';
import 'package:blocks/features/supplies/supply_creation/presentation/bloc/supply_creation/supply_creation_bloc.dart';
import 'package:blocks/features/supplies/supply_creation/presentation/bloc/supply_lines_data_grid/supply_lines_data_grid_bloc.dart';
import 'package:blocks/features/supplies/supply_creation/presentation/widgets/supply_lines_data_grid.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';

class SupplyCreationPage extends StatefulWidget {
  const SupplyCreationPage({super.key});

  @override
  State<SupplyCreationPage> createState() => _SupplyCreationPageState();
}

class _SupplyCreationPageState extends State<SupplyCreationPage> {
  MaterialEntity? _selectedMaterial;
  SupplierEntity? _selectedSupplier;
  final TextEditingController _quantityController =
      TextEditingController(text: '0');

  List<MaterialEntity> _materials = [];
  List<SupplierEntity> _suppliers = [];

  List<SupplyLineEntity> supplyLines = [];
  List<String> materialsSuppliedNames = [];

  @override
  void initState() {
    super.initState();
    context.read<SupplyCreationBloc>().add(FetchDataEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupplyCreationBloc, SupplyCreationState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case SupplyCreationLoadingState:
            {
              showProgressDialog(context, message: 'Veuillez patienter');
              break;
            }

          case SupplyCreationFailedState:
            {
              context.pop();
              final failedState = state as SupplyCreationFailedState;
              showInfoBar(
                context,
                title: 'Une erreur est survenue',
                message: failedState.message,
                severity: InfoBarSeverity.error,
              );
              break;
            }
          case SupplyCreationDoneState:
            {
              context.read<SuppliesBloc>().add(FetchSuppliesEvent());
              context.pop();
              showInfoBar(
                context,
                title: 'Opération réussie',
                message: 'Approvisionnement enregistré avec succès.',
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
              _materials = doneState.materials;
              _suppliers = doneState.suppliers;
              break;
            }
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case DataFetchingDoneState:
          case SupplyCreationLoadingState:
          case SupplyCreationFailedState:
          case SupplyCreationDoneState:
            {
              return ScaffoldPage.scrollable(
                header: PageHeader(
                  leading: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: const KBackButton(),
                  ),
                  title: const Text('Ajouter un approvisionnement'),
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
                              'Approvisionner un matériau',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Veuillez sélectionner les matériaux qui constituent votre approvisionnement tout en reseignant pour chaque matériau la quantité approvisionné.',
                              style: TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 16),
                            Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KInputFieldWithDescription(
                                    label: 'Matériau',
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
                                              child: Text(material.designation),
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
                                      controller: _quantityController,
                                    ),
                                    description: _selectedMaterial == null
                                        ? ''
                                        : 'Unité de messure: «${_selectedMaterial?.measurementUnit}»',
                                  ),
                                  const SizedBox(height: 16),
                                  BlocConsumer<SupplyLinesDataGridBloc,
                                      SupplyLinesDataGridState>(
                                    listener: (context, state) {
                                      switch (state.runtimeType) {
                                        case LinesEditedState:
                                          {
                                            materialsSuppliedNames.clear();
                                            final editedState =
                                                state as LinesEditedState;
                                            for (SupplyLineEntity line
                                                in editedState.supplyLines) {
                                              materialsSuppliedNames
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
                                              _quantityController.text
                                                  .trim()
                                                  .isEmpty) {
                                            showInfoBar(context,
                                                title: 'Attention',
                                                message:
                                                    'Veuillez sélectionner um matériau et la quantité approvisionné.',
                                                severity:
                                                    InfoBarSeverity.warning);
                                          } else {
                                            final SupplyLineEntity line =
                                                SupplyLineEntity(
                                              material: _selectedMaterial!
                                                  .designation,
                                              quantity: double.parse(
                                                  _quantityController.text),
                                            );
                                            if (supplyLines.isEmpty) {
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
                                                supplyLines.add(line);
                                                materialsSuppliedNames.add(
                                                    _selectedMaterial!
                                                        .designation);
                                                context
                                                    .read<
                                                        SupplyLinesDataGridBloc>()
                                                    .add(LinesEditedEvent(
                                                        supplyLines:
                                                            supplyLines));
                                              }
                                            } else {
                                              if (materialsSuppliedNames
                                                  .contains(_selectedMaterial!
                                                      .designation)) {
                                                showInfoBar(
                                                  context,
                                                  title: 'Attention',
                                                  message:
                                                      'Ce matériau a déjà été ajouté.',
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
                                                  supplyLines.add(line);
                                                  materialsSuppliedNames.add(
                                                      _selectedMaterial!
                                                          .designation);
                                                  context
                                                      .read<
                                                          SupplyLinesDataGridBloc>()
                                                      .add(LinesEditedEvent(
                                                          supplyLines:
                                                              supplyLines));
                                                }
                                              }
                                            }
                                          }
                                        },
                                        child: const Text(
                                            'Ajouter à l\'approvisionnement'),
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
                              label: 'Fournisseur',
                              inputWidget: ComboBox<SupplierEntity>(
                                onChanged: (supplier) {
                                  setState(() {
                                    _selectedSupplier = supplier;
                                  });
                                },
                                value: _selectedSupplier,
                                isExpanded: true,
                                items: _suppliers
                                    .map(
                                      (supplier) => ComboBoxItem(
                                        value: supplier,
                                        child: Text(supplier.denomination),
                                      ),
                                    )
                                    .toList(),
                                placeholder:
                                    const Text('Selectionnez un fournisseur'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SupplyLinesDataGrid(lines: supplyLines),
                          FilledButton(
                              child: const Text('Créer l\'approvisionnement'),
                              onPressed: () {
                                if (supplyLines.isEmpty) {
                                  showInfoBar(context,
                                      title: 'Attention',
                                      message:
                                          'L\'approvisionnement ne peut pas être vide.',
                                      severity: InfoBarSeverity.warning);
                                } else {
                                  if (_selectedSupplier == null) {
                                    showInfoBar(context,
                                        title: 'Attention',
                                        message:
                                            'Veuillez sélectionner le fournisseur',
                                        severity: InfoBarSeverity.warning);
                                  } else {
                                    context
                                        .read<SupplyCreationBloc>()
                                        .add(CreateSupplyEvent(
                                          reference:
                                              'AP${DateTime.now().millisecondsSinceEpoch.remainder(10000000).toString()}',
                                          supplierId: _selectedSupplier!.id!,
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
                                          materials: _materials,
                                          lines: supplyLines,
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
