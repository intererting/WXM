package com.yuliyang.wxm

import android.app.Activity
import android.graphics.Color
import android.view.View
import android.view.WindowManager

/**
 * 设置高亮模式
 */
fun Activity.setStatusBarLightMode(isLightMode: Boolean = false) {
    if (isVersion6OrAbove()) {
        val decorView = window.decorView
        if (decorView != null) {
            var vis = decorView.systemUiVisibility
            vis = if (isLightMode) {
                window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
                vis or View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
            } else {
                vis and View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR.inv()
            }
            decorView.systemUiVisibility = vis
        }
    }
}

/**
 * 透明状态栏模式
 */
fun Activity.transparentStatusBar() {
    if (isVersion5OrAbove()) {
        window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
        val option = View.SYSTEM_UI_FLAG_LAYOUT_STABLE or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
        window.decorView.systemUiVisibility = option
        window.statusBarColor = Color.TRANSPARENT
    } else {
        window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
    }
}