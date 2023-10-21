import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:tracking_user/firebase_options.dart';
import 'package:tracking_user/neweracom.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); 
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("9d7161b3-0c5e-4dd0-93fa-67e6b57fe2dd");
  OneSignal.shared
      .promptUserForPushNotificationPermission()
      .then((accepted) {});
  await OneSignal.shared.getDeviceState().then(
      (value) => log("SUBSCRIPTION STATE CHANGED: ${value!.userId ?? ''}"));
  OneSignal.shared
      .setSubscriptionObserver((OSSubscriptionStateChanges changes) {});
  runApp(const NewEraCom());
}
