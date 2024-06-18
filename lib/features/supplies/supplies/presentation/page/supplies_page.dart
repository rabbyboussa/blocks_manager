import 'package:blocks/config/routes/routes_names.dart';
import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:blocks/features/supplies/supplies/presentation/bloc/suppliers/supplies_bloc.dart';
import 'package:blocks/features/supplies/supplies/presentation/widgets/supplies_data_grid.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SuppliesPage extends StatefulWidget {
  const SuppliesPage({super.key});

  @override
  State<SuppliesPage> createState() => _SuppliesPageState();
}

class _SuppliesPageState extends State<SuppliesPage> {
  @override
  void initState() {
    super.initState();

    context.read<SuppliesBloc>().add(FetchSuppliesEvent(siteId: context.read<AuthenticationBloc>().state.account!.siteId!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SuppliesBloc, SuppliesState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case SuppliesFetchingFailedState:
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
          case SuppliesFetchingLoadingState:
            {
              return const Center(
                child: ProgressRing(
                  activeColor: kBrown,
                ),
              );
            }
          case SuppliesFetchingDoneState:
            {
              return ScaffoldPage.scrollable(
                header: PageHeader(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Approvisionnements'),
                      Row(
                        children: [
                          Button(
                            onPressed: () => context
                                .read<SuppliesBloc>()
                                .add(FetchSuppliesEvent(siteId: context.read<AuthenticationBloc>().state.account!.siteId!)),
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
                              child: const Text('Ajouter un approvisionnement'),
                              onPressed: () =>
                                  context.pushNamed(RoutesNames.supplyCreation),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                children: [
                  const SizedBox(height: 16),
                  SuppliesDataGrid(supplies: state.supplies!)
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
