import 'package:fit_med/controllers/counter_provider.dart';
import 'package:fit_med/main.dart';
import 'package:fit_med/methods/formatNum.dart';
import 'package:fit_med/methods/setcountValuefromText.dart';
import 'package:fit_med/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as df;
import 'package:provider/provider.dart';

class CartItemsProvider extends ChangeNotifier {
  List<ProductModel> _cartItems = [];
  List<ProductModel> get cartitems => _cartItems;

  additem({required ProductModel product, double count = 1}) {
    if (_cartItems.any(
        (e) => e.id == product.id && e.productType == product.productType)) {
      _cartItems
          .where(
              (e) => e.id == product.id && e.productType == product.productType)
          .first
          .count += count;
    } else {
      _cartItems.add(product);
      product.count = count;
    }
    notifyListeners();
  }

  removeitem({required ProductModel product, double count = 1}) {
    product.count -= count;
    notifyListeners();
  }

  removeitemcompletly(ProductModel product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  setvalue({required ProductModel product, value, required BuildContext ctx}) {
    try {
      if (double.tryParse(value) != null && double.parse(value) >= 1) {
        product.count = double.parse(value);
      } else {
        ctx.read<CounterProvider>().setvalue("1");
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
    } catch (e) {}
    notifyListeners();
  }

  gettotalprice({double coast = 0}) {
    double total = 0;
    for (var i in _cartItems) {
      if (i.price != null) {
        total += i.price! * i.count;
      }
    }
    return formater(value: total + coast, format: "#,###");
  }

  reset() {
    _cartItems.clear();
    notifyListeners();
  }
}
