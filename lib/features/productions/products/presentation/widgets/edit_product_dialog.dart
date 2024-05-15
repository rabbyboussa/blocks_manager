import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/presentation/bloc/image_picker/image_picker_bloc.dart';
import 'package:blocks/core/presentation/widgets/k_image_picker.dart';
import 'package:blocks/core/presentation/widgets/k_textfield_with_description.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:blocks/features/productions/products/presentation/bloc/edit_product/edit_product_bloc.dart';
import 'package:blocks/features/productions/products/presentation/bloc/products/products_bloc.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditProductDialog extends StatefulWidget {
  const EditProductDialog({
    super.key,
    this.product,
    this.modification = false,
  });

  final ProductEntity? product;
  final bool modification;

  @override
  State<EditProductDialog> createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<EditProductDialog> {
  ProductEntity? _product;

  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.modification) {
      _product = widget.product;

      _designationController.text = widget.product!.designation;
      _lengthController.text = widget.product!.length.toString();
      _widthController.text = widget.product!.width.toString();
      _heightController.text = widget.product!.height.toString();
      _weightController.text = widget.product!.weight.toString();
      _unitPriceController.text = widget.product!.unitPrice.toString();
      _descriptionController.text = widget.product!.description ?? '';

      context
          .read<ImagePickerBloc>()
          .add(PickImageEvent(imagePath: widget.product!.imagePath ?? ''));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _designationController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _unitPriceController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProductBloc, EditProductState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case EditProductLoadingState:
            {
              showProgressDialog(
                context,
                message: 'Veuillez patienter...',
              );
            }
          case EditProductFailedState:
            {
              final failedState = state as EditProductFailedState;
              context.pop();
              showInfoBar(
                context,
                title: 'Une erreur est survenue',
                message: failedState.message,
                severity: InfoBarSeverity.error,
              );
            }
          case EditProductDoneState:
            {
              context.read<ImagePickerBloc>().add(ResetImagePickerEvent());
              _designationController.clear();
              _descriptionController.clear();

              final doneState = state as EditProductDoneState;
              if (doneState.modification) {
                context
                    .read<ProductsBloc>()
                    .add(ProductUpdatedEvent(product: doneState.product));

                showInfoBar(
                  context,
                  title: 'Opération réussie',
                  message: 'Produit modifié avec succès.',
                  severity: InfoBarSeverity.success,
                );
              } else {
                context
                    .read<ProductsBloc>()
                    .add(ProductAddedEvent(product: doneState.product));

                showInfoBar(
                  context,
                  title: 'Opération réussie',
                  message: 'Nouveau produit ajouté avec succès.',
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
          constraints: const BoxConstraints(maxWidth: 416),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.modification
                    ? 'Modifier le produit'
                    : 'Ajouter un produit',
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
                        description: 'Le nom du produit.',
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 120,
                            child: KInputFieldWithDescription(
                              label: 'Longueur (mm)',
                              isMandatory: true,
                              inputWidget:
                                  TextBox(controller: _lengthController),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 120,
                            child: KInputFieldWithDescription(
                              label: 'Largeur (mm)',
                              isMandatory: true,
                              inputWidget:
                                  TextBox(controller: _widthController),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 120,
                            child: KInputFieldWithDescription(
                              label: 'Hauteur (mm)',
                              isMandatory: true,
                              inputWidget:
                                  TextBox(controller: _heightController),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Les dimensions nominales en millimètres du produit',
                        style: TextStyle(color: Colors.grey[120]),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 184,
                            child: KInputFieldWithDescription(
                              label: 'Poids (Kg)',
                              isMandatory: true,
                              inputWidget:
                                  TextBox(controller: _weightController),
                            ),
                          ),
                          // const SizedBox(width: 8),
                          SizedBox(
                            width: 184,
                            child: KInputFieldWithDescription(
                              label: 'Prix unitaire',
                              isMandatory: true,
                              inputWidget: TextBox(
                                controller: _unitPriceController,
                              ),
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
                            'Renseigner des informations supplémentaires sur le produit.',
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () {
                          if (_designationController.text.trim().isEmpty ||
                              _lengthController.text.trim().isEmpty ||
                              _widthController.text.trim().isEmpty ||
                              _heightController.text.trim().isEmpty ||
                              _weightController.text.trim().isEmpty ||
                              _unitPriceController.text.trim().isEmpty) {
                            showInfoBar(
                              context,
                              title: 'Attention',
                              message:
                                  'Veuillez renseigner la designation et l\'unité de mesure du matériau avant de poursuivre.',
                              severity: InfoBarSeverity.warning,
                            );
                          } else {
                            if (widget.modification) {
                              _product = _product?.copyWith(
                                designation: _designationController.text,
                                description: _descriptionController.text,
                                width:
                                    double.parse(_widthController.text) + 0.0,
                                length:
                                    double.parse(_lengthController.text) + 0.0,
                                height:
                                    double.parse(_heightController.text) + 0.0,
                                weight:
                                    double.parse(_weightController.text) + 0.0,
                                unitPrice:
                                    double.parse(_unitPriceController.text) +
                                        0.0,
                                imagePath: context
                                    .read<ImagePickerBloc>()
                                    .state
                                    .imagePath,
                              );
                            } else {
                              _product = ProductEntity(
                                designation: _designationController.text,
                                width:
                                    double.parse(_widthController.text) + 0.0,
                                length:
                                    double.parse(_lengthController.text) + 0.0,
                                height:
                                    double.parse(_heightController.text) + 0.0,
                                weight:
                                    double.parse(_weightController.text) + 0.0,
                                unitPrice:
                                    double.parse(_unitPriceController.text) +
                                        0.0,
                                description: _descriptionController.text,
                                imagePath: context
                                    .read<ImagePickerBloc>()
                                    .state
                                    .imagePath,
                              );
                            }

                            context.read<EditProductBloc>().add(
                                  EditEvent(
                                    product: _product!,
                                    modification: widget.modification,
                                  ),
                                );
                          }
                        },
                        child: Text(
                          widget.modification
                              ? 'Mettre à jour'
                              : 'Ajouter un produit',
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
