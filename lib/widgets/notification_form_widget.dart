// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm/shared/configuration/configuration.dart';
import 'package:flutter_fcm/shared/models/firebase_cloud_messaging/to.dart';
import 'package:flutter_fcm/shared/services/send_notification_service.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_fcm/shared/models/firebase_cloud_messaging/message.dart';

import 'package:flutter_fcm/shared/models/firebase_cloud_messaging/notification.dart';
import 'package:flutter_fcm/shared/models/notification_message.dart';
import 'package:uuid/uuid.dart';

class NotificationForm extends StatefulWidget {
  String? token;
  NotificationForm({Key? key, required this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotificationForm();
}

class _NotificationForm extends State<NotificationForm> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  late TextEditingController _imageController;
  late SendNotificationService _sendNotificationService;
  final String id =
      "fc11cde10882434784531a18b5cd0c95"; //"a6dee37b5ed44aa18814330ab29a0525";

  String _image = "";

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
    _imageController = TextEditingController();
    _sendNotificationService = SendNotificationService();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  pushNotification(Message message) {}

  sendNotification() async {
    // CollectionReference users = FirebaseFirestore.instance.collection('users');

    NotificationWidget notification = NotificationWidget(
      title: _titleController.text,
      body: _bodyController.text,
      image: _imageController.text,
    );

    To me = To(id: id, token: widget.token);

    _sendNotificationService
        .addFrom(widget.token!)
        .addReceiver(me)
        .sendNotification(notification);
  }

  @override
  Widget build(BuildContext context) {
    double padding = 50.0;
    double width = MediaQuery.of(context).size.width;
    double halfWidth = width * 0.5;

    _imageController.addListener(() {
      setState(() {
        _image = _imageController.text;
      });
    });

    return SingleChildScrollView(
      child: IntrinsicHeight(
        child: Container(
          width: width,
          alignment: Alignment.center,
          child: //SingleChildScrollView(
              /*child:*/ Form(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: TextFormField(
                      controller: _titleController,
                      // style: TextStyles.input,
                      decoration: InputDecoration(
                        labelText: "Title",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: TextFormField(
                      controller: _bodyController,
                      // style: TextStyles.input,
                      decoration: InputDecoration(
                        labelText: "Body",
                      ),
                      enableSuggestions: true,
                      autocorrect: true,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: halfWidth,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: TextFormField(
                            controller: _imageController,
                            // style: TextStyles.input,
                            decoration: InputDecoration(
                              labelText: "Image Url",
                            ),
                            enableSuggestions: false,
                            autocorrect: false,
                          ),
                        ),
                      ),
                      if (_image.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(left: 64),
                          child: Container(
                            // height: 64,
                            width: 64,
                            child: Image.network(_image),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
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
                        onTap: () async {
                          // ignore: avoid_print
                          print("clicou");
                          await sendNotification();
                          print("salvou");
                        }),
                  ),
                ],
              ),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
