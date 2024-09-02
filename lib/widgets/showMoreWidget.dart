import 'package:fit_med/controllers/boolean_provider.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

ListTile showdesc(
    {required title,
    required String? text,
    required bool showmore,
    required ShowMoreProvider showmoreRead,
    index}) {
  return ListTile(
    title: Text(title, style: CustomTheme.textTheme().titleSmall),
    subtitle: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: text != null
            ? text.length > 70
                ? !showmore
                    ? SelectableText.rich(TextSpan(children: [
                        TextSpan(
                          text: text.substring(0, 70),
                          style: CustomTheme.textTheme(
                                  size: 18.0, color: Colors.black)
                              .bodySmall,
                        ),
                        TextSpan(
                          text: " عرض المزيد ",
                          style: CustomTheme.textTheme(size: 18.0).bodySmall,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => showmoreRead.changeValue(index),
                        )
                      ]))
                    : SelectableText.rich(TextSpan(children: [
                        TextSpan(
                          text: text,
                          style: CustomTheme.textTheme(
                                  color: Colors.black, size: 18.0)
                              .bodySmall,
                        ),
                        TextSpan(
                          text: " عرض أقل ",
                          style: CustomTheme.textTheme(size: 18.0).bodySmall,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => showmoreRead.changeValue(index),
                        )
                      ]))
                : SelectableText(text)
            : const SizedBox()),
  );
}
