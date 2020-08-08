package com.me.by

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.firebase.database.FirebaseDatabasePlugin
import io.flutter.plugins.firebaseauth.FirebaseAuthPlugin
import io.flutter.view.FlutterMain
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin


class Application : FlutterApplication(), PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
        FlutterMain.startInitialization(this)
        FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

    override fun registerWith(registry: PluginRegistry?) {
        if (!registry!!.hasPlugin("io.flutter.plugins.firebaseauth")) {
            FirebaseAuthPlugin.registerWith(registry!!.registrarFor("io.flutter.plugins.firebaseauth"))
        }
        if (!registry!!.hasPlugin("io.flutter.plugins.firebase.database")) {
            FirebaseDatabasePlugin.registerWith(registry!!.registrarFor("io.flutter.plugins.firebase.database"))
        }
        if (!registry!!.hasPlugin("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin")) {
            FirebaseMessagingPlugin.registerWith(registry!!.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
        }
    }
}
