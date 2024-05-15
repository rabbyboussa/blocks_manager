import 'package:blocks/config/routes/routes_names.dart';
import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:blocks/features/productions/productions/presentation/bloc/productions/productions_bloc.dart';
import 'package:blocks/features/productions/productions/presentation/widgets/productions_data_grid.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductionsPage extends StatefulWidget {
  const ProductionsPage({super.key});

  @override
  State<ProductionsPage> createState() => _ProductionsPageState();
}

class _ProductionsPageState extends State<ProductionsPage> {
  @override
  void initState() {
    super.initState();

    context.read<ProductionsBloc>().add(FetchProductionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductionsBloc, ProductionsState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case ProductionsFetchingFailedState:
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
          case ProductionsFetchingLoadingState:
            {
              return const Center(
                child: ProgressRing(
                  activeColor: kBrown,
                ),
              );
            }
          case ProductionsFetchingDoneState:
            {
              return ScaffoldPage.scrollable(
                header: PageHeader(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Productions'),
                      Row(
                        children: [
                          Button(
                            onPressed: () => context
                                .read<ProductionsBloc>()
                                .add(FetchProductionsEvent()),
                            child: const Text('Rafraîchir la page'),
                          ),
                          const SizedBox(width: 8),
                          Offstage(
                            offstage: context.read<AuthenticationBloc>().state.account!.roleId == 4 ,
                            child: FilledButton(
                              child: const Text('Ajouter une production'),
                              onPressed: () => context
                                  .pushNamed(RoutesNames.productionCreation),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                children: [
                  const SizedBox(height: 16),
                  ProductionsDataGrid(productions: state.productions!)
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
