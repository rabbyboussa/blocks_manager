import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/widgets/k_textfield_with_description.dart';
import 'package:blocks/features/administration/accounts/domain/entities/account_entity.dart';
import 'package:blocks/features/administration/accounts/domain/entities/role_entity.dart';
import 'package:blocks/features/administration/accounts/presentation/bloc/accounts/accounts_bloc.dart';
import 'package:blocks/features/administration/accounts/presentation/bloc/edit_account/edit_account_bloc.dart';
import 'package:blocks/features/administration/employees/domain/entities/employee_entity.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditAccountDialog extends StatefulWidget {
  const EditAccountDialog({
    super.key,
    this.account,
    this.modification = false,
  });

  final AccountEntity? account;
  final bool modification;

  @override
  State<EditAccountDialog> createState() => _EditAccountDialogState();
}

class _EditAccountDialogState extends State<EditAccountDialog> {
  List<EmployeeEntity> _employees = [];
  List<RoleEntity> _roles = [];

  AccountEntity? _account;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  EmployeeEntity? _selectedEmployee;
  RoleEntity? _selectedRole;

  bool obscurePassword = true;

  @override
  void initState() {
    _employees = List.from(context.read<AccountsBloc>().state.employees!);
    _roles = List.from(context.read<AccountsBloc>().state.roles!);
    _roles.removeWhere((element) => element.name == 'Superadmin');

    if (widget.modification) {
      _account = widget.account;
      _selectedEmployee = _employees
          .firstWhere((employee) => employee.id == _account!.employeeId);
      _userNameController.text = widget.account!.username;
      _passwordController.text = widget.account!.password;
      _selectedRole = _roles.firstWhere((role) => role.id == _account!.roleId);
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditAccountBloc, EditAccountState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case EditAccountLoadingState:
            {
              showProgressDialog(
                context,
                message: 'Veuillez patienter...',
              );
            }
          case EditAccountFailedState:
            {
              final failedState = state as EditAccountFailedState;
              context.pop();
              showInfoBar(
                context,
                title: 'Une erreur est survenue',
                message: failedState.message,
                severity: InfoBarSeverity.error,
              );
            }
          case EditAccountDoneState:
            {
              _selectedEmployee = null;
              _userNameController.clear();
              _passwordController.clear();
              _selectedRole = null;

              final doneState = state as EditAccountDoneState;
              if (doneState.modification) {
                context
                    .read<AccountsBloc>()
                    .add(AccountUpdatedEvent(account: doneState.account));

                showInfoBar(
                  context,
                  title: 'Opération réussie',
                  message: 'Compte modifié avec succès.',
                  severity: InfoBarSeverity.success,
                );
              } else {
                context
                    .read<AccountsBloc>()
                    .add(AccountAddedEvent(account: doneState.account));

                showInfoBar(
                  context,
                  title: 'Opération réussie',
                  message: 'Nouveau compte ajouté avec succès.',
                  severity: InfoBarSeverity.success,
                );
              }

              context.pop();
              context.pop();
            }
        }
      },
      builder: (context, state) {
        return ContentDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.modification
                    ? 'Modifier le compte'
                    : 'Ajouter un compte',
              ),
              IconButton(
                icon: const Icon(FluentIcons.chrome_close),
                onPressed: () {
                  context.pop();
                },
              )
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EasyRichText(
                  'Les champs marqués d\'un * sont obligatoires.',
                  patternList: [
                    EasyRichTextPattern(
                      targetString: '*',
                      hasSpecialCharacters: true,
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KInputFieldWithDescription(
                        label: 'Nom d\'utilisateur',
                        isMandatory: true,
                        inputWidget: TextBox(controller: _userNameController),
                      ),
                      const SizedBox(height: 16),
                      KInputFieldWithDescription(
                        label: 'Mot de passe',
                        isMandatory: true,
                        inputWidget: TextBox(
                          controller: _passwordController,
                          obscureText: obscurePassword,
                          suffix: IconButton(
                              icon: Icon(
                                obscurePassword
                                    ? FluentIcons.view
                                    : FluentIcons.hide3,
                                size: 18,
                              ),
                              focusable: false,
                              onPressed: () => setState(
                                  () => obscurePassword = !obscurePassword)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      KInputFieldWithDescription(
                        label: 'Employé',
                        isMandatory: true,
                        inputWidget: ComboBox<EmployeeEntity>(
                          value: _selectedEmployee,
                          items: _employees
                              .map((employee) => ComboBoxItem<EmployeeEntity>(
                                    value: employee,
                                    child: Text(
                                        '${employee.lastname} ${employee.firstname}'),
                                  ))
                              .toList(),
                          placeholder: const Text('Sélectionnez l\'employé'),
                          isExpanded: true,
                          onChanged: (employee) {
                            setState(() {
                              _selectedEmployee = employee;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      KInputFieldWithDescription(
                        label: 'Rôle',
                        isMandatory: true,
                        inputWidget: ComboBox<RoleEntity>(
                          value: _selectedRole,
                          items: _roles
                              .map((role) => ComboBoxItem<RoleEntity>(
                                    value: role,
                                    child: Text(role.name),
                                  ))
                              .toList(),
                          placeholder: const Text('Sélectionnez le rôle'),
                          isExpanded: true,
                          onChanged: (role) {
                            setState(() {
                              _selectedRole = role;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () {
                          if (_userNameController.text.trim().isEmpty ||
                              _passwordController.text.trim().isEmpty ||
                              _selectedEmployee == null ||
                              _selectedRole == null) {
                            showInfoBar(
                              context,
                              title: 'Attention',
                              message:
                                  'Veuillez renseigner tous les champs obligatoires avant de poursuivre.',
                              severity: InfoBarSeverity.warning,
                            );
                          } else {
                            if (widget.modification) {
                              _account = _account?.copyWith(
                                employeeId: _employees
                                    .firstWhere((employee) =>
                                        employee.id == _selectedEmployee!.id)
                                    .id!,
                                username: _userNameController.text,
                                password: _passwordController.text,
                                roleId: _roles
                                    .firstWhere(
                                        (role) => role.id == _selectedRole!.id)
                                    .id!,
                              );
                            } else {
                              _account = AccountEntity(
                                siteId: context.read<AuthenticationBloc>().state.account!.siteId!,
                                type: 'Interne',
                                employeeId: _employees
                                    .firstWhere((employee) =>
                                        employee.id == _selectedEmployee!.id)
                                    .id!,
                                username: _userNameController.text,
                                password: _passwordController.text,
                                roleId: _roles
                                    .firstWhere(
                                        (role) => role.id == _selectedRole!.id)
                                    .id!,
                              );
                            }

                            context.read<EditAccountBloc>().add(
                                  EditEvent(
                                    account: _account!,
                                    modification: widget.modification,
                                  ),
                                );
                          }
                        },
                        child: Text(
                          widget.modification
                              ? 'Mettre à jour'
                              : 'Ajouter un compte',
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
