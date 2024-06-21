import 'package:flutter/material.dart';

class Popup extends StatelessWidget {
  final String title;
  final String message;
  final bool showCancel;
  final VoidCallback onConfirm;

  const Popup({
    super.key,
    required this.showCancel,
    required this.title,
    required this.message,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        showCancel
            ? TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : Container(),
        ElevatedButton(
          onPressed: onConfirm,
          child: const Text('Ok!'),
        ),
      ],
    );
  }
}
