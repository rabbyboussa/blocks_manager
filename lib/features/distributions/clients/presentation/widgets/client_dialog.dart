import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/bloc/image_picker/image_picker_bloc.dart';
import 'package:blocks/core/presentation/widgets/k_textfield_with_description.dart';
import 'package:blocks/features/distributions/clients/domain/entities/client_entity.dart';
import 'package:blocks/features/distributions/clients/presentation/bloc/clients/clients_bloc.dart';
import 'package:blocks/features/distributions/clients/presentation/bloc/edit_client/edit_client_bloc.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ClientDialog extends StatefulWidget {
  const ClientDialog({
    super.key,
    this.client,
    this.details = false,
  });

  final ClientEntity? client;
  final bool details;

  @override
  State<ClientDialog> createState() => _ClientDialogState();
}

class _ClientDialogState extends State<ClientDialog> {
  ClientEntity? _client;

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
      _client = widget.client;
      _edition = false;

      _denominationController.text = _client!.denomination;
      _type = _client!.type;
      if (_client!.address != null) {
        _addressController.text = _client!.address!;
      }
      if (_client!.city != null) {
        _cityController.text = _client!.city!;
      }
      if (_client!.country != null) {
        _countryController.text = _client!.country!;
      }
      if (_client!.phoneNumber != null) {
        _phoneNumberController.text = _client!.phoneNumber!;
      }
      if (_client!.email != null) {
        _emailController.text = _client!.email!;
      }
      if (_client!.fax != null) {
        _faxController.text = _client!.fax!;
      }
      if (_client!.website != null) {
        _websiteController.text = _client!.website!;
      }
      if (_client!.notes != null) {
        _notesController.text = _client!.notes!;
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
    return BlocConsumer<EditClientBloc, EditClientState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case EditClientLoadingState:
            {
              showProgressDialog(
                context,
                message: 'Veuillez patienter...',
              );
            }
          case EditClientFailedState:
            {
              final failedState = state as EditClientFailedState;
              context.pop();
              showInfoBar(
                context,
                title: 'Une erreur est survenue',
                message: failedState.message,
                severity: InfoBarSeverity.error,
              );
            }
          case EditClientDoneState:
            {
              final doneState = state as EditClientDoneState;
              if (doneState.modification) {
                context
                    .read<ClientsBloc>()
                    .add(ClientUpdatedEvent(client: doneState.client));

                showInfoBar(
                  context,
                  title: 'Opération réussie',
                  message: 'Client modifié avec succès.',
                  severity: InfoBarSeverity.success,
                );
              } else {
                context
                    .read<ClientsBloc>()
                    .add(ClientAddedEvent(client: doneState.client));

                showInfoBar(
                  context,
                  title: 'Opération réussie',
                  message: 'Nouveau client ajouté avec succès.',
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
                          const Text('Fiche client'),
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
                    : const Text('Ajouter un client'),
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
                            'Entreprise',
                            'Particulier',
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
                                _client = _client!.copyWith(
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
                                _client = ClientEntity(
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

                              context.read<EditClientBloc>().add(
                                    EditEvent(
                                      client: _client!,
                                      modification: widget.details,
                                    ),
                                  );
                            }
                          },
                          child: Text(
                            widget.details
                                ? 'Mettre à jour'
                                : 'Ajouter un client',
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
