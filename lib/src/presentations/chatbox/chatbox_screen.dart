import 'package:chatapp/src/presentations/chatbox/controllers/chatbox_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatBoxScreen extends GetWidget<ChatBoxController> {
  const ChatBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text.rich(
          TextSpan(
              text: "VAN A \n",
              style: TextStyle(
                fontSize: 20,
              ),
              children: [
                TextSpan(
                    text: "Hoạt động 1 giờ trước",
                    style: TextStyle(fontSize: 15, color: Colors.grey))
              ]),
        ),
        //backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          _buildChatContent(),
          _buildTextComposer(),
        ],
      ),
    );
  }

  Container _buildTextComposer() {
    return Container(
          child: TextField(
            controller: controller.message.value,
            onSubmitted: (value) {},
            textInputAction: TextInputAction.send,
            decoration: InputDecoration(
              prefixIcon:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.face)),
              hintText: "Tin nhắn",
            ),
          ),
        );
  }

  Expanded _buildChatContent() {
    return Expanded(
          child: ListView.separated(
            itemCount: 5,
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              return Align(
                alignment: index % 2 == 0
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: const Text("TEST"),
                ),
              );
            },
          ),
        );
  }
}
