import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm/shared/converters/default_notification.dart';
import 'package:flutter_fcm/shared/models/notification_message.dart';
import 'package:flutter_fcm/widgets/notification_form_widget.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:uuid/uuid.dart';

class Messaging extends StatefulWidget {
  const Messaging({Key? key}) : super(key: key);

  @override
  State<Messaging> createState() => _Messaging();
}

class _Messaging extends State<Messaging> {
  final fcmToken = FirebaseMessaging.instance.getToken();
  String? _token;

  void _setToken(String? value) {
    setState(() {
      _token = value;
    });
  }

  @override
  void initState() {
    fcmToken.then(_setToken);

    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    FirebaseMessaging.instance.onTokenRefresh.listen(_setToken);
  }

  @override
  Widget build(BuildContext context) {
    print("Is web? $kIsWeb");

    print("token: $_token");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      NotificationMessage notification =
          DefaultNotifications.getNotification(message);

      print('Notification: ${notification.toString()}');

      showNotification(notification);
    });

    return OverlaySupport(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 50,
            ),
            child: NotificationForm(token: _token),
          ),
        ),
      ),
    );
  }
}

showNotification(NotificationMessage notification) {
  return showSimpleNotification(
    Text(notification.title!), autoDismiss: true,
    duration: const Duration(minutes: 1),
    background: Colors.grey[50],
    foreground: Colors.black,
    leading: SizedBox.fromSize(
      size: const Size(40, 40),
      child: ClipOval(
        child: Container(
            child: (notification.image != null)
                ? Image.network(notification.image!)
                : const Icon(Icons.notifications_active)),
      ),
    ),
    subtitle: Text(notification.description!),
    trailing: Builder(builder: (context) {
      return InkWell(
        onTap: () {
          OverlaySupportEntry.of(context)!.dismiss();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 2,
          ),
          child: Container(
            // color: Colors.grey[200],
            child: Text(
              'Dismiss',
              style: TextStyle(
                color: Colors.yellow[700],
              ),
            ),
          ),
        ),
      );
    }),
    // duration: Duration(milliseconds: 4000),
  );
}
