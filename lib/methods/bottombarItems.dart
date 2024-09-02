import 'package:fit_med/controllers/bottombar_provider.dart';
import 'package:fit_med/models/bottombar_m.dart';
import 'package:fit_med/views/chats/basiclayout_chats.dart';
import 'package:fit_med/views/chats/chats.dart';
import 'package:fit_med/views/chats/groups.dart';
import 'package:fit_med/views/chats/peoples.dart';
import 'package:fit_med/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

List<BottomBarItemModel> mainBottombarItems = [
  BottomBarItemModel(
    label: 'الرئيسية',
    routeName: HomePage.routeName,
    icon: FontAwesomeIcons.house,
    selected: true,
  ),
  BottomBarItemModel(
    label: 'بحث',
  ),
  BottomBarItemModel(
    label: 'محادثات',
    routeName: BasiclayoutChats.routeName,
  ),
  BottomBarItemModel(
    label: 'إضافة منشور',
  )
];

List<BottomBarItemModel> chatsbottombaritems = [
  BottomBarItemModel(
      label: "الدردشات",
      page: const Chats(),
      icon: FontAwesomeIcons.commentDots,
      selected: true),
  BottomBarItemModel(
    label: "الأشخاص",
    page: const Peoples(),
    icon: FontAwesomeIcons.userGroup,
  ),
  BottomBarItemModel(
    label: "المجتمعات",
    page: const Groups(),
    icon: FontAwesomeIcons.comments,
  ),
];
