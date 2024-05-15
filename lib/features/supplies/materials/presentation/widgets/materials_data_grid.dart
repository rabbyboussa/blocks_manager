import 'package:blocks/config/theme/theme.dart';
import 'package:blocks/core/presentation/widgets/k_data_grid.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:blocks/features/supplies/materials/presentation/bloc/materials/materials_bloc.dart';
import 'package:blocks/features/supplies/materials/presentation/widgets/edit_material_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MaterialsDataGrid extends StatefulWidget {
  const MaterialsDataGrid({
    super.key,
    required this.materials,
  });

  final List<MaterialEntity> materials;

  @override
  State<MaterialsDataGrid> createState() => _MaterialsDataGridState();
}

class _MaterialsDataGridState extends State<MaterialsDataGrid> {
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
        columnName: 'designation',
        minimumWidth: 24.w(context),
        columnWidthMode: ColumnWidthMode.fill,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Désignation',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'quantity',
        width: 6.w(context),
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
        columnName: 'measurement_unit',
        width: 12.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Unité de mesure',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'description',
        width: 20.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Description',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'action',
        width: 8.w(context),
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

  late _MaterialsDataSource _dataSource;
  List<MaterialEntity> _materials = <MaterialEntity>[];

  @override
  void initState() {
    super.initState();
    _materials = widget.materials;
    _dataSource = _MaterialsDataSource(
      context: context,
      materials: _materials,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MaterialsBloc, MaterialsState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case MaterialsFetchingDoneState:
            {
              _dataSource = _MaterialsDataSource(
                context: context,
                materials: state.materials!,
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
                      List<MaterialEntity> materials =
                          List.from(state.materials!);

                      materials.retainWhere((material) => material
                          .toString()
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()));

                      _dataSource = _MaterialsDataSource(
                        context: context,
                        materials: materials,
                      );
                      _dataSource.updateDataGridSource();
                      setState(() {});
                    },
                    child: const Text('Rechercher des matériaux'),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text('${_materials.length} éléments'),
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

class _MaterialsDataSource extends DataGridSource {
  _MaterialsDataSource({
    required this.context,
    required this.materials,
  }) {
    dataGridRows = materials
        .map<DataGridRow>((material) => DataGridRow(cells: [
              const DataGridCell<Widget>(columnName: '#', value: null),
              const DataGridCell<Widget>(
                  columnName: 'designation', value: null),
              DataGridCell<int>(
                  columnName: 'quantity', value: material.quantity),
              DataGridCell<String>(
                  columnName: 'measurement_unit',
                  value: material.measurementUnit),
              DataGridCell<String>(
                  columnName: 'description',
                  value: '${material.description ?? '—'}\n\n\n'),
              const DataGridCell<String>(columnName: 'action', value: null),
            ]))
        .toList();
  }

  final BuildContext context;
  final List<MaterialEntity> materials;

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
          child: dataGridCell.columnName == 'designation'
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: const Color(0xffeceff1),
                            image: materials[index].imagePath != null
                                ? DecorationImage(
                                    image: NetworkImage(
                                      materials[index].imagePath!,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: materials[index].imagePath == null
                              ? Icon(
                                  FluentIcons.file_image,
                                  color: Colors.grey[100],
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Text(materials[index].designation)
                  ],
                )
              : dataGridCell.columnName == 'action'
                  ? Button(
                      child: const Text('Modifier'),
                      onPressed: () async => await showDialog(
                        context: context,
                        builder: (context) => EditMaterialDialog(
                          material: materials[index],
                          modification: true,
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
