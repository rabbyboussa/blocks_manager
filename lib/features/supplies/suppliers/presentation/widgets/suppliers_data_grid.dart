import 'package:blocks/config/theme/theme.dart';
import 'package:blocks/core/presentation/widgets/k_data_grid.dart';
import 'package:blocks/features/supplies/suppliers/domain/entities/supplier_entity.dart';
import 'package:blocks/features/supplies/suppliers/presentation/bloc/suppliers/suppliers_bloc.dart';
import 'package:blocks/features/supplies/suppliers/presentation/widgets/supplier_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SuppliersDataGrid extends StatefulWidget {
  const SuppliersDataGrid({
    super.key,
    required this.suppliers,
  });

  final List<SupplierEntity> suppliers;

  @override
  State<SuppliersDataGrid> createState() => _SuppliersDataGridState();
}

class _SuppliersDataGridState extends State<SuppliersDataGrid> {
  List<GridColumn> _buildColumns(BuildContext context) {
    return <GridColumn>[
      GridColumn(
        columnName: '#',
        minimumWidth: 2.w(context),
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
        columnName: 'denomination',
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Dénomination',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'type',
        width: 12.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Type',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'phone_number',
        width: 18.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Téléphone',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'email',
        width: 16.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Email',
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

  late _SuppliersDataSource _dataSource;
  List<SupplierEntity> _suppliers = <SupplierEntity>[];

  @override
  void initState() {
    super.initState();
    _suppliers = widget.suppliers;
    _dataSource = _SuppliersDataSource(
      context: context,
      suppliers: _suppliers,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuppliersBloc, SuppliersState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case SuppliersFetchingDoneState:
            {
              _dataSource = _SuppliersDataSource(
                context: context,
                suppliers: state.suppliers!,
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
                    width: 15.w(context),
                    child: const TextBox(),
                  ),
                  const SizedBox(width: 8),
                  Button(
                    onPressed: () {},
                    child: const Text('Rechercher des fournisseurs'),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text('${_suppliers.length} éléments'),
              const SizedBox(height: 16),
              KDataGrid(
                dataSource: _dataSource,
                columns: _buildColumns(context),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SuppliersDataSource extends DataGridSource {
  _SuppliersDataSource({
    required this.context,
    required this.suppliers,
  }) {
    dataGridRows = suppliers
        .map<DataGridRow>((supplier) => DataGridRow(cells: [
              DataGridCell<int>(columnName: '#', value: supplier.id),
              DataGridCell<String>(
                  columnName: 'denomination', value: supplier.denomination),
              DataGridCell<String>(
                  columnName: 'type', value: '${supplier.type}\n'),
              DataGridCell<String>(
                  columnName: 'phone_number',
                  value: supplier.phoneNumber ?? '—'),
              DataGridCell<String>(
                  columnName: 'email', value: supplier.email ?? '—'),
              const DataGridCell<Widget>(columnName: 'action', value: null),
            ]))
        .toList();
  }

  final BuildContext context;
  final List<SupplierEntity> suppliers;

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
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => SupplierDialog(
                      supplier: suppliers[index],
                      details: true,
                    ),
                  ),
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
