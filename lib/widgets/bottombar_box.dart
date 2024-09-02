import 'package:fit_med/models/bottombar_m.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

DecoratedBox bottombarbox({required List<BottomBarItemModel> bitems}) {
  return DecoratedBox(
    decoration: const BoxDecoration(
      color: Colors.white,
      boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)],
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...bitems.map((e) => GestureDetector(
                onTap: e.function,
                child: TweenAnimationBuilder(
                  tween: Tween(begin: 1.0, end: e.selected ? 1.1 : 1.0),
                  duration: const Duration(milliseconds: 200),
                  builder: (context, end, child) {
                    return Transform.scale(
                      scale: end,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          e.icon == null
                              ? const SizedBox()
                              : FaIcon(
                                  e.icon,
                                  color:
                                      e.selected ? Colors.green : Colors.grey,
                                ),
                          Text(
                            e.label,
                            style: CustomTheme.textTheme(
                                    color:
                                        e.selected ? Colors.green : Colors.grey)
                                .bodyMedium,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ))
        ],
      ),
    ),
  );
}
