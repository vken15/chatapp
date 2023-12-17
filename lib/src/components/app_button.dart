import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom(
      {super.key,
      required this.text,
      this.loading = false,
      this.onPressed});
  final String text;
  final Function()? onPressed;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      onPressed: onPressed,
      child: loading == true
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(text),
    );
  }
}
