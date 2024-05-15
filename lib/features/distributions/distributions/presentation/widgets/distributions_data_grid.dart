import 'package:blocks/config/routes/routes_names.dart';
import 'package:blocks/config/theme/theme.dart';
import 'package:blocks/core/presentation/widgets/k_data_grid.dart';
import 'package:blocks/features/distributions/distributions/domain/entities/distribution_entity.dart';
import 'package:blocks/features/distributions/distributions/presentation/bloc/distributions/distributions_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DistributionsDataGrid extends StatefulWidget {
  const DistributionsDataGrid({
    super.key,
    required this.distributions,
  });

  final List<DistributionEntity> distributions;

  @override
  State<DistributionsDataGrid> createState() => _DistributionsDataGridState();
}

class _DistributionsDataGridState extends State<DistributionsDataGrid> {
  final TextEditingController _searchController = TextEditingController();

  List<GridColumn> _buildColumns(BuildContext context) {
    return <GridColumn>[
      GridColumn(
        columnName: '#',
        minimumWidth: 6.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            '#',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'reference',
        width: 10.w(context),
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Réference',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'client',
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Client',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'creation_date',
        width: 12.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Date de création',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'operator',
        width: 20.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Opérateur',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'action',
        width: 10.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Action',
            style: gridColumnTextStyle,
          ),
        ),
      ),
    ];
  }

  late _DistributionsDataSource _dataSource;
  List<DistributionEntity> _distributions = <DistributionEntity>[];

  @override
  void initState() {
    super.initState();
    _distributions = widget.distributions;
    _dataSource = _DistributionsDataSource(
      context: context,
      distributions: _distributions,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DistributionsBloc, DistributionsState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case DistributionsFetchingDoneState:
            {
              _dataSource = _DistributionsDataSource(
                context: context,
                distributions: state.distributions!,
              );
              _dataSource.updateDataGridSource();
              break;
            }
        }
      },
      builder: (context, state) {
        return SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 20.w(context),
                    child: TextBox(controller: _searchController),
                  ),
                  const SizedBox(width: 8),
                  Button(
                    onPressed: () {
                      List<DistributionEntity> distributions =
                          List.from(state.distributions!);

                      distributions.retainWhere((distribution) => distribution
                          .toString()
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()));

                      _dataSource = _DistributionsDataSource(
                        context: context,
                        distributions: distributions,
                      );
                      _dataSource.updateDataGridSource();
                      setState(() {});
                    },
                    child: const Text('Rechercher des distributions'),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text('${_distributions.length} éléments'),
              const SizedBox(height: 16),
              SizedBox(
                height: 65.h(context),
                child: KDataGrid(
                  dataSource: _dataSource,
                  columns: _buildColumns(context),
                  showCheckboxColumn: false,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DistributionsDataSource extends DataGridSource {
  _DistributionsDataSource({
    required this.context,
    required this.distributions,
  }) {
    dataGridRows = distributions
        .map<DataGridRow>((distribution) => DataGridRow(cells: [
              const DataGridCell<Widget>(columnName: '#', value: null),
              DataGridCell<String>(
                  columnName: 'reference', value: distribution.reference),
              DataGridCell<String>(
                  columnName: 'client', value: '${distribution.client}\n'),
              DataGridCell<String>(
                  columnName: 'creation_date',
                  value: distribution.creationDate),
              DataGridCell<String>(
                  columnName: 'operator', value: distribution.operator),
              const DataGridCell<String>(columnName: 'action', value: null),
            ]))
        .toList();
  }

  final BuildContext context;
  final List<DistributionEntity> distributions;

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      final int index = effectiveRows.indexOf(row);
      return Container(
          color: index.isEven ? Colors.white : const Color(0xffeceff1),
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(12),
          child: dataGridCell.columnName == 'action'
              ? Button(
                  child: const Text('Voir les détails'),
                  onPressed: () => context.pushNamed(
                      RoutesNames.distributionDetails,
                      extra: distributions[index]),
                )
              : Text(dataGridCell.columnName == '#'
                  ? '${index + 1}'
                  : dataGridCell.value.toString()));
    }).toList());
  }

  void updateDataGridSource() {
    notifyListeners();
  }

  @override
  bool shouldRecalculateColumnWidths() => true;
}
