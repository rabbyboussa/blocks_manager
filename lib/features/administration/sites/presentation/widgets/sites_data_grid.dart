import 'package:blocks/config/theme/theme.dart';
import 'package:blocks/core/presentation/widgets/k_data_grid.dart';
import 'package:blocks/features/administration/sites/domain/entities/site_entity.dart';
import 'package:blocks/features/administration/sites/presentation/bloc/sites/sites_bloc.dart';
import 'package:blocks/features/administration/sites/presentation/widgets/site_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SitesDataGrid extends StatefulWidget {
  const SitesDataGrid({
    super.key,
    required this.sites,
  });

  final List<SiteEntity> sites;

  @override
  State<SitesDataGrid> createState() => _SitesDataGridState();
}

class _SitesDataGridState extends State<SitesDataGrid> {
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
        columnName: 'status',
        width: 12.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Statut',
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

  late _SitesDataSource _dataSource;
  List<SiteEntity> _sites = <SiteEntity>[];

  @override
  void initState() {
    super.initState();
    _sites = widget.sites;
    _dataSource = _SitesDataSource(
      context: context,
      sites: _sites,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SitesBloc, SitesState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case SitesFetchingDoneState:
            {
              _dataSource = _SitesDataSource(
                context: context,
                sites: state.sites!,
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
                    child: const Text('Rechercher des sites'),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text('${_sites.length} éléments'),
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

class _SitesDataSource extends DataGridSource {
  _SitesDataSource({
    required this.context,
    required this.sites,
  }) {
    dataGridRows = sites
        .map<DataGridRow>((site) => DataGridRow(cells: [
              DataGridCell<int>(columnName: '#', value: site.id),
              DataGridCell<String>(
                  columnName: 'denomination', value: '${site.name}\n'),
              DataGridCell<String>(
                columnName: 'status',
                value: site.active == 1 ? 'Active' : 'Inactive',
              ),
              DataGridCell<String>(
                  columnName: 'phone_number', value: site.phoneNumber ?? '—'),
              DataGridCell<String>(
                  columnName: 'email', value: site.email ?? '—'),
              const DataGridCell<Widget>(columnName: 'action', value: null),
            ]))
        .toList();
  }

  final BuildContext context;
  final List<SiteEntity> sites;

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
                    builder: (context) => SiteDialog(
                      site: sites[index],
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
