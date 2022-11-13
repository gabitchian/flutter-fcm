import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:uuid/uuid.dart';

class DefaultNotifications {
  static NotificationMessage getNotification(RemoteMessage message) {
    var uuid = Uuid();

    if (kIsWeb) {
      return NotificationMessage(
        title: message.notification!.title,
        description: message.notification!.body,
        image: message.notification!.web!.image,
        sentAt: message.sentTime,
        id: message.messageId ?? uuid.v4().replaceAll('-', ''),
        from: message.from,
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return NotificationMessage(
          title: message.notification!.title,
          description: message.notification!.body,
          sentAt: message.sentTime,
          id: message.messageId,
          from: message.from,
          image: message.notification!.android!.imageUrl,
        );
      case TargetPlatform.iOS:
        return NotificationMessage(
          title: message.notification!.title,
          description: message.notification!.body,
          sentAt: message.sentTime,
          id: message.messageId,
          from: message.from,
          image: message.notification!.apple!.imageUrl,
        );
      default:
        throw UnsupportedError(
          'Notifications are not supported for this platform.',
        );
    }
  }
}

class NotificationMessage {
  final String? id;
  final String? title;
  final String? description;
  final String? image;
  final String? from;
  final DateTime? sentAt;

  NotificationMessage({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    required this.from,
    required this.sentAt,
  });

  NotificationMessage copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    String? from,
    DateTime? sentAt,
  }) {
    return NotificationMessage(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        from: from ?? this.from,
        sentAt: sentAt ?? this.sentAt,
        image: image ?? this.image);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'from': from,
      'sent_at': sentAt,
      'image': image,
    };
  }

  factory NotificationMessage.fromMap(Map<String, dynamic> map) {
    return NotificationMessage(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      from: map['from'],
      sentAt: map['sent_at'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationMessage.fromJson(String source) =>
      NotificationMessage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationMessage(id: $id, from: $from, sentAt: $sentAt, title: $title, description: $description, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationMessage &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode {
    return title.hashCode ^ description.hashCode;
  }
}
