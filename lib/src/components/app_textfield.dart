import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom(
      {super.key,
      this.obscureText = false,
      required this.labelText,
      this.suffixIcon,
      required this.controller,
      required this.validate,
      required this.errorText,
      this.onChanged});
  final String labelText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool validate;
  final String errorText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: const BoxDecoration(
        color: Color.fromARGB(16, 156, 15, 15),
        //border: Border.fromBorderSide(BorderSide(width: 1)),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
            labelText: labelText,
            errorText: validate ? errorText : null,
            floatingLabelStyle: TextStyle(
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
            border: InputBorder.none,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.all(12)),
      ),
    );
  }
}
