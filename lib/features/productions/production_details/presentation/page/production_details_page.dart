import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/widgets/k_back_button.dart';
import 'package:blocks/core/presentation/widgets/k_textfield_with_description.dart';
import 'package:blocks/features/productions/production_creation/presentation/widgets/materials_used_lines_data_grid.dart';
import 'package:blocks/features/productions/production_creation/presentation/widgets/production_lines_data_grid.dart';
import 'package:blocks/features/productions/production_details/presentation/bloc/production_details/production_details_bloc.dart';
import 'package:blocks/features/productions/productions/domain/entities/production_entity.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';

class ProductionDetailsPage extends StatefulWidget {
  const ProductionDetailsPage({
    super.key,
    required this.production,
  });

  final ProductionEntity production;

  @override
  State<ProductionDetailsPage> createState() => _ProductionDetailsPageState();
}

class _ProductionDetailsPageState extends State<ProductionDetailsPage> {
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _operatorController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context
        .read<ProductionDetailsBloc>()
        .add(FetchProductionDetailsEvent(productionId: widget.production.id!));

    _referenceController.text = widget.production.reference;
    _dateController.text = widget.production.creationDate;
    _operatorController.text = widget.production.operator;
  }

  @override
  void dispose() {
    super.dispose();
    _referenceController.dispose();
    _dateController.dispose();
    _operatorController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductionDetailsBloc, ProductionDetailsState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case ProductionDetailsFetchingFailedState:
            {
              context.pop();
              showInfoBar(
                context,
                title: 'Une erreur est survenue',
                message: state.message!,
                severity: InfoBarSeverity.error,
              );
              break;
            }
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ProductionDetailsFetchingLoadingState:
            {
              return const material.Scaffold(
                body: Center(
                  child: ProgressRing(
                    activeColor: kBrown,
                  ),
                ),
              );
            }
          case ProductionDetailsFetchingDoneState:
            {
              return ScaffoldPage.scrollable(
                header: PageHeader(
                  leading: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: const KBackButton(),
                  ),
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Détails de l\'approvisionnement'),
                    ],
                  ),
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
                              'Informations générales',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 16),
                            Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KInputFieldWithDescription(
                                    label: 'Référence',
                                    inputWidget: TextBox(
                                      controller: _referenceController,
                                      readOnly: true,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  KInputFieldWithDescription(
                                    label: 'Date de création',
                                    inputWidget: TextBox(
                                      controller: _dateController,
                                      readOnly: true,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  KInputFieldWithDescription(
                                    label: 'Opérateur',
                                    inputWidget: TextBox(
                                      controller: _operatorController,
                                      readOnly: true,
                                    ),
                                  ),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Matériaux Utilisé',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 24),
                              MaterialsUsedLinesDataGrid(
                                lines: state.materialsUsedLines!,
                                details: true,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Produits',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 24),
                              ProductionLinesDataGrid(
                                lines: state.productionLines!,
                                details: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              );
            }
          default:
            return const SizedBox();
        }
      },
    );
  }
}
