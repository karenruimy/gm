import 'package:flutter/material.dart';

import '../../animations/dialog_animations.dart';
import 'widgets/confirmation_dialog_widget.dart';
import 'widgets/upload_picture_dialog_widget.dart';

class DialogUtils {
  // T is always up-to the call side and T is extending the bool, so it is type safe to boolean variables
  static Future<T> confirmationDialog<T extends bool>(
      {required BuildContext context,
        required String title,
        required String content,required Function()? onPressYes}) async {
    Object? obj = await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return DialogAnimations.grow(animation, child);
      },
      pageBuilder: (animation, secondaryAnimation, child) {
        return ConfirmationDialogWidget(
          title: title,
          content: content,
          onPressYes: onPressYes,
        );
      },
    );
    if (obj == null) {
      return (false) as T;
    }
    return obj as T;
  }

  static Future<T> uploadPictureDialog<T extends String>(BuildContext context) async {
    Object? obj = await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return DialogAnimations.fromBottom(animation, child);
      },
      pageBuilder: (animation, secondaryAnimation, child) {
        return const UploadPictureDialogWidget();
      },
    );

    if (obj == null) {
      return ('false') as T;
    }
    return obj as T;
  }
}
