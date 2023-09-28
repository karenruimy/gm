import 'package:flutter/material.dart';

class PasswordSuffixWidget extends StatelessWidget {
  const PasswordSuffixWidget(
      {Key? key, required this.isPasswordVisible, required this.onTap})
      : super(key: key);
  final bool isPasswordVisible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onTap,
        splashRadius: 20,
        icon: isPasswordVisible
            ? Icon(Icons.visibility_off, color: Colors.grey,)
            : Icon(Icons.visibility, color: Colors.grey,));
  }
}
