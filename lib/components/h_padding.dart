import 'package:flutter/material.dart';

extension CustomPadding on Widget {
  Padding hPadding({double padding = 18}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding,
      ),
      child: this,
    );
  }

  Padding vPadding({double padding = 10}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: padding,
      ),
      child: this,
    );
  }
}
