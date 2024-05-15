import 'package:blocks/config/routes/routes_names.dart';
import 'package:blocks/config/theme/theme.dart';
import 'package:blocks/core/presentation/widgets/k_data_grid.dart';
import 'package:blocks/features/productions/productions/domain/entities/production_entity.dart';
import 'package:blocks/features/productions/productions/presentation/bloc/productions/productions_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductionsDataGrid extends StatefulWidget {
  const ProductionsDataGrid({
    super.key,
    required this.productions,
  });

  final List<ProductionEntity> productions;

  @override
  State<ProductionsDataGrid> createState() => _ProductionsDataGridState();
}

class _ProductionsDataGridState extends State<ProductionsDataGrid> {
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
        columnName: 'creation_date',
        minimumWidth: 12.w(context),
        columnWidthMode: ColumnWidthMode.fill,
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

  late _ProductionsDataSource _dataSource;
  List<ProductionEntity> _productions = <ProductionEntity>[];

  @override
  void initState() {
    super.initState();
    _productions = widget.productions;
    _dataSource = _ProductionsDataSource(
      context: context,
      productions: _productions,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductionsBloc, ProductionsState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case ProductionsFetchingDoneState:
            {
              _dataSource = _ProductionsDataSource(
                context: context,
                productions: state.productions!,
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
                      List<ProductionEntity> productions =
                          List.from(state.productions!);

                      productions.retainWhere((distribution) => distribution
                          .toString()
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()));

                      _dataSource = _ProductionsDataSource(
                        context: context,
                        productions: productions,
                      );
                      _dataSource.updateDataGridSource();
                      setState(() {});
                    },
                    child: const Text('Rechercher des productions'),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text('${_productions.length} éléments'),
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

class _ProductionsDataSource extends DataGridSource {
  _ProductionsDataSource({
    required this.context,
    required this.productions,
  }) {
    dataGridRows = productions
        .map<DataGridRow>((production) => DataGridRow(cells: [
              const DataGridCell<Widget>(columnName: '#', value: null),
              DataGridCell<String>(
                  columnName: 'reference', value: production.reference),
              DataGridCell<String>(
                  columnName: 'creation_date', value: production.creationDate),
              DataGridCell<String>(
                  columnName: 'operator', value: '${production.operator}\n'),
              const DataGridCell<String>(columnName: 'action', value: null),
            ]))
        .toList();
  }

  final BuildContext context;
  final List<ProductionEntity> productions;

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
                      RoutesNames.productionDetails,
                      extra: productions[index]),
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
