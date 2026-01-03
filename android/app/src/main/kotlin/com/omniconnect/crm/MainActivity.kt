package com.omniconnect.crm

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Setup method channel for native communication
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.omniconnect.crm/native"
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getDeviceInfo" -> {
                    result.success(mapOf(
                        "deviceId" to android.os.Build.DEVICE,
                        "model" to android.os.Build.MODEL,
                        "brand" to android.os.Build.BRAND,
                        "androidVersion" to android.os.Build.VERSION.RELEASE,
                        "sdkVersion" to android.os.Build.VERSION.SDK_INT
                    ))
                }
                else -> result.notImplemented()
            }
        }
    }
}
