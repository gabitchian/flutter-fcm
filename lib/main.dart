import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_fcm/widgets/app_firebase_widget.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const AppFirebase());
}
