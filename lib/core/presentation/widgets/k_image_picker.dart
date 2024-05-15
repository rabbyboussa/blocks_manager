import 'dart:io';

import 'package:blocks/core/presentation/bloc/image_picker/image_picker_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaquery_sizer/mediaquery_sizer.dart';

class KImagePicker extends StatefulWidget {
  const KImagePicker({
    super.key,
    this.edition = true,
  });

  final bool edition;

  @override
  State<KImagePicker> createState() => _KImagePickerState();
}

class _KImagePickerState extends State<KImagePicker> {
  File? _image;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Choisir une image',
      type: FileType.image,
    );

    if (result != null) {
      final String imagePath = result.files.single.path!;
      context.read<ImagePickerBloc>().add(PickImageEvent(imagePath: imagePath));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagePickerBloc, ImagePickerState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case ImagePickedState:
            {
              _image = File(state.imagePath!);
              break;
            }
          case ImagePickerResetedState:
            {
              _image = null;
              break;
            }
        }
      },
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: 5.w(context),
                  height: 5.w(context),
                  decoration: BoxDecoration(
                    color: const Color(0xffeceff1),
                    image: _image != null
                        ? DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _image == null
                      ? Icon(
                          FluentIcons.file_image,
                          color: Colors.grey[100],
                        )
                      : const SizedBox(),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Offstage(
              offstage: !widget.edition,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Button(
                    onPressed: _pickImage,
                    child: const Text('Choisir une image'),
                  ),
                  const SizedBox(height: 4),
                  const Text('L\'image ne doit pas dépasser 2MB')
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
