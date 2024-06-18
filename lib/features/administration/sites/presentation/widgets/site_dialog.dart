import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/bloc/image_picker/image_picker_bloc.dart';
import 'package:blocks/core/presentation/widgets/k_textfield_with_description.dart';
import 'package:blocks/features/administration/sites/domain/entities/country_entity.dart';
import 'package:blocks/features/administration/sites/domain/entities/site_entity.dart';
import 'package:blocks/features/administration/sites/presentation/bloc/countries/countries_bloc.dart';
import 'package:blocks/features/administration/sites/presentation/bloc/edit_site/edit_site_bloc.dart';
import 'package:blocks/features/administration/sites/presentation/bloc/sites/sites_bloc.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SiteDialog extends StatefulWidget {
  const SiteDialog({
    super.key,
    this.site,
    this.details = false,
  });

  final SiteEntity? site;
  final bool details;

  @override
  State<SiteDialog> createState() => _SiteDialogState();
}

class _SiteDialogState extends State<SiteDialog> {
  SiteEntity? _site;

  bool _edition = true;

  final TextEditingController _denominationController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _faxController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  List<CountryEntity> countries = [];
  CountryEntity? _selectedCountry;

  @override
  void initState() {
    super.initState();

    countries = context.read<CountriesBloc>().state.countries!;

    _statusController.text = 'Active';

    if (widget.details) {
      _site = widget.site;
      _edition = false;

      _denominationController.text = _site!.name;
      _statusController.text = _site!.active == 1 ? 'Active' : 'Inactive';
      _selectedCountry =
          countries.firstWhere((element) => element.id == _site!.countryId);

      if (_site!.address != null) {
        _addressController.text = _site!.address!;
      }
      if (_site!.city != null) {
        _cityController.text = _site!.city!;
      }

      if (_site!.phoneNumber != null) {
        _phoneNumberController.text = _site!.phoneNumber!;
      }
      if (_site!.email != null) {
        _emailController.text = _site!.email!;
      }
      if (_site!.fax != null) {
        _faxController.text = _site!.fax!;
      }
      if (_site!.website != null) {
        _websiteController.text = _site!.website!;
      }
      if (_site!.notes != null) {
        _notesController.text = _site!.notes!;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _denominationController.dispose();
    _statusController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _faxController.dispose();
    _websiteController.dispose();
    _notesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditSiteBloc, EditSiteState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case EditSiteLoadingState:
            {
              showProgressDialog(
                context,
                message: 'Veuillez patienter...',
              );
            }
          case EditSiteFailedState:
            {
              final failedState = state as EditSiteFailedState;
              context.pop();
              showInfoBar(
                context,
                title: 'Une erreur est survenue',
                message: failedState.message,
                severity: InfoBarSeverity.error,
              );
            }
          case EditSiteDoneState:
            {
              context.read<ImagePickerBloc>().add(ResetImagePickerEvent());

              final doneState = state as EditSiteDoneState;
              if (doneState.modification) {
                context
                    .read<SitesBloc>()
                    .add(SiteUpdatedEvent(site: doneState.site));

                showInfoBar(
                  context,
                  title: 'Opération réussie',
                  message: 'Site modifié avec succès.',
                  severity: InfoBarSeverity.success,
                );
              } else {
                context
                    .read<SitesBloc>()
                    .add(SiteAddedEvent(site: doneState.site));

                showInfoBar(
                  context,
                  title: 'Opération réussie',
                  message: 'Nouveau Site ajouté avec succès.',
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
                          const Text('Fiche Site'),
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
                    : const Text('Ajouter un site'),
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
                        label: 'Statut',
                        inputWidget: TextBox(
                          controller: _statusController,
                          readOnly: true,
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
                              isMandatory: true,
                              inputWidget: ComboBox<CountryEntity>(
                                value: _selectedCountry,
                                items: countries
                                    .map((e) => ComboBoxItem<CountryEntity>(
                                          value: e,
                                          child: Text(e.name),
                                        ))
                                    .toList(),
                                placeholder: const Text('Sélectionnez le pays'),
                                isExpanded: true,
                                onChanged: !_edition
                                    ? null
                                    : (country) {
                                        setState(() {
                                          _selectedCountry = country;
                                        });
                                      },
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
                                _selectedCountry == null) {
                              showInfoBar(
                                context,
                                title: 'Attention',
                                message:
                                    'Veuillez renseigner tous les champs obligatoires avant de poursuivre.',
                                severity: InfoBarSeverity.warning,
                              );
                            } else {
                              if (widget.details) {
                                _site = _site!.copyWith(
                                  name: _denominationController.text,
                                  address: _addressController.text,
                                  city: _cityController.text,
                                  countryId: _selectedCountry!.id!,
                                  phoneNumber: _phoneNumberController.text,
                                  email: _emailController.text,
                                  fax: _faxController.text,
                                  website: _websiteController.text,
                                  notes: _notesController.text,
                                );
                              } else {
                                _site = SiteEntity(
                                  name: _denominationController.text,
                                  address: _addressController.text,
                                  city: _cityController.text,
                                  countryId: _selectedCountry!.id!,
                                  phoneNumber: _phoneNumberController.text,
                                  email: _emailController.text,
                                  fax: _faxController.text,
                                  website: _websiteController.text,
                                  notes: _notesController.text,
                                );
                              }

                              context.read<EditSiteBloc>().add(
                                    EditEvent(
                                      site: _site!,
                                      modification: widget.details,
                                    ),
                                  );
                            }
                          },
                          child: Text(
                            widget.details
                                ? 'Mettre à jour'
                                : 'Ajouter un site',
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
