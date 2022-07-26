import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PasswordDialog extends StatelessWidget {
  String pass;
  String reEnterPass;
  PasswordDialog({
    Key? key,
    required this.pass,
    required this.reEnterPass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("please check our password"),
      content: const Text("the password and the reenter password are not the same"),
      actions: [
        TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
      ],
    );
  }
}
