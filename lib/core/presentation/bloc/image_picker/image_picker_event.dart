part of 'image_picker_bloc.dart';

sealed class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object> get props => [];
}

final class PickImageEvent extends ImagePickerEvent {
  const PickImageEvent({required this.imagePath});

  final String imagePath;

  @override
  List<String> get props => [imagePath];
}

final class ResetImagePickerEvent extends ImagePickerEvent {}
