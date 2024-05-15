import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/bloc/image_picker/image_picker_bloc.dart';
import 'package:blocks/core/presentation/widgets/k_textfield_with_description.dart';
import 'package:blocks/features/supplies/suppliers/domain/entities/supplier_entity.dart';
import 'package:blocks/features/supplies/suppliers/presentation/bloc/edit_supplier/edit_supplier_bloc.dart';
import 'package:blocks/features/supplies/suppliers/presentation/bloc/suppliers/suppliers_bloc.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SupplierDialog extends StatefulWidget {
  const SupplierDialog({
    super.key,
    this.supplier,
    this.details = false,
  });

  final SupplierEntity? supplier;
  final bool details;

  @override
  State<SupplierDialog> createState() => _SupplierDialogState();
}

class _SupplierDialogState extends State<SupplierDialog> {
  SupplierEntity? _supplier;

  bool _edition = true;

  final TextEditingController _denominationController = TextEditingController();
  String? _type;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _faxController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.details) {
      _supplier = widget.supplier;
      _edition = false;

      _denominationController.text = _supplier!.denomination;
      _type = _supplier!.type;
      if (_supplier!.address != null) {
        _addressController.text = _supplier!.address!;
      }
      if (_supplier!.city != null) {
        _cityController.text = _supplier!.city!;
      }
      if (_supplier!.country != null) {
        _countryController.text = _supplier!.country!;
      }
      if (_supplier!.phoneNumber != null) {
        _phoneNumberController.text = _supplier!.phoneNumber!;
      }
      if (_supplier!.email != null) {
        _emailController.text = _supplier!.email!;
      }
      if (_supplier!.fax != null) {
        _faxController.text = _supplier!.fax!;
      }
      if (_supplier!.website != null) {
        _websiteController.text = _supplier!.website!;
      }
      if (_supplier!.notes != null) {
        _notesController.text = _supplier!.notes!;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _denominationController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _faxController.dispose();
    _websiteController.dispose();
    _notesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditSupplierBloc, EditSupplierState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case EditSupplierLoadingState:
            {
              showProgressDialog(
                context,
                message: 'Veuillez patienter...',
              );
            }
          case EditSupplierFailedState:
            {
              final failedState = state as EditSupplierFailedState;
              context.pop();
              showInfoBar(
                context,
                title: 'Une erreur est survenue',
                message: failedState.message,
                severity: InfoBarSeverity.error,
              );
            }
          case EditSupplierDoneState:
            {
              context.read<ImagePickerBloc>().add(ResetImagePickerEvent());

              final doneState = state as EditSupplierDoneState;
              if (doneState.modification) {
                context
                    .read<SuppliersBloc>()
                    .add(SupplierUpdatedEvent(supplier: doneState.supplier));

                showInfoBar(
                  context,
                  title: 'Opération réussie',
                  message: 'Fournisseur modifié avec succès.',
                  severity: InfoBarSeverity.success,
                );
              } else {
                context
                    .read<SuppliersBloc>()
                    .add(SupplierAddedEvent(supplier: doneState.supplier));

                showInfoBar(
                  context,
                  title: 'Opération réussie',
                  message: 'Nouveau fournisseur ajouté avec succès.',
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
                          const Text('Fiche fournisseur'),
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
                    : const Text('Ajouter un fournisseur'),
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
                      const SizedBox(height: 16),
                      KInputFieldWithDescription(
                        label: 'Dénomination',
                        isMandatory: true,
                        inputWidget: TextBox(
                          controller: _denominationController,
                          readOnly: !_edition,
                        ),
                      ),
                      const SizedBox(height: 16),
                      KInputFieldWithDescription(
                        label: 'Type',
                        isMandatory: true,
                        inputWidget: ComboBox<String>(
                          value: _type,
                          items: [
                            'Grossiste',
                            'Détaillant',
                            'Prestataire',
                            'Sous-traitant',
                            'Centrale d\'achat',
                          ]
                              .map((e) => ComboBoxItem<String>(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          placeholder: const Text('Sélectionnez le type'),
                          isExpanded: true,
                          onChanged: !_edition
                              ? null
                              : (type) {
                                  setState(() {
                                    _type = type;
                                  });
                                },
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
                      const SizedBox(height: 16),
                      KInputFieldWithDescription(
                        label: 'Notes',
                        inputWidget: TextBox(
                          controller: _notesController,
                          readOnly: !_edition,
                          maxLines: 5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Offstage(
                        offstage: !_edition,
                        child: FilledButton(
                          onPressed: () {
                            if (_denominationController.text.trim().isEmpty ||
                                _type == null) {
                              showInfoBar(
                                context,
                                title: 'Attention',
                                message:
                                    'Veuillez renseigner tous les champs obligatoires avant de poursuivre.',
                                severity: InfoBarSeverity.warning,
                              );
                            } else {
                              if (widget.details) {
                                _supplier = _supplier!.copyWith(
                                  denomination: _denominationController.text,
                                  type: _type,
                                  address: _addressController.text,
                                  city: _cityController.text,
                                  country: _countryController.text,
                                  phoneNumber: _phoneNumberController.text,
                                  email: _emailController.text,
                                  fax: _faxController.text,
                                  website: _websiteController.text,
                                  notes: _notesController.text,
                                );
                              } else {
                                _supplier = SupplierEntity(
                                  denomination: _denominationController.text,
                                  type: _type!,
                                  address: _addressController.text,
                                  city: _cityController.text,
                                  country: _countryController.text,
                                  phoneNumber: _phoneNumberController.text,
                                  email: _emailController.text,
                                  fax: _faxController.text,
                                  website: _websiteController.text,
                                  notes: _notesController.text,
                                );
                              }

                              context.read<EditSupplierBloc>().add(
                                    EditEvent(
                                      supplier: _supplier!,
                                      modification: widget.details,
                                    ),
                                  );
                            }
                          },
                          child: Text(
                            widget.details
                                ? 'Mettre à jour'
                                : 'Ajouter un fournisseur',
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
