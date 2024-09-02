import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  double _count = 1;

  double get count => _count;

  setvalue(value) {
    try {
      _count = double.parse(value);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  plus() {
    _count++;
    notifyListeners();
  }

  minus() {
    if (_count != 1) {
      _count--;
    }
    notifyListeners();
  }

  reset() {
    _count = 1;
  }
}
