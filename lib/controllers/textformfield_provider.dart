import 'package:flutter/material.dart';

class TFMModel {
  TextEditingController controller;
  int? maxlines;
  TFMModel({required this.controller, required this.maxlines});
}

class TFMProvider extends ChangeNotifier {
  final TFMModel _tf =
      TFMModel(controller: TextEditingController(), maxlines: 1);
  TFMModel get tf => _tf;
  addline() {
    if (_tf.maxlines! < 5) {
      _tf.maxlines = _tf.maxlines! + 1;
    }
    notifyListeners();
  }

  removeline() {
    if (_tf.maxlines! != 1) {
      _tf.maxlines = _tf.maxlines! - 1;
    }
    notifyListeners();
  }

  clear() {
    _tf.controller.text = '';
  }
}
