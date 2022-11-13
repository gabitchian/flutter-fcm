import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_fcm/configuration.dart';
import 'package:flutter_fcm/firebase_options.dart';
import 'package:flutter_fcm/notification.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const AppFirebase());
}

class AppFirebase extends StatefulWidget {
  const AppFirebase({Key? key}) : super(key: key);

  @override
  State<AppFirebase> createState() => _AppFirebaseState();
}

class _AppFirebaseState extends State<AppFirebase> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Material(
            child: Center(
              child: Text(
                "Não foi possível inicializar o Firebase",
                textDirection: TextDirection.ltr,
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Messaging();
        } else {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class Messaging extends StatelessWidget {
  final fcmToken = FirebaseMessaging.instance.getToken();
  String? token;

  @override
  Widget build(BuildContext context) {
    print("Is web? $kIsWeb");
    return FutureBuilder(
      future: fcmToken,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Material(
            child: Center(
              child: Text(
                "Não foi possível inicializar o token",
                textDirection: TextDirection.ltr,
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          print("token: ${snapshot.data.toString()}");
          FirebaseMessaging.onMessage.listen((RemoteMessage message) {
            print("got something");
            NotificationMessage notification =
                DefaultNotifications.getNotification(message);
            print('Got a message whilst in the foreground!');

            print('Notification: ${notification.toString()}');

            showSimpleNotification(
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
          });

          token = snapshot.data.toString();

          return FutureBuilder(
            future: FirebaseMessaging.instance.requestPermission(
              alert: true,
              announcement: true,
              badge: true,
              carPlay: true,
              criticalAlert: true,
              provisional: true,
              sound: true,
            ),
            builder: (context, snapshot) {
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
                      child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            color: Colors.cyan,
                            child: const Text(
                              "envia notificação",
                            ),
                          ),
                          onTap: () {
                            // ignore: avoid_print
                            print("clicou");
                          }),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
