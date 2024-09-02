import 'package:fit_med/models/locations_model.dart';
import 'package:flutter/material.dart';

class DropdownProvider<T> extends ChangeNotifier {
  List<T> _items = [];
  List<T> get items => _items;
}

class ChooseLocationProvider extends ChangeNotifier {
  List<Location> _items = [
    Location(location: "بدون توصيل", selected: true),
    Location(location: "دمشق", coast: 10000),
    Location(location: "حلب", coast: 20000),
    Location(location: "حمص", coast: 15000),
    Location(location: "درعا", coast: 7000)
  ];

  List<Location> get items => _items;
  set items(value) {
    _items = value;
  }

  chooseOne(Location item) {
    for (var i in _items) {
      i.selected = false;
    }
    item.selected = true;
    notifyListeners();
  }

  Location getselectedItem() {
    return _items.firstWhere((o) => o.selected);
  }
}
