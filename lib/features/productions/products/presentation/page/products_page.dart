import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/bloc/image_picker/image_picker_bloc.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:blocks/features/productions/products/presentation/bloc/products/products_bloc.dart';
import 'package:blocks/features/productions/products/presentation/widgets/edit_product_dialog.dart';
import 'package:blocks/features/productions/products/presentation/widgets/products_data_grid.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();

    context.read<ImagePickerBloc>().add(ResetImagePickerEvent());
    context.read<ProductsBloc>().add(FetchProductsEvent(
        siteId: context.read<AuthenticationBloc>().state.account!.siteId!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case ProductsFetchingFailedState:
            {
              showInfoBar(
                context,
                title: 'Une erreur est survenue',
                message: state.message!,
                severity: InfoBarSeverity.error,
              );
            }
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ProductsFetchingLoadingState:
            {
              return const Center(
                child: ProgressRing(
                  activeColor: kBrown,
                ),
              );
            }
          case ProductsFetchingDoneState:
            {
              return ScaffoldPage.scrollable(
                header: PageHeader(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Produits'),
                      Row(
                        children: [
                          Button(
                            onPressed: () => context.read<ProductsBloc>().add(
                                FetchProductsEvent(
                                    siteId: context
                                        .read<AuthenticationBloc>()
                                        .state
                                        .account!
                                        .siteId!)),
                            child: const Text('Rafraîchir la page'),
                          ),
                          const SizedBox(width: 8),
                          Offstage(
                            offstage: context
                                    .read<AuthenticationBloc>()
                                    .state
                                    .account!
                                    .roleId ==
                                4,
                            child: FilledButton(
                              child: const Text('Ajouter un produit'),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => const EditProductDialog(),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                children: [
                  const SizedBox(height: 16),
                  ProductsDataGrid(products: state.products!),
                ],
              );
            }
          default:
            return const SizedBox();
        }
      },
    );
  }
}
