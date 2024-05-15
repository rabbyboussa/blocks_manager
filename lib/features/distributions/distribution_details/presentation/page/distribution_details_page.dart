import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/widgets/k_back_button.dart';
import 'package:blocks/core/presentation/widgets/k_textfield_with_description.dart';
import 'package:blocks/features/distributions/distribution_creation/presentation/widgets/distribution_lines_data_grid.dart';
import 'package:blocks/features/distributions/distribution_details/presentation/bloc/distribution_details/distribution_details_bloc.dart';
import 'package:blocks/features/distributions/distributions/domain/entities/distribution_entity.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';

class DistributionDetailsPage extends StatefulWidget {
  const DistributionDetailsPage({
    super.key,
    required this.distribution,
  });

  final DistributionEntity distribution;

  @override
  State<DistributionDetailsPage> createState() =>
      _DistributionDetailsPageState();
}

class _DistributionDetailsPageState extends State<DistributionDetailsPage> {
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _operatorController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<DistributionDetailsBloc>().add(
        FetchDistributionDetailsEvent(distributionId: widget.distribution.id!));

    _referenceController.text = widget.distribution.reference;
    _clientController.text = widget.distribution.client;
    _dateController.text = widget.distribution.creationDate;
    _operatorController.text = widget.distribution.operator;
  }

  @override
  void dispose() {
    super.dispose();
    _referenceController.dispose();
    _clientController.dispose();
    _dateController.dispose();
    _operatorController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DistributionDetailsBloc, DistributionDetailsState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case DistributionDetailsFetchingFailedState:
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
          case DistributionDetailsFetchingLoadingState:
            {
              return const material.Scaffold(
                body: Center(
                  child: ProgressRing(
                    activeColor: kBrown,
                  ),
                ),
              );
            }
          case DistributionDetailsFetchingDoneState:
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
                                      controller: _clientController,
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
                          DistributionLinesDataGrid(
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
