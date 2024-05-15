import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:blocks/features/supplies/suppliers/presentation/bloc/suppliers/suppliers_bloc.dart';
import 'package:blocks/features/supplies/suppliers/presentation/widgets/supplier_dialog.dart';
import 'package:blocks/features/supplies/suppliers/presentation/widgets/suppliers_data_grid.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuppliersPage extends StatefulWidget {
  const SuppliersPage({super.key});

  @override
  State<SuppliersPage> createState() => _SuppliersPageState();
}

class _SuppliersPageState extends State<SuppliersPage> {
  @override
  void initState() {
    super.initState();
    context.read<SuppliersBloc>().add(FetchSuppliersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuppliersBloc, SuppliersState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case SuppliersFetchingLoadingState:
            {
              return const Center(
                child: ProgressRing(
                  activeColor: kBrown,
                ),
              );
            }
          case SuppliersFetchingDoneState:
            {
              return ScaffoldPage.scrollable(
                header: PageHeader(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Fournisseurs'),
                      Row(
                        children: [
                          Button(
                            onPressed: () => context
                                .read<SuppliersBloc>()
                                .add(FetchSuppliersEvent()),
                            child: const Text('Rafraîchir la page'),
                          ),
                          const SizedBox(width: 8),
                          Offstage(
                            offstage: context.read<AuthenticationBloc>().state.account!.roleId == 4 ,
                            child: FilledButton(
                              child: const Text('Ajouter un fournisseur'),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => const SupplierDialog(),
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: SuppliersDataGrid(
                        suppliers: state.suppliers!,
                      )),
                    ],
                  )
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
