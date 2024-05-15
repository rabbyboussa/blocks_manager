import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/bloc/image_picker/image_picker_bloc.dart';
import 'package:blocks/core/presentation/widgets/k_image_picker.dart';
import 'package:blocks/core/presentation/widgets/k_textfield_with_description.dart';
import 'package:blocks/features/administration/employees/domain/entities/employee_entity.dart';
import 'package:blocks/features/administration/employees/presentation/bloc/edit_employee/edit_employee_bloc.dart';
import 'package:blocks/features/administration/employees/presentation/bloc/employees/employees_bloc.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmployeeDialog extends StatefulWidget {
  const EmployeeDialog({
    super.key,
    this.employee,
    this.details = false,
  });

  final EmployeeEntity? employee;
  final bool details;

  @override
  State<EmployeeDialog> createState() => _EmployeeDialogState();
}

class _EmployeeDialogState extends State<EmployeeDialog> {
  EmployeeEntity? _employee;

  bool _edition = true;

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  DateTime? _birthdate;
  final TextEditingController _birthplaceController = TextEditingController();
  String? _genre;
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _functionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _faxController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.details) {
      _employee = widget.employee;
      _edition = false;

      _firstnameController.text = _employee!.firstname;
      _lastnameController.text = _employee!.lastname;
      _birthdate = DateTime.parse(_employee!.birthdate);
      if (_employee!.birthplace != null) {
        _birthplaceController.text = _employee!.birthplace!;
      }
      _genre = _employee!.genre == 0 ? 'Femme' : 'Homme';
      _nationalityController.text = _employee!.nationality;
      _functionController.text = _employee!.function;
      if (_employee!.address != null) {
        _addressController.text = _employee!.address!;
      }
      if (_employee!.city != null) {
        _cityController.text = _employee!.city!;
      }
      if (_employee!.country != null) {
        _countryController.text = _employee!.country!;
      }
      if (_employee!.phoneNumber != null) {
        _phoneNumberController.text = _employee!.phoneNumber!;
      }
      if (_employee!.email != null) {
        _emailController.text = _employee!.email!;
      }
      if (_employee!.fax != null) {
        _faxController.text = _employee!.fax!;
      }

      context
          .read<ImagePickerBloc>()
          .add(PickImageEvent(imagePath: widget.employee!.imagePath ?? ''));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _birthplaceController.dispose();
    _nationalityController.dispose();
    _functionController.dispose();
    _cityController.dispose();
    _countryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditEmployeeBloc, EditEmployeeState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case EditEmployeeLoadingState:
            {
              showProgressDialog(
                context,
                message: 'Veuillez patienter...',
              );
            }
          case EditEmployeeFailedState:
            {
              final failedState = state as EditEmployeeFailedState;
              context.pop();
              showInfoBar(
                context,
                title: 'Une erreur est survenue',
                message: failedState.message,
                severity: InfoBarSeverity.error,
              );
            }
          case EditEmployeeDoneState:
            {
              context.read<ImagePickerBloc>().add(ResetImagePickerEvent());
              _firstnameController.clear();

              final doneState = state as EditEmployeeDoneState;
              if (doneState.modification) {
                context
                    .read<EmployeesBloc>()
                    .add(EmployeeUpdatedEvent(employee: doneState.employee));

                showInfoBar(
                  context,
                  title: 'Opération réussie',
                  message: 'Employé modifié avec succès.',
                  severity: InfoBarSeverity.success,
                );
              } else {
                context
                    .read<EmployeesBloc>()
                    .add(EmployeeAddedEvent(employee: doneState.employee));

                showInfoBar(
                  context,
                  title: 'Opération réussie',
                  message: 'Nouvel employé ajouté avec succès.',
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
          constraints: const BoxConstraints(maxWidth: 600),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: widget.details
                    ? Row(
                        children: [
                          const Text('Fiche employé'),
                          const SizedBox(width: 8),
                          Offstage(
                            offstage: _edition,
                            child: IconButton(
                                icon: const Icon(FluentIcons.edit),
                                onPressed: () => setState(() {
                                      _edition = true;
                                    })),
                          )
                        ],
                      )
                    : const Text('Ajouter un employé'),
              ),
              IconButton(
                icon: const Icon(FluentIcons.chrome_close),
                onPressed: () {
                  context.read<ImagePickerBloc>().add(ResetImagePickerEvent());
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Image'),
                          const SizedBox(height: 8),
                          KImagePicker(edition: _edition),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          SizedBox(
                            width: 276,
                            child: KInputFieldWithDescription(
                              label: 'Prénom',
                              isMandatory: true,
                              inputWidget: TextBox(
                                controller: _firstnameController,
                                readOnly: !_edition,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 276,
                            child: KInputFieldWithDescription(
                              label: 'Nom',
                              isMandatory: true,
                              inputWidget: TextBox(
                                controller: _lastnameController,
                                readOnly: !_edition,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          SizedBox(
                            width: 276,
                            child: KInputFieldWithDescription(
                              label: 'Date de naissance',
                              isMandatory: true,
                              inputWidget: DatePicker(
                                selected: _birthdate,
                                onChanged: !_edition
                                    ? null
                                    : (date) {
                                        setState(() {
                                          _birthdate = date;
                                        });
                                      },
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 276,
                            child: KInputFieldWithDescription(
                              label: 'Lieu de naissance',
                              inputWidget: TextBox(
                                controller: _birthplaceController,
                                readOnly: !_edition,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          SizedBox(
                            width: 276,
                            child: KInputFieldWithDescription(
                              label: 'Genre',
                              isMandatory: true,
                              inputWidget: ComboBox<String>(
                                value: _genre,
                                items: ['Femme', 'Homme']
                                    .map((e) => ComboBoxItem<String>(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                placeholder:
                                    const Text('Sélectionnez le genre'),
                                isExpanded: true,
                                onChanged: !_edition
                                    ? null
                                    : (genre) {
                                        setState(() {
                                          _genre = genre;
                                        });
                                      },
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 276,
                            child: KInputFieldWithDescription(
                              label: 'Nationalité',
                              isMandatory: true,
                              inputWidget: TextBox(
                                controller: _nationalityController,
                                readOnly: !_edition,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      KInputFieldWithDescription(
                        label: 'Fonction',
                        isMandatory: true,
                        inputWidget: TextBox(
                          controller: _functionController,
                          readOnly: !_edition,
                        ),
                      ),
                      const SizedBox(height: 16),
                      KInputFieldWithDescription(
                        label: 'Adresse',
                        inputWidget: TextBox(
                          controller: _addressController,
                          readOnly: !_edition,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          SizedBox(
                            width: 276,
                            child: KInputFieldWithDescription(
                              label: 'Ville',
                              inputWidget: TextBox(
                                controller: _cityController,
                                readOnly: !_edition,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 276,
                            child: KInputFieldWithDescription(
                              label: 'Pays',
                              inputWidget: TextBox(
                                controller: _countryController,
                                readOnly: !_edition,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      KInputFieldWithDescription(
                        label: 'Numéro de téléphone',
                        inputWidget: TextBox(
                          controller: _phoneNumberController,
                          readOnly: !_edition,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          SizedBox(
                            width: 276,
                            child: KInputFieldWithDescription(
                              label: 'Email',
                              inputWidget: TextBox(
                                controller: _emailController,
                                readOnly: !_edition,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 276,
                            child: KInputFieldWithDescription(
                              label: 'Fax',
                              inputWidget: TextBox(
                                controller: _faxController,
                                readOnly: !_edition,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Offstage(
                        offstage: !_edition,
                        child: FilledButton(
                          onPressed: () {
                            if (_firstnameController.text.trim().isEmpty ||
                                _lastnameController.text.trim().isEmpty ||
                                _birthdate == null ||
                                _genre == null ||
                                _nationalityController.text.trim().isEmpty ||
                                _functionController.text.trim().isEmpty) {
                              showInfoBar(
                                context,
                                title: 'Attention',
                                message:
                                    'Veuillez renseigner tous les champs obligatoires avant de poursuivre.',
                                severity: InfoBarSeverity.warning,
                              );
                            } else {
                              if (widget.details) {
                                _employee = _employee!.copyWith(
                                  firstname: _firstnameController.text,
                                  lastname: _lastnameController.text,
                                  genre: _genre == 'Femme' ? 0 : 1,
                                  birthdate: _birthdate.toString(),
                                  birthplace: _birthplaceController.text,
                                  nationality: _nationalityController.text,
                                  function: _functionController.text,
                                  address: _addressController.text,
                                  city: _cityController.text,
                                  country: _countryController.text,
                                  phoneNumber: _phoneNumberController.text,
                                  email: _emailController.text,
                                  fax: _faxController.text,
                                  imagePath: context
                                      .read<ImagePickerBloc>()
                                      .state
                                      .imagePath,
                                );
                              } else {
                                _employee = EmployeeEntity(
                                  firstname: _firstnameController.text,
                                  lastname: _lastnameController.text,
                                  genre: _genre == 'Femme' ? 0 : 1,
                                  birthdate: _birthdate.toString(),
                                  birthplace: _birthplaceController.text,
                                  nationality: _nationalityController.text,
                                  function: _functionController.text,
                                  address: _addressController.text,
                                  city: _cityController.text,
                                  country: _countryController.text,
                                  phoneNumber: _phoneNumberController.text,
                                  email: _emailController.text,
                                  fax: _faxController.text,
                                  imagePath: context
                                      .read<ImagePickerBloc>()
                                      .state
                                      .imagePath,
                                );
                              }

                              context.read<EditEmployeeBloc>().add(
                                    EditEvent(
                                      employee: _employee!,
                                      modification: widget.details,
                                    ),
                                  );
                            }
                          },
                          child: Text(
                            widget.details
                                ? 'Mettre à jour'
                                : 'Ajouter un employé',
                          ),
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
