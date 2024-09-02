import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as just_audio;

enum ContentType { text, image, voiceRecord }

class ChatModel<T> {
  final int senderId;
  final ContentType type;
  final T content;
  final DateTime time;
  final int recipientId;
  IconData? mainicon, pauseicon;
  Duration? duration, position;
  final just_audio.AudioPlayer? recorder;
  final String? details;
  bool read;
  bool choosen;

  ChatModel(
      {required this.senderId,
      required this.recipientId,
      this.type = ContentType.text,
      required this.content,
      required this.time,
      this.recorder,
      this.duration,
      this.position,
      this.mainicon,
      this.pauseicon,
      this.details,
      this.read = false,
      this.choosen = false});

  factory ChatModel.withMultyImagesFromdata({data}) {
    return ChatModel<T>(
        type: ContentType.image,
        senderId: data['senderId'],
        recipientId: data['recipientId'],
        content: data['content'],
        time: data['time'],
        read: data['read'] ?? false,
        choosen: data['choosen']);
  }

  factory ChatModel.ofVoiceRecordFromdata({data}) {
    return ChatModel<T>(
        type: ContentType.voiceRecord,
        senderId: data['senderId'],
        recipientId: data['recipientId'],
        content: data['content'],
        time: data['time'],
        recorder: data['recorder'],
        position: data['position'],
        duration: data['duration'],
        mainicon: data['mainicon'],
        pauseicon: data['pauseicon'],
        details: data['details'],
        read: data['read'] ?? false,
        choosen: data['choosen']);
  }
}
