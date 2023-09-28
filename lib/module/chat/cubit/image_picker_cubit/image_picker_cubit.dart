import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../repo/image_picker_repo.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit(this._imagePickerRepo) : super(ImagePickerState(null));

  ImagePickerRepo _imagePickerRepo;

  void pickImage(ImageSource source) async {
    final file = await _imagePickerRepo.pickImage(source);
    if (file == null) {
      emit(ImagePickerState(null, hasImage: false));
    } else {
      emit(ImagePickerState(file, hasImage: true));
    }
    print(file);
  }

  void clear() {
    ImagePickerState(null, hasImage: false);
  }
}
