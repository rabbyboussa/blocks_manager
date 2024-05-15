import 'package:blocks/config/theme/theme.dart';
import 'package:blocks/core/presentation/widgets/k_data_grid.dart';
import 'package:blocks/features/distributions/distribution_creation/domain/entities/distribution_line_entity.dart';
import 'package:blocks/features/distributions/distribution_creation/presentation/bloc/distribution_lines_data_grid/distribution_lines_data_grid_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DistributionLinesDataGrid extends StatefulWidget {
  const DistributionLinesDataGrid({
    super.key,
    required this.lines,
    this.details = false,
  });

  final List<DistributionLineEntity> lines;
  final bool details;

  @override
  State<DistributionLinesDataGrid> createState() =>
      _DistributionLinesDataGridState();
}

class _DistributionLinesDataGridState extends State<DistributionLinesDataGrid> {
  final TextEditingController _searchController = TextEditingController();

  List<GridColumn> _buildColumns(BuildContext context) {
    return <GridColumn>[
      GridColumn(
        columnName: '#',
        width: 80,
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
        columnName: 'product',
        allowSorting: false,
        columnWidthMode: ColumnWidthMode.fill,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Produit',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'quantity',
        width: 120,
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Quantité',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'action',
        width: 80,
        allowSorting: false,
        visible: !widget.details,
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

  late _DistributionLinesDataSource _dataSource;
  List<DistributionLineEntity> _lines = [];

  @override
  void initState() {
    super.initState();
    _lines = widget.lines;
    _dataSource = _DistributionLinesDataSource(
      context: context,
      lines: _lines,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DistributionLinesDataGridBloc,
        DistributionLinesDataGridState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case LinesEditedState:
            {
              final editedState = state as LinesEditedState;
              _lines = editedState.lines;
              _dataSource = _DistributionLinesDataSource(
                context: context,
                lines: _lines,
              );
              _dataSource.updateDataGridSource();
            }
        }
      },
      builder: (context, state) {
        return SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${_lines.length} éléments'),
              const SizedBox(height: 16),
              SizedBox(
                width: 640,
                height: 50.h(context),
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

class _DistributionLinesDataSource extends DataGridSource {
  _DistributionLinesDataSource({
    required this.context,
    required this.lines,
  }) {
    dataGridRows = lines
        .map<DataGridRow>((line) => DataGridRow(cells: [
              const DataGridCell<Widget>(columnName: '#', value: null),
              DataGridCell<String>(columnName: 'product', value: line.product),
              DataGridCell<double>(
                  columnName: 'quantity', value: line.quantity),
              const DataGridCell<String>(columnName: 'action', value: null),
            ]))
        .toList();
  }

  final BuildContext context;
  final List<DistributionLineEntity> lines;

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
              ? IconButton(
                  icon: Icon(
                    FluentIcons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    lines.removeAt(index);
                    context
                        .read<DistributionLinesDataGridBloc>()
                        .add(LinesEditedEvent(lines: lines));
                  })
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
