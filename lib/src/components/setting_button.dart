import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
  });
  final String text;
  final Widget? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: icon,
          ),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
