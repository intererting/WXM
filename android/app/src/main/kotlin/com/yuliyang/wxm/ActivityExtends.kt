package com.yuliyang.wxm

import android.app.Activity
import android.view.View
import android.view.WindowManager

/**
 * 设置高亮模式
 */
fun Activity.setStatusBarLightMode(isLightMode: Boolean = true) {
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