import 'package:flutter/material.dart';

class PokemonInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String hint;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  const PokemonInputField({
    super.key,
    this.controller,
    this.initialValue,
    required this.hint,
    this.maxLines = 1,
    this.onChanged,
  }) : assert(
  controller != null || initialValue != null,
  'Either controller or initialValue must be provided',
  );

  @override
  Widget build(BuildContext context) {
    final decoration = InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );

    // CREATE flow
    if (controller != null) {
      return TextField(
        controller: controller,
        maxLines: maxLines,
        onChanged: onChanged,
        decoration: decoration,
      );
    }

    // UPDATE flow
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: decoration,
    );
  }
}
