import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/bloc/image_picker/image_picker_bloc.dart';
import 'package:blocks/core/presentation/widgets/k_image_picker.dart';
import 'package:blocks/core/presentation/widgets/k_textfield_with_description.dart';
import 'package:blocks/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:blocks/features/supplies/materials/presentation/bloc/edit_material/edit_material_bloc.dart';
import 'package:blocks/features/supplies/materials/presentation/bloc/materials/materials_bloc.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditMaterialDialog extends StatefulWidget {
  const EditMaterialDialog({
    super.key,
    this.material,
    this.modification = false,
  });

  final MaterialEntity? material;
  final bool modification;

  @override
  State<EditMaterialDialog> createState() => _EditMaterialDialogState();
}

class _EditMaterialDialogState extends State<EditMaterialDialog> {
  MaterialEntity? _material;

  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _measurementUnitController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.modification) {
      _material = widget.material;

      _designationController.text = widget.material!.designation;
      _measurementUnitController.text = widget.material!.measurementUnit;
      _descriptionController.text = widget.material!.description ?? '';

      context
          .read<ImagePickerBloc>()
          .add(PickImageEvent(imagePath: widget.material!.imagePath ?? ''));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _designationController.dispose();
    _measurementUnitController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditMaterialBloc, EditMaterialState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case EditMaterialLoadingState:
            {
              showProgressDialog(
                context,
                message: 'Veuillez patienter...',
              );
            }
          case EditMaterialFailedState:
            {
              final failedState = state as EditMaterialFailedState;
              context.pop();
              showInfoBar(
                context,
                title: 'Une erreur est survenue',
                message: failedState.message,
                severity: InfoBarSeverity.error,
              );
            }
          case EditMaterialDoneState:
            {
              context.read<ImagePickerBloc>().add(ResetImagePickerEvent());
              _designationController.clear();
              _measurementUnitController.clear();
              _descriptionController.clear();

              final doneState = state as EditMaterialDoneState;
              if (doneState.modification) {
                context
                    .read<MaterialsBloc>()
                    .add(MaterialUpdatedEvent(material: doneState.material));

                showInfoBar(
                  context,
                  title: 'Opération réussie',
                  message: 'Matériau modifié avec succès.',
                  severity: InfoBarSeverity.success,
                );
              } else {
                context
                    .read<MaterialsBloc>()
                    .add(MaterialAddedEvent(material: doneState.material));

                showInfoBar(
                  context,
                  title: 'Opération réussie',
                  message: 'Nouveau matériau ajouté avec succès.',
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
                    ? 'Modifier le matériau'
                    : 'Ajouter un matériau',
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Image'),
                          SizedBox(height: 8),
                          KImagePicker(),
                        ],
                      ),
                      const SizedBox(height: 16),
                      KInputFieldWithDescription(
                        label: 'Désignation',
                        isMandatory: true,
                        inputWidget:
                            TextBox(controller: _designationController),
                        description: 'Le nom du matériau.',
                      ),
                      const SizedBox(height: 16),
                      KInputFieldWithDescription(
                        label: 'Unité de mesure',
                        isMandatory: true,
                        inputWidget:
                            TextBox(controller: _measurementUnitController),
                      ),
                      const SizedBox(height: 6),
                      EasyRichText(
                        'L\'unité de mesure permet au système d\'effectuer des calculs afin de tenir à jour le stock des matériaux et vérifier la production. Pour du sable, par exemple, vous pouvez renseigner «m³».',
                        defaultStyle: TextStyle(color: Colors.grey[120]),
                        patternList: [
                          EasyRichTextPattern(
                            targetString: 'm³',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      KInputFieldWithDescription(
                        label: 'Description',
                        inputWidget: TextBox(
                          controller: _descriptionController,
                          maxLines: 5,
                        ),
                        description:
                            'Renseigner des informations supplémentaires sur le matériau.',
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () {
                          if (_designationController.text.trim().isEmpty ||
                              _measurementUnitController.text.trim().isEmpty) {
                            showInfoBar(
                              context,
                              title: 'Attention',
                              message:
                                  'Veuillez renseigner la designation et l\'unité de mesure du matériau avant de poursuivre.',
                              severity: InfoBarSeverity.warning,
                            );
                          } else {
                            if (widget.modification) {
                              _material = _material?.copyWith(
                                designation: _designationController.text,
                                measurementUnit:
                                    _measurementUnitController.text,
                                description: _descriptionController.text,
                                imagePath: context
                                    .read<ImagePickerBloc>()
                                    .state
                                    .imagePath,
                              );
                            } else {
                              _material = MaterialEntity(
                                siteId: context.read<AuthenticationBloc>().state.account!.siteId!,
                                designation: _designationController.text,
                                measurementUnit:
                                    _measurementUnitController.text,
                                description: _descriptionController.text,
                                imagePath: context
                                    .read<ImagePickerBloc>()
                                    .state
                                    .imagePath,
                              );
                            }

                            context.read<EditMaterialBloc>().add(
                                  EditEvent(
                                    material: _material!,
                                    siteId: context.read<AuthenticationBloc>().state.account!.siteId!,
                                    modification: widget.modification,
                                  ),
                                );
                          }
                        },
                        child: Text(
                          widget.modification
                              ? 'Mettre à jour'
                              : 'Ajouter un matériau',
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
