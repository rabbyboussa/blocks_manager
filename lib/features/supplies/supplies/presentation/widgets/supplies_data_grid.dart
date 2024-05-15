import 'package:blocks/config/routes/routes_names.dart';
import 'package:blocks/config/theme/theme.dart';
import 'package:blocks/core/presentation/widgets/k_data_grid.dart';
import 'package:blocks/features/supplies/supplies/domain/entities/supply_entity.dart';
import 'package:blocks/features/supplies/supplies/presentation/bloc/suppliers/supplies_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SuppliesDataGrid extends StatefulWidget {
  const SuppliesDataGrid({
    super.key,
    required this.supplies,
  });

  final List<SupplyEntity> supplies;

  @override
  State<SuppliesDataGrid> createState() => _SuppliesDataGridState();
}

class _SuppliesDataGridState extends State<SuppliesDataGrid> {
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
        columnName: 'supplier',
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Fournisseur',
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

  late _SuppliesDataSource _dataSource;
  List<SupplyEntity> _supplies = <SupplyEntity>[];

  @override
  void initState() {
    super.initState();
    _supplies = widget.supplies;
    _dataSource = _SuppliesDataSource(
      context: context,
      supplies: _supplies,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuppliesBloc, SuppliesState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case SuppliesFetchingDoneState:
            {
              _dataSource = _SuppliesDataSource(
                context: context,
                supplies: state.supplies!,
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
                      List<SupplyEntity> supplies = List.from(state.supplies!);

                      supplies.retainWhere((supply) => supply
                          .toString()
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()));

                      _dataSource = _SuppliesDataSource(
                        context: context,
                        supplies: supplies,
                      );
                      _dataSource.updateDataGridSource();
                      setState(() {});
                    },
                    child: const Text('Rechercher des matériaux'),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text('${_supplies.length} éléments'),
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

class _SuppliesDataSource extends DataGridSource {
  _SuppliesDataSource({
    required this.context,
    required this.supplies,
  }) {
    dataGridRows = supplies
        .map<DataGridRow>((supply) => DataGridRow(cells: [
              const DataGridCell<Widget>(columnName: '#', value: null),
              DataGridCell<String>(
                  columnName: 'reference', value: supply.reference),
              DataGridCell<String>(
                  columnName: 'supplier', value: '${supply.supplier}\n'),
              DataGridCell<String>(
                  columnName: 'creation_date', value: supply.creationDate),
              DataGridCell<String>(
                  columnName: 'operator', value: supply.operator),
              const DataGridCell<String>(columnName: 'action', value: null),
            ]))
        .toList();
  }

  final BuildContext context;
  final List<SupplyEntity> supplies;

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
                  onPressed: () => context.pushNamed(RoutesNames.supplyDetails,
                      extra: supplies[index]),
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
