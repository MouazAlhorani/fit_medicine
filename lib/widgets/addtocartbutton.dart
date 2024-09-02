import 'package:fit_med/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

customButton(
    {function,
    required String label,
    required BuildContext ctx,
    Color? backColor = Colors.orangeAccent,
    textColor = Colors.white,
    iconColor = Colors.white,
    forColor = Colors.black,
    required IconData icon,
    double textsize = 14,
    double width0 = double.infinity}) {
  return Align(
    alignment: Alignment.center,
    child: SizedBox(
      width: width0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton.icon(
            iconAlignment: IconAlignment.end,
            style: ElevatedButton.styleFrom(
                disabledBackgroundColor: Colors.grey.withOpacity(0.5),
                shadowColor: Colors.black,
                elevation: 5,
                backgroundColor: backColor!.withOpacity(0.8),
                foregroundColor: forColor,
                shape: const BeveledRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.elliptical(5, 2),
                        right: Radius.elliptical(5, 2)))),
            onPressed: function,
            icon: FaIcon(
              icon,
              color: iconColor,
            ),
            label: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                label,
                style: CustomTheme.textTheme(color: textColor, size: textsize)
                    .titleLarge,
              ),
            )),
      ),
    ),
  );
}
