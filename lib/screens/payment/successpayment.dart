import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsHandler {
  PushNotificationsHandler._();
  factory PushNotificationsHandler() => _instance;
  static final PushNotificationsHandler _instance =
      PushNotificationsHandler._();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;
  Future<void> init() async {
    if (!_initialized) {
// For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
//You can subscribed to a topic, if you need to send to all devices
//user segmented messages is not supported for the Admin SDK
      _firebaseMessaging.subscribeToTopic("AllPushNotifications");
      _firebaseMessaging.configure(
//fires when the app is open and running in the foreground.
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
//do whatever
        },

//fires if the app is fully terminated.
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
//do whatever
        },
//fires if the app is closed, but still running in the background.
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
//do whatever
        },
      );
// For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");
      _initialized = true;
    }
  }
}
