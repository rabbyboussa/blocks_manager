import 'package:blocks/config/routes/routes_names.dart';
import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:blocks/features/distributions/distributions/presentation/bloc/distributions/distributions_bloc.dart';
import 'package:blocks/features/distributions/distributions/presentation/widgets/distributions_data_grid.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DistributionsPage extends StatefulWidget {
  const DistributionsPage({super.key});

  @override
  State<DistributionsPage> createState() => _DistributionsPageState();
}

class _DistributionsPageState extends State<DistributionsPage> {
  @override
  void initState() {
    super.initState();

    context.read<DistributionsBloc>().add(FetchDistributionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DistributionsBloc, DistributionsState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case DistributionsFetchingFailedState:
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
          case DistributionsFetchingLoadingState:
            {
              return const Center(
                child: ProgressRing(
                  activeColor: kBrown,
                ),
              );
            }
          case DistributionsFetchingDoneState:
            {
              return ScaffoldPage.scrollable(
                header: PageHeader(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Distributions'),
                      Row(
                        children: [
                          Button(
                            onPressed: () => context
                                .read<DistributionsBloc>()
                                .add(FetchDistributionsEvent()),
                            child: const Text('Rafraîchir la page'),
                          ),
                          const SizedBox(width: 8),
                          Offstage(
                            offstage: context.read<AuthenticationBloc>().state.account!.roleId == 4 ,
                            child: FilledButton(
                              child: const Text('Ajouter une distribution'),
                              onPressed: () => context
                                  .pushNamed(RoutesNames.distributionCreation),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                children: [
                  const SizedBox(height: 16),
                  DistributionsDataGrid(distributions: state.distributions!)
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
