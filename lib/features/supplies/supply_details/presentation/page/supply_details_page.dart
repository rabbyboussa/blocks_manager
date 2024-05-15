import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/widgets/k_back_button.dart';
import 'package:blocks/core/presentation/widgets/k_textfield_with_description.dart';
import 'package:blocks/features/supplies/supplies/domain/entities/supply_entity.dart';
import 'package:blocks/features/supplies/supply_creation/presentation/widgets/supply_lines_data_grid.dart';
import 'package:blocks/features/supplies/supply_details/presentation/bloc/supply_details/supply_details_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';

class SupplyDetailsPage extends StatefulWidget {
  const SupplyDetailsPage({
    super.key,
    required this.supply,
  });

  final SupplyEntity supply;

  @override
  State<SupplyDetailsPage> createState() => _SupplyDetailsPageState();
}

class _SupplyDetailsPageState extends State<SupplyDetailsPage> {
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _supplierController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _operatorController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context
        .read<SupplyDetailsBloc>()
        .add(FetchSupplyDetailsEvent(supplyId: widget.supply.id!));

    _referenceController.text = widget.supply.reference;
    _supplierController.text = widget.supply.supplier;
    _dateController.text = widget.supply.creationDate;
    _operatorController.text = widget.supply.operator;
  }

  @override
  void dispose() {
    super.dispose();
    _referenceController.dispose();
    _supplierController.dispose();
    _dateController.dispose();
    _operatorController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupplyDetailsBloc, SupplyDetailsState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case SupplyDetailsFetchingFailedState:
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
          case SupplyDetailsFetchingLoadingState:
            {
              return const material.Scaffold(
                body: Center(
                  child: ProgressRing(
                    activeColor: kBrown,
                  ),
                ),
              );
            }
          case SupplyDetailsFetchingDoneState:
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
                                    label: 'Fournisseur',
                                    inputWidget: TextBox(
                                      controller: _supplierController,
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
                          const Text(
                            'Matériaux approvisionnés',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 24),
                          SupplyLinesDataGrid(
                            lines: state.lines!,
                            details: true,
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
