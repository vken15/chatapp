import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chatapp/src/components/message_textfield.dart';
import 'package:chatapp/src/core/enum/app_state.dart';
import 'package:chatapp/src/presentations/chatbox/controllers/chatbox_controller.dart';
import 'package:chatapp/src/presentations/chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatBoxScreen extends GetWidget<ChatBoxController> {
  const ChatBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
              text: "${controller.title.value}\n",
              style: const TextStyle(
                fontSize: 20,
              ),
              children: [
                TextSpan(
                    text: controller.receiver.value.lastOnline == null
                        ? ""
                        : controller.lastOnlineCalc(
                            controller.receiver.value.lastOnline!),
                    style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.65)))
              ]),
        ),
        actions: [
          IconButton(onPressed: () async {
            // const channel = MethodChannel('flutter_channel');
            // bool test = await channel.invokeMethod('getChatHead');
            // print(test);
          }, icon: const Icon(Icons.photo_size_select_small))
        ],
        //backgroundColor: Colors.blue,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color.fromARGB(255, 2, 96, 237), Colors.lightBlue]),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.screenState.value == AppState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.screenState.value == AppState.error) {
                return const Center(child: Text("Error"));
              } else if (controller.screenState.value == AppState.empty) {
                return const Center(child: Text("Không có tin nhắn nào!"));
              } else {
                return _buildChatContent();
              }
            }),
          ),
          _buildTextComposer(),
        ],
      ),
    );
  }

  ListView _buildChatContent() {
    return ListView.separated(
      //cacheExtent: 1,
      itemCount: controller.messages.length + 1,
      reverse: true,
      //shrinkWrap: true,
      controller: controller.scrollController,
      //physics: const PageScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        if (index == controller.messages.length) {
          if (controller.messages.length >= controller.offset.value * 12) {
            return const Center(child: CircularProgressIndicator());
          }
          return null;
        } else {
          return Column(
            children: [
              Text(Get.find<ChatController>()
                  .msgTime(controller.messages[index].updatedAt.toString())),
              BubbleSpecialThree(
                text: controller.messages[index].content!,
                color: controller.messages[index].senderId == controller.userId
                    ? const Color(0xFF1B97F3)
                    : const Color(0xFFE8E8EE),
                isSender:
                    controller.messages[index].senderId == controller.userId,
                tail: false,
              ),
            ],
          );
        }
      },
    );
  }

  Container _buildTextComposer() {
    return Container(
      child: MessageTextField(
        messageController: controller.messageController.value,
        suffixIcon: GestureDetector(
          onTap: () {
            controller.sendMessage(
                controller.messageController.value.text,
                controller.id.value,
                controller.receiver.value.id!,
                controller.userId);
          },
          child: const Icon(
            Icons.send,
            size: 24,
            color: Colors.blue,
          ),
        ),
        onSubmitted: (value) {
          controller.sendMessage(value, controller.id.value,
              controller.receiver.value.id!, controller.userId);
        },
        onChanged: (value) {
          controller.startTyping();
        },
        onEditingComplete: () {
          controller.stopTyping();
        },
        onTapOutside: (value) {
          controller.stopTyping();
        },
      ),
    );
  }
}
