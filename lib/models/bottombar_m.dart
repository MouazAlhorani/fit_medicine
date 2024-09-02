import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomBarItemModel {
  final IconData? icon;
  final String label;
  final String? routeName;
  final Widget? page;
  Function()? function;
  bool selected;

  BottomBarItemModel({
    this.icon,
    required this.label,
    this.routeName,
    this.page,
    this.function,
    this.selected = false,
  });
}
