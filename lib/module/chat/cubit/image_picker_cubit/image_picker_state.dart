part of 'image_picker_cubit.dart';

class ImagePickerState {
  final File? file;
  final bool hasImage;

  const ImagePickerState(this.file, {this.hasImage = false});
}
