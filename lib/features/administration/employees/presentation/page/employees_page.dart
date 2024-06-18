import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/bloc/image_picker/image_picker_bloc.dart';
import 'package:blocks/features/administration/employees/presentation/bloc/employees/employees_bloc.dart';
import 'package:blocks/features/administration/employees/presentation/widgets/employee_dialog.dart';
import 'package:blocks/features/administration/employees/presentation/widgets/employees_data_grid.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  @override
  void initState() {
    super.initState();

    context.read<ImagePickerBloc>().add(ResetImagePickerEvent());
    context.read<EmployeesBloc>().add(FetchEmployeesEvent(
        siteId: context.read<AuthenticationBloc>().state.account!.siteId!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeesBloc, EmployeesState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case EmployeesFetchingLoadingState:
            {
              return const Center(
                child: ProgressRing(
                  activeColor: kBrown,
                ),
              );
            }
          case EmployeesFetchingDoneState:
            {
              return ScaffoldPage.scrollable(
                header: PageHeader(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Employés'),
                      Row(
                        children: [
                          Button(
                            onPressed: () => context.read<EmployeesBloc>().add(
                                FetchEmployeesEvent(
                                    siteId: context
                                        .read<AuthenticationBloc>()
                                        .state
                                        .account!
                                        .siteId!)),
                            child: const Text('Rafraîchir la page'),
                          ),
                          const SizedBox(width: 8),
                          FilledButton(
                            child: const Text('Ajouter un employé'),
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => const EmployeeDialog(),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                children: [
                  const SizedBox(height: 16),
                  EmployeesDataGrid(employees: state.employees!)
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
