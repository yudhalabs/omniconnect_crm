package com.omniconnect.crm

import android.app.Application
import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build

class Application: Application() {

    companion object {
        const val NOTIFICATION_CHANNEL_ID = "omniconnect_crm"
        const val NOTIFICATION_CHANNEL_NAME = "OmniConnect CRM"
    }

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                NOTIFICATION_CHANNEL_ID,
                NOTIFICATION_CHANNEL_NAME,
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Notifications for OmniConnect CRM"
                enableVibration(true)
                enableLights(true)
            }

            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(channel)
        }
    }
}
