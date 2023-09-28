import 'package:flutter/material.dart';

import 'text_view.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key, this.loadingMessage = ""})
      : super(key: key);
  final String loadingMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextView(
          loadingMessage,
          fontSize: 16,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.normal,
        ),
        SizedBox(height: 20,),
        CircularProgressIndicator.adaptive()
      ],
    ));
  }
}
