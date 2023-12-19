package com.example.chatapp

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity


class ChatActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_chat)
    }
}