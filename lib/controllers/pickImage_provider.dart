import 'package:flutter/material.dart';

class PickimageProvider extends ChangeNotifier {
  final List<String?> _imagepathes = [];
  List<String?> get imagepathes => _imagepathes;
  addimage(String? path) {
    _imagepathes.add(path);
    notifyListeners();
  }

  removeimage(item) {
    _imagepathes.remove(item);
    notifyListeners();
  }

  reset() {
    _imagepathes.clear();
    notifyListeners();
  }
}
