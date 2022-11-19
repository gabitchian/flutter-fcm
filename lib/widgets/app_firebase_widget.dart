import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm/shared/configuration/firebase_options.dart';
import 'package:flutter_fcm/widgets/messaging_widget.dart';

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
          return const Messaging();
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
