import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInputWidget extends StatelessWidget {
  String text;
  TextEditingController controller;
  TextInputWidget({
    Key? key,
    required this.text,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: TextFormField(
          controller: controller,
          textAlign: TextAlign.start,
          enableInteractiveSelection: false,
          obscureText: false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 4),
            hintText: text,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
