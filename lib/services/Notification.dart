import 'package:firebase_messaging/firebase_messaging.dart';

class Notification {
  Notification._();

  factory Notification() => _instance;

  static final Notification _instance = Notification._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      _initialized = true;
    }
  }
}
