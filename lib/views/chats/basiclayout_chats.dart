import 'package:fit_med/controllers/bottombar_provider.dart';
import 'package:fit_med/methods/bottombarItems.dart';
import 'package:fit_med/models/bottombar_m.dart';

import 'package:fit_med/widgets/bottombar_box.dart';
import 'package:fit_med/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BasiclayoutChats extends StatelessWidget {
  const BasiclayoutChats({super.key});
  static String routeName = "BasicLayoutChats";
  @override
  Widget build(BuildContext context) {
    context.read<BottombarChatsITemProvider>().list = chatsbottombaritems;

    List<BottomBarItemModel> bitems =
        context.watch<BottombarChatsITemProvider>().list;
    for (var i in bitems) {
      i.function = () {
        context
            .read<BottombarChatsITemProvider>()
            .chooseItem(bitems.indexOf(i));
      };
    }
    return PopScope(
      onPopInvokedWithResult: (pop, result) {
        if (pop) {
          context.read<BottomBarItemProvider>().chooseItem(0);
        }
      },
      child: SafeArea(
          child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: CustomAppBar(
              title: context
                  .watch<BottombarChatsITemProvider>()
                  .list
                  .firstWhere((i) => i.selected)
                  .label,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    child: FaIcon(
                  bitems.firstWhere((e) => e.selected).icon,
                  color: Colors.green,
                )),
              )
            ],
          ),
          body: Column(children: [
            bitems.firstWhere((e) => e.selected).page!,
            bottombarbox(bitems: bitems)
          ]),
        ),
      )),
    );
  }
}
