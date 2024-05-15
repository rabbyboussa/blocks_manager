import 'package:blocks/config/theme/theme.dart';
import 'package:blocks/core/presentation/widgets/k_data_grid.dart';
import 'package:blocks/features/administration/employees/domain/entities/employee_entity.dart';
import 'package:blocks/features/administration/employees/presentation/bloc/employees/employees_bloc.dart';
import 'package:blocks/features/administration/employees/presentation/widgets/employee_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EmployeesDataGrid extends StatefulWidget {
  const EmployeesDataGrid({
    super.key,
    required this.employees,
  });

  final List<EmployeeEntity> employees;

  @override
  State<EmployeesDataGrid> createState() => _EmployeesDataGridState();
}

class _EmployeesDataGridState extends State<EmployeesDataGrid> {
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
        columnName: 'name',
        minimumWidth: 24.w(context),
        columnWidthMode: ColumnWidthMode.fill,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Nom',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'genre',
        width: 6.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Genre',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'nationality',
        width: 12.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Nationalité',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'function',
        width: 16.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Fonction',
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

  late _EmployeesDataSource _dataSource;
  List<EmployeeEntity> _employees = <EmployeeEntity>[];

  @override
  void initState() {
    super.initState();
    _employees = widget.employees;
    _dataSource = _EmployeesDataSource(
      context: context,
      employees: _employees,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeesBloc, EmployeesState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case EmployeesFetchingDoneState:
            {
              _dataSource = _EmployeesDataSource(
                context: context,
                employees: state.employees!,
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
                      List<EmployeeEntity> employees =
                          List.from(state.employees!);

                      employees.retainWhere((material) => material
                          .toString()
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()));

                      _dataSource = _EmployeesDataSource(
                        context: context,
                        employees: employees,
                      );
                      _dataSource.updateDataGridSource();
                      setState(() {});
                    },
                    child: const Text('Rechercher des employés'),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text('${_employees.length} éléments'),
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

class _EmployeesDataSource extends DataGridSource {
  _EmployeesDataSource({
    required this.context,
    required this.employees,
  }) {
    dataGridRows = employees
        .map<DataGridRow>((employee) => DataGridRow(cells: [
              const DataGridCell<Widget>(columnName: '#', value: null),
              const DataGridCell<Widget>(columnName: 'name', value: null),
              DataGridCell<String>(
                  columnName: 'genre',
                  value: employee.genre == 0 ? 'Femme' : 'Homme'),
              DataGridCell<String>(
                  columnName: 'nationality',
                  value: '${employee.nationality}\n\n'),
              DataGridCell<String>(
                  columnName: 'function', value: employee.function),
              const DataGridCell<String>(columnName: 'action', value: null),
            ]))
        .toList();
  }

  final BuildContext context;
  final List<EmployeeEntity> employees;

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      final int index = effectiveRows.indexOf(row);
      final EmployeeEntity employee = employees[index];
      return Container(
          color: index.isEven ? Colors.white : const Color(0xffeceff1),
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(12),
          child: dataGridCell.columnName == 'name'
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
                            image: employees[index].imagePath != null
                                ? DecorationImage(
                                    image: NetworkImage(
                                      employees[index].imagePath!,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: employees[index].imagePath == null
                              ? Icon(
                                  FluentIcons.file_image,
                                  color: Colors.grey[100],
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Text('${employee.lastname} ${employee.firstname}')
                  ],
                )
              : dataGridCell.columnName == 'action'
                  ? Button(
                      child: const Text('Voir les détails'),
                      onPressed: () async => await showDialog(
                        context: context,
                        builder: (context) => EmployeeDialog(
                          employee: employee,
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
