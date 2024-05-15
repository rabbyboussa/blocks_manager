import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(ImagePickerInitial()) {
    on<PickImageEvent>(onPickImage);
    on<ResetImagePickerEvent>(onResetImagePicker);
  }

  Future<void> onPickImage(
      PickImageEvent event, Emitter<ImagePickerState> emit) async {
    emit(ImagePickedState(imagePath: event.imagePath));
  }

  Future<void> onResetImagePicker(
      ResetImagePickerEvent event, Emitter<ImagePickerState> emit) async {
    emit(const ImagePickerResetedState());
  }
}
