import 'package:flutter/material.dart';

class BooleanProvider<T> extends ChangeNotifier {
  late T _value;
  T get value => _value;
  set value(v) {
    _value = v;
    notifyListeners();
  }
}

class ChooseTypeofKProvider extends BooleanProvider<bool> {
  bool _value = false;
}

class CompleteSaleProvider extends BooleanProvider<bool> {
  bool _value = false;
}

class ShowMoreProvider extends BooleanProvider<List<bool>> {
  List<bool> _value = [];

  List<bool> get value => _value;

  changeValue(index) {
    _value[index] = !_value[index];
    notifyListeners();
  }

  reset(count) {
    _value.clear();
    for (var i = 0; i < count; i++) {
      _value.add(false);
    }
    notifyListeners();
  }
}
