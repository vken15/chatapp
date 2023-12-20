package com.example.chatapp

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.view.View
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
//    private val CHANNEL_METHOD_CHAT = "flutter_channel";
//    private val requestCode = 201
//
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_METHOD_CHAT)
//            .setMethodCallHandler { call, result ->
//                when (call.method) {
//                    "getChatHead" -> {
//                        val chatHead = getChatHead()
//                        result.success(chatHead)
//                    }
//            }
//        }
//    }
//
//    private fun getChatHead(): Boolean {
//        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && !Settings.canDrawOverlays(this)) {
//            val intent = Intent(
//                Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
//                Uri.parse("package:$packageName")
//            )
//            startActivityForResult(intent,requestCode)
//            false
//        } else {
//            startService(Intent(this, ChatHeadService::class.java))
//            finish()
//            true
//        }
//
//    }
//
////    override fun onCreate(savedInstanceState: Bundle?) {
////        super.onCreate(savedInstanceState)
////        setContentView(R.layout.activity_main)
////        val btn: View = findViewById(R.id.notify_me)
////        btn.setOnClickListener(View.OnClickListener {
////            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && !Settings.canDrawOverlays(this)) {
////                val intent = Intent(
////                    Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
////                    Uri.parse("package:$packageName")
////                )
////                startActivityForResult(intent,requestCode)
////            } else {
////                startService(Intent(this, ChatHeadService::class.java))
////                finish()
////            }
////        })
////
////    }
//
//    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
//        super.onActivityResult(requestCode, resultCode, data)
//        if (resultCode == Activity.RESULT_OK) {
//            startService(Intent(this, ChatHeadService::class.java))
//            finish()
//        }
//    }
}