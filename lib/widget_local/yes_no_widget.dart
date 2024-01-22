import 'package:flutter/material.dart';

class YesNoDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onYesPressed;
  final VoidCallback onNoPressed;

  YesNoDialog({
    required this.title,
    required this.content,
    required this.onYesPressed,
    required this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onNoPressed,
          child: Text('No'),
        ),
        TextButton(
          onPressed: onYesPressed,
          child: Text('Yes'),
        ),
      ],
    );
  }
}
