import 'package:blocks/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class KDataGrid extends StatelessWidget {
  const KDataGrid({
    super.key,
    required this.dataSource,
    required this.columns,
    this.showCheckboxColumn = false,
  });

  final DataGridSource dataSource;
  final List<GridColumn> columns;
  final bool showCheckboxColumn;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SfDataGridTheme(
        data: SfDataGridThemeData(
          headerColor: kBrown.withAlpha(240),
          sortIconColor: kWhite,
        ),
        child: SfDataGrid(
          source: dataSource,
          allowSorting: true,
          showCheckboxColumn: showCheckboxColumn,
          checkboxColumnSettings: const DataGridCheckboxColumnSettings(
            backgroundColor: Color.fromARGB(15, 0, 0, 0),
            showCheckboxOnHeader: false,
          ),
          selectionMode: SelectionMode.multiple,
          isScrollbarAlwaysShown: true,
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
          onQueryRowHeight: (details) =>
              details.getIntrinsicRowHeight(details.rowIndex),
          columns: columns,
        ),
      ),
    );
  }
}
