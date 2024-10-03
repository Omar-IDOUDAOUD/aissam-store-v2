import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key, required this.hint, this.errorText, required this.error ,required this.controller});
  final String hint;
  final bool error;
  final String? errorText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        error: errorText != null ? Text(errorText!) : null,
      ),
    );
  }
}
