package com.example.chatapp

import android.annotation.SuppressLint
import android.app.Service
import android.content.Intent
import android.graphics.PixelFormat
import android.os.Build
import android.os.IBinder
import android.view.*
import kotlin.math.roundToInt


class ChatHeadService : Service() {

    /**Solution for handle layout flag because that devices whom Build version is
     * greater then Oreo that don't support WindowManager.LayoutParams.TYPE_PHONE
     * in that case we use WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY*/

    var LAYOUT_FLAG: Int = 0

    lateinit var floatingView: View
    lateinit var manager: WindowManager
    lateinit var params: WindowManager.LayoutParams
    override fun onBind(intent: Intent?): IBinder? {
        return null //To change body of created functions use File | Settings | File Templates.
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        LAYOUT_FLAG = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
        } else {
            WindowManager.LayoutParams.TYPE_PHONE
        }
        val params = WindowManager.LayoutParams(
            WindowManager.LayoutParams.WRAP_CONTENT,
            WindowManager.LayoutParams.WRAP_CONTENT,
            LAYOUT_FLAG,
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE,
            PixelFormat.TRANSLUCENT
        )

        this.params = params
        //Specify the view position
        params.gravity =
            Gravity.TOP or Gravity.LEFT //Initially view will be added to top-left corner
        params.x = 0
        params.y = 100

        manager = getSystemService(WINDOW_SERVICE) as WindowManager
        floatingView = LayoutInflater.from(this).inflate(R.layout.layout_chat_head, null)
        manager.addView(floatingView, params)
        floatingView.findViewById<View>(R.id.image_bubble)?.setOnTouchListener(object :
            View.OnTouchListener {

            var lastAction: Int? = null
            var initialX: Int? = null
            var initialY: Int? = null
            var initialTouchX: Float? = null
            var initialTouchY: Float? = null

            @SuppressLint("ClickableViewAccessibility")
            override fun onTouch(view: View?, motionEvent: MotionEvent?): Boolean {
                when (motionEvent!!.action) {
                    MotionEvent.ACTION_DOWN -> {
                        //remember the initial position.
                        initialX = params.x
                        initialY = params.y

                        //get the touch location
                        initialTouchX = motionEvent!!.getRawX()
                        initialTouchY = motionEvent!!.getRawY()
                        lastAction = motionEvent!!.getAction()
                        return true
                    }
                    MotionEvent.ACTION_UP -> {
                        val Xdiff = (motionEvent.getRawX() - initialTouchX!!)
                        val Ydiff = (motionEvent.getRawY() - initialTouchY!!)
                        if (lastAction == MotionEvent.ACTION_DOWN) {
                            //Open the chat conversation click.
//                            val intent = Intent(this@ChatHeadService, ChatActivity::class.java)
//                            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
//                            startActivity(intent)
                            val intent1: Intent = packageManager.getLaunchIntentForPackage("com.example.chatapp")!!
                            intent1.putExtra("route","chatbox");
                            startActivity(intent1)

                            //close the service and remove the chat heads
                            stopSelf()
                        }
                        lastAction = motionEvent!!.getAction()
                        return true
                    }
                    MotionEvent.ACTION_MOVE -> {
                        //Calculate the X and Y coordinates of the view.
                        params.x = initialX!!.plus((motionEvent.getRawX() - initialTouchX!!)).roundToInt()
                        params.y = initialY!!.plus((motionEvent.getRawY() - initialTouchY!!).roundToInt())
                        manager.updateViewLayout(floatingView, params)
                        lastAction = motionEvent!!.getAction()
                        return true

                    }

                }
                return false
            }
        })
        return START_NOT_STICKY
    }

    override fun onDestroy() {
        super.onDestroy()
        manager.removeView(floatingView)
    }
}