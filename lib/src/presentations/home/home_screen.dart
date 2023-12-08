import 'package:chatapp/src/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Get.toNamed(AppRouter.chatboxScreen);
          },
          child: Container(
            //color: Colors.red,
            padding: const EdgeInsets.all(16),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 20,
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("VAN A"),
                    Text("data"),
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}