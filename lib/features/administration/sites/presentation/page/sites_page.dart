import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/features/administration/accounts/presentation/bloc/accounts/accounts_bloc.dart';
import 'package:blocks/features/administration/accounts/presentation/widgets/accounts_data_grid.dart';
import 'package:blocks/features/administration/accounts/presentation/widgets/edit_account_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  @override
  void initState() {
    super.initState();

    context.read<AccountsBloc>().add(FetchAccountsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountsBloc, AccountsState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case AccountsFetchingLoadingState:
            {
              return const Center(
                child: ProgressRing(
                  activeColor: kBrown,
                ),
              );
            }
          case AccountsFetchingDoneState:
            {
              return ScaffoldPage.scrollable(
                header: PageHeader(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Comptes utilisateurs'),
                      Row(
                        children: [
                          Button(
                            onPressed: () => context
                                .read<AccountsBloc>()
                                .add(FetchAccountsEvent()),
                            child: const Text('Rafraîchir la page'),
                          ),
                          const SizedBox(width: 8),
                          FilledButton(
                            child: const Text('Ajouter un compte'),
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => const EditAccountDialog(),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                children: [
                  const SizedBox(height: 16),
                  AccountsDataGrid(
                    accounts: state.accounts!,
                    roles: state.roles!,
                    employees: state.employees!,
                    clients: state.clients!,
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
