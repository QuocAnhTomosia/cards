import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PassWordWidget extends StatefulWidget {
  String hintText;
  // ignore: prefer_typing_uninitialized_variables
  final passwordController;
  PassWordWidget({
    Key? key,
    required this.hintText,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<PassWordWidget> createState() => _PassWordWidgetState();
}

class _PassWordWidgetState extends State<PassWordWidget> {
  bool isVisible = true;

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
          controller: widget.passwordController,
          textAlign: TextAlign.start,
          enableInteractiveSelection: false,
          obscureText: isVisible,
          decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: isVisible
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ) 
              ),
        ),
      ),
    );
  }
}
