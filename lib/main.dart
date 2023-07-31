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

  int i = 0;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("9d7161b3-0c5e-4dd0-93fa-67e6b57fe2dd");

  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  await OneSignal.shared.getDeviceState().then(
      (value) => log("SUBSCRIPTION STATE CHANGED: ${value!.userId ?? ''}"));

  OneSignal.shared
      .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    print("SUBSCRIPTION STATE CHANGED:");
    print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
  });

  // OneSignal.shared.se

  //  FirebaseFirestore.instance
  //         .collection('ticket_orange')
  //       // .where("user_sender", isEqualTo: '33')
  //       .snapshots()
  //      .first.then((value) => print(value.docs.first.data()));
  // await dropSessionUser();

  // await createConteurUserTest();
// await FirebaseMessaging.instance.getToken().then((token) => log(token??''));

// FirebaseMessaging messaging = FirebaseMessaging.instance;

// NotificationSettings settings = await messaging.requestPermission(
//   alert: true,
//   announcement: false,
//   badge: true,
//   carPlay: false,
//   criticalAlert: false,
//   provisional: false,
//   sound: true,
// );
// print('User granted permission: ${settings.authorizationStatus}');

  runApp(const NewEraCom());
}
