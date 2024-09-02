import 'package:fit_med/themes/light_mode.dart';
import 'package:flutter/material.dart';

productCountTF({countRead, countFromText, submit, width = 75.0}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: width,
      child: TextField(
        keyboardType: TextInputType.number,
        onSubmitted: submit,
        controller: countFromText,
        style: CustomTheme.textTheme(color: Colors.black).bodyMedium,
      ),
    ),
  );
}
