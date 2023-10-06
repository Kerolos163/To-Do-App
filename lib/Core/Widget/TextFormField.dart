import 'package:flutter/material.dart';

class TextFormFiled extends StatelessWidget {
  const TextFormFiled({
    super.key,
    this.validator,
    required this.label,
    this.hintText,
    this.controller,
    this.prefix,
    this.onChanged,
    this.onSaved,
    this.onTap,
  });
  final String? Function(String?)? validator;
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final Widget? prefix;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      onSaved: onSaved,
      onTap: onTap,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hintText,
        prefix: prefix,
        border: outlineInputBorder(color: Colors.purple, width: 2),
        enabledBorder: outlineInputBorder(color: Colors.purple, width: 2),
        focusedBorder: outlineInputBorder(color: Colors.purple, width: 2),
        errorBorder: outlineInputBorder(color: Colors.red, width: 2),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder(
      {required Color color, required double width}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
