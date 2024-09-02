import 'package:flutter/material.dart';

class SpeekModel {
  bool isListening;
  IconData icon;
  String? text;
  SpeekModel({
    this.isListening = false,
    required this.icon,
    this.text,
  });
}
