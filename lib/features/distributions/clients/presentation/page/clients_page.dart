import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:blocks/features/distributions/clients/presentation/bloc/clients/clients_bloc.dart';
import 'package:blocks/features/distributions/clients/presentation/widgets/client_dialog.dart';
import 'package:blocks/features/distributions/clients/presentation/widgets/clients_data_grid.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ClientsBloc>().add(FetchClientsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientsBloc, ClientsState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case ClientsFetchingLoadingState:
            {
              return const Center(
                child: ProgressRing(
                  activeColor: kBrown,
                ),
              );
            }
          case ClientsFetchingDoneState:
            {
              return ScaffoldPage.scrollable(
                header: PageHeader(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Clients'),
                      Row(
                        children: [
                          Button(
                            onPressed: () => context
                                .read<ClientsBloc>()
                                .add(FetchClientsEvent()),
                            child: const Text('Rafraîchir la page'),
                          ),
                          const SizedBox(width: 8),
                          Offstage(
                            offstage: context.read<AuthenticationBloc>().state.account!.roleId == 4 ,
                            child: FilledButton(
                              child: const Text('Ajouter un client'),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => const ClientDialog(),
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
                          child: ClientsDataGrid(
                        clients: state.clients!,
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
