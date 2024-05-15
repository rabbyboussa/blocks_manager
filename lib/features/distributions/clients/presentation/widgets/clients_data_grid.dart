import 'package:blocks/config/theme/theme.dart';
import 'package:blocks/core/presentation/widgets/k_data_grid.dart';
import 'package:blocks/features/distributions/clients/domain/entities/client_entity.dart';
import 'package:blocks/features/distributions/clients/presentation/bloc/clients/clients_bloc.dart';
import 'package:blocks/features/distributions/clients/presentation/widgets/client_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ClientsDataGrid extends StatefulWidget {
  const ClientsDataGrid({
    super.key,
    required this.clients,
  });

  final List<ClientEntity> clients;

  @override
  State<ClientsDataGrid> createState() => _ClientsDataGridState();
}

class _ClientsDataGridState extends State<ClientsDataGrid> {
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

  late _ClientsDataSource _dataSource;
  List<ClientEntity> _clients = <ClientEntity>[];

  @override
  void initState() {
    super.initState();
    _clients = widget.clients;
    _dataSource = _ClientsDataSource(
      context: context,
      clients: _clients,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientsBloc, ClientsState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case ClientsFetchingDoneState:
            {
              _dataSource = _ClientsDataSource(
                context: context,
                clients: state.clients!,
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
                    child: const Text('Rechercher des clients'),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text('${_clients.length} éléments'),
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

class _ClientsDataSource extends DataGridSource {
  _ClientsDataSource({
    required this.context,
    required this.clients,
  }) {
    dataGridRows = clients
        .map<DataGridRow>((client) => DataGridRow(cells: [
              DataGridCell<int>(columnName: '#', value: client.id),
              DataGridCell<String>(
                  columnName: 'denomination', value: client.denomination),
              DataGridCell<String>(
                  columnName: 'type', value: '${client.type}\n'),
              DataGridCell<String>(
                  columnName: 'phone_number', value: client.phoneNumber ?? '—'),
              DataGridCell<String>(
                  columnName: 'email', value: client.email ?? '—'),
              const DataGridCell<Widget>(columnName: 'action', value: null),
            ]))
        .toList();
  }

  final BuildContext context;
  final List<ClientEntity> clients;

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
                    builder: (context) => ClientDialog(
                      client: clients[index],
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
