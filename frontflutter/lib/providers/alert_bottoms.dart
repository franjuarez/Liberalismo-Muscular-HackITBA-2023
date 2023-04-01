import 'package:flutter/material.dart';

class AlertDialogActions extends StatelessWidget {
  const AlertDialogActions({
    Key? key,
    required this.cancelButton,
    required this.confirmButton,
  }) : super(key: key);

  final Widget cancelButton;
  final Widget confirmButton;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        cancelButton,
        confirmButton,
      ],
    );
  }
}
