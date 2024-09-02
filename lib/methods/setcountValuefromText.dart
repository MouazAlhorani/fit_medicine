import 'package:fit_med/controllers/cartITems_provider.dart';
import 'package:fit_med/controllers/counter_provider.dart';
import 'package:fit_med/models/product_model.dart';
import 'package:flutter/material.dart';

setCountValuefromText(
    {countFromText,
    required CounterProvider countRead,
    countWatch,
    required CartItemsProvider cartItemsRead,
    item,
    ctx,
    typeofk,
    required ProductType type}) {
  if (double.tryParse(countFromText.text) != null &&
      double.parse(countFromText.text) >= 1) {
    countRead.setvalue(countFromText.text);
    cartItemsRead.additem(
        count: double.parse(countFromText.text) *
            (type == ProductType.food && typeofk == "طن" ? 1000 : 1),
        product: item);
  } else {
    countRead.setvalue("1");
    return showDialog(
        context: ctx,
        builder: (_) {
          return const AlertDialog(
            content: Text(
              "!!أدخل قيمة عددية صحيحة",
              textAlign: TextAlign.center,
            ),
          );
        });
  }
}
