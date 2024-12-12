// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// // Handles background messages
// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print('Title: ${message.notification?.title}');
//   print('Body: ${message.notification?.body}');
// }

// class FirebaseNotification {
//   final _firebaseMessaging = FirebaseMessaging.instance;

//   // Initializes notifications
//   Future<void> initNotifications() async {
//     try {
//       // Request permissions for notifications
//       await _firebaseMessaging.requestPermission();

//       // Get and print the FCM token
//       final fCMToken = await _firebaseMessaging.getToken();
//       await FirebaseFirestore.instance.collection('users').doc().set({
//         'fcmToken': fCMToken,
//       });
//       print('Token: $fCMToken');

//       // Set background message handler
//       FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

//       // Listen for foreground notifications
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         print(
//             'Foreground notification received: ${message.notification?.title}');
//         print('Message body: ${message.notification?.body}');
//       });
//     } catch (e) {
//       print('Error initializing notifications: $e');
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Background notification received');
  print('Title: ${message.notification?.title ?? "No Title"}');
  print('Body: ${message.notification?.body ?? "No Body"}');
}

class FirebaseNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize Firebase Notifications
  Future<void> initNotifications() async {
    try {
      // Ensure Firebase is initialized
      await Firebase.initializeApp();

      // Request permissions
      await _firebaseMessaging.requestPermission();

      // Get and print the FCM token
      final fCMToken = await _firebaseMessaging.getToken();
      if (fCMToken != null) {
        final userId = 'unique_user_id'; // Replace with authenticated user ID
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .set({'fcmToken': fCMToken});
        print('Token stored: $fCMToken');
      } else {
        print('FCM Token is null');
      }

      // Set background message handler
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

      // Handle foreground notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Foreground notification received: ${message.notification?.title}');
        print('Message body: ${message.notification?.body}');
      });
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }
}
