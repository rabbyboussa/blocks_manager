part of 'image_picker_bloc.dart';

sealed class ImagePickerState extends Equatable {
  const ImagePickerState({this.imagePath});

  final String? imagePath;

  @override
  List<String?> get props => [imagePath];
}

final class ImagePickerInitial extends ImagePickerState {}

final class ImagePickedState extends ImagePickerState {
  const ImagePickedState({required String imagePath})
      : super(imagePath: imagePath);
}

final class ImagePickerResetedState extends ImagePickerState {
  const ImagePickerResetedState() : super(imagePath: null);
}
