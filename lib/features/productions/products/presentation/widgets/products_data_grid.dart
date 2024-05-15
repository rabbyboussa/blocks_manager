import 'package:blocks/config/theme/theme.dart';
import 'package:blocks/core/presentation/widgets/k_data_grid.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:blocks/features/productions/products/presentation/bloc/products/products_bloc.dart';
import 'package:blocks/features/productions/products/presentation/widgets/edit_product_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductsDataGrid extends StatefulWidget {
  const ProductsDataGrid({
    super.key,
    required this.products,
  });

  final List<ProductEntity> products;

  @override
  State<ProductsDataGrid> createState() => _ProductsDataGridState();
}

class _ProductsDataGridState extends State<ProductsDataGrid> {
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
        minimumWidth: 16.w(context),
        allowSorting: false,
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
        columnName: 'description',
        columnWidthMode: ColumnWidthMode.fill,
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
        columnName: 'dimensions',
        width: 16.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Dimensions',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'weight',
        width: 4.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Poids',
            style: gridColumnTextStyle,
          ),
        ),
      ),
      GridColumn(
        columnName: 'unitPrice',
        width: 8.w(context),
        allowSorting: false,
        autoFitPadding: const EdgeInsets.all(12),
        label: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Prix unitaire',
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

  late _ProductsDataSource _dataSource;
  List<ProductEntity> _products = <ProductEntity>[];

  @override
  void initState() {
    super.initState();
    _products = widget.products;
    _dataSource = _ProductsDataSource(
      context: context,
      products: _products,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case ProductsFetchingDoneState:
            {
              _dataSource = _ProductsDataSource(
                context: context,
                products: state.products!,
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
                    child: TextBox(controller: _searchController),
                  ),
                  const SizedBox(width: 8),
                  Button(
                    onPressed: () {
                      List<ProductEntity> products = List.from(state.products!);

                      products.retainWhere((product) => product
                          .toString()
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()));

                      _dataSource = _ProductsDataSource(
                        context: context,
                        products: products,
                      );
                      _dataSource.updateDataGridSource();
                      setState(() {});
                    },
                    child: const Text('Rechercher des produits'),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text('${_products.length} éléments'),
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

class _ProductsDataSource extends DataGridSource {
  _ProductsDataSource({
    required this.context,
    required this.products,
  }) {
    dataGridRows = products
        .map<DataGridRow>((product) => DataGridRow(cells: [
              const DataGridCell<Widget>(columnName: '#', value: null),
              DataGridCell<String>(
                  columnName: 'designation', value: product.designation),
              DataGridCell<String>(
                  columnName: 'description',
                  value: '${product.description ?? '—'}\n\n\n'),
              DataGridCell<String>(
                  columnName: 'dimensions',
                  value:
                      '${product.length}mm x ${product.width}mm x ${product.height}mm'),
              DataGridCell<String>(
                  columnName: 'weight', value: '${product.weight} kg'),
              DataGridCell<String>(
                  columnName: 'unitPrice', value: '${product.unitPrice}'),
              DataGridCell<String>(
                  columnName: 'quantity', value: '${product.quantity}'),
              const DataGridCell<Widget>(columnName: 'action', value: null),
            ]))
        .toList();
  }

  final BuildContext context;
  final List<ProductEntity> products;

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
                            image: products[index].imagePath != null
                                ? DecorationImage(
                                    image: NetworkImage(
                                      products[index].imagePath!,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: products[index].imagePath == null
                              ? Icon(
                                  FluentIcons.file_image,
                                  color: Colors.grey[100],
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Text(products[index].designation)
                  ],
                )
              : dataGridCell.columnName == 'action'
                  ? Button(
                      child: const Text('Modifier'),
                      onPressed: () async => await showDialog(
                        context: context,
                        builder: (context) => EditProductDialog(
                          product: products[index],
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
