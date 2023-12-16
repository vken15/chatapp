import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField(
      {super.key, required this.messageController, required this.suffixIcon, this.onChanged, this.onSubmitted, this.onTapOutside, this.onEditingComplete});

  final TextEditingController messageController;
  final Widget suffixIcon;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: messageController,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.send,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        prefixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.face)),
        hintText: "Type your message here",
        hintStyle: TextStyle(),
        suffixIcon: suffixIcon,
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
      onSubmitted: onSubmitted,
    );
  }
}
