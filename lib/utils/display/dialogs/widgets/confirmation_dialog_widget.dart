import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ConfirmationDialogWidget extends StatelessWidget {
  const ConfirmationDialogWidget({
    Key? key,
    required this.title,
    required this.content,
    this.onPressYes
  }) : super(key: key);
  final String title;
  final String content;

  final Function()? onPressYes;


  @override
  Widget build(BuildContext context) {

    return Platform.isAndroid
        ? AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('No')),
        TextButton(
          onPressed: onPressYes,
          child: const Text('Yes'),
        ),
      ],
    )
        : CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          child: const Text("No"),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        CupertinoDialogAction(
          child: const Text("Yes"),
          onPressed: onPressYes,
        ),
      ],
    );
    /*return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                title.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                content.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 22,
          ),
          Row(
            children: [
              Expanded(
                child: GradientButton(
                  onPressed: () {
                    NavRouter.pop(context, false);
                  },
                  title: 'N0',
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: GradientButton(
                  onPressed: () {
                    NavRouter.pop(context, true);
                  },
                  title: 'Yes',
                ),
              ),
            ],
          ),
        ],
      ),
    );*/
  }
}
