import 'package:blocks/config/theme/theme.dart';
import 'package:blocks/core/presentation/widgets/k_data_grid.dart';
import 'package:blocks/features/administration/accounts/domain/entities/account_entity.dart';
import 'package:blocks/features/administration/accounts/domain/entities/role_entity.dart';
import 'package:blocks/features/administration/accounts/presentation/bloc/accounts/accounts_bloc.dart';
import 'package:blocks/features/administration/accounts/presentation/widgets/edit_account_dialog.dart';
import 'package:blocks/features/administration/employees/domain/entities/employee_entity.dart';
import 'package:blocks/features/distributions/clients/domain/entities/client_entity.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AccountsDataGrid extends StatefulWidget {
  const AccountsDataGrid({
    super.key,
    required this.employees,
    required this.clients,
    required this.accounts,
    required this.roles,
  });

  final List<EmployeeEntity> employees;
  final List<ClientEntity> clients;
  final List<AccountEntity> accounts;
  final List<RoleEntity> roles;

  @override
  State<AccountsDataGrid> createState() => _AccountsDataGridState();
}

class _AccountsDataGridState extends State<AccountsDataGrid> {
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
        columnName: 'username',
        minimumWidth: 12.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Nom d\'utilisateur',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'password',
        width: 12.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Mot de passe',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'type',
        width: 6.w(context),
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
        columnName: 'employee',
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Employé',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'role',
        width: 12.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Rôle',
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

  late _AccountsDataSource _dataSource;
  List<EmployeeEntity> _employees = [];
  List<ClientEntity> _clients = [];
  List<AccountEntity> _accounts = [];
  List<RoleEntity> _roles = [];

  @override
  void initState() {
    super.initState();

    _employees = widget.employees;
    _clients = widget.clients;
    _accounts = widget.accounts;
    _roles = widget.roles;

    _dataSource = _AccountsDataSource(
      context: context,
      accounts: _accounts,
      roles: _roles,
      employees: _employees,
      clients: _clients,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountsBloc, AccountsState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case AccountsFetchingDoneState:
            {
              _dataSource = _AccountsDataSource(
                context: context,
                accounts: state.accounts!,
                roles: state.roles!,
                employees: state.employees!,
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
                    width: 20.w(context),
                    child: TextBox(controller: _searchController),
                  ),
                  const SizedBox(width: 8),
                  Button(
                    onPressed: () {
                      List<AccountEntity> accounts = List.from(state.accounts!);

                      accounts.retainWhere((account) => account
                          .toString()
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()));

                      _dataSource = _AccountsDataSource(
                        context: context,
                        accounts: accounts,
                        roles: state.roles!,
                        employees: state.employees!,
                        clients: state.clients!,
                      );
                      _dataSource.updateDataGridSource();
                      setState(() {});
                    },
                    child: const Text('Rechercher des matériaux'),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text('${state.accounts!.length} éléments'),
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

class _AccountsDataSource extends DataGridSource {
  _AccountsDataSource({
    required this.context,
    required this.accounts,
    required this.roles,
    required this.employees,
    required this.clients,
  }) {
    dataGridRows = accounts.map<DataGridRow>((account) {
      EmployeeEntity? employee;
      ClientEntity? client;
      RoleEntity? role;
      if (account.employeeId != null) {
        employee =
            employees.firstWhere((element) => element.id == account.employeeId);
        role = roles.firstWhere((element) => element.id == account.roleId);
      } else {
        client =
            clients.firstWhere((element) => element.id == account.clientId);
      }

      return DataGridRow(cells: [
        const DataGridCell<Widget>(columnName: '#', value: null),
        DataGridCell<String>(columnName: 'username', value: account.username),
        DataGridCell<String>(columnName: 'password', value: account.password),
        DataGridCell<String>(columnName: 'type', value: account.type),
        DataGridCell<String>(
            columnName: 'client',
            value: client != null
                ? '${client.denomination}\n'
                : '—'),
        DataGridCell<String>(
            columnName: 'employee',
            value: employee != null
                ? '${employee.lastname} ${employee.firstname}\n'
                : '—'),
        DataGridCell<String>(
            columnName: 'role', value: role != null ? role.name : '—'),
        const DataGridCell<String>(columnName: 'action', value: null),
      ]);
    }).toList();
  }

  final BuildContext context;
  final List<AccountEntity> accounts;
  final List<RoleEntity> roles;
  final List<EmployeeEntity> employees;
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
                  child: const Text('Modifier'),
                  onPressed: () async => await showDialog(
                    context: context,
                    builder: (context) => EditAccountDialog(
                      account: accounts[index],
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
