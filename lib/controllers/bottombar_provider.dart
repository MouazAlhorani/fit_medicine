import 'package:fit_med/models/bottombar_m.dart';
import 'package:flutter/material.dart';

class BottomBarItemProvider extends ChangeNotifier {
  List<BottomBarItemModel> _list = [];

  List<BottomBarItemModel> get list => _list;

  set list(vlist) {
    _list = vlist;
  }

  chooseItem(index) {
    if (_list.isNotEmpty) {
      for (var i in _list) {
        i.selected = false;
      }
      _list[index].selected = true;
      notifyListeners();
    }
  }

  reset() {
    for (var i in _list) {
      i.selected = false;
    }
    notifyListeners();
  }
}

class BottombarChatsITemProvider extends BottomBarItemProvider {}
