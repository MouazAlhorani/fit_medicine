import 'package:fit_med/controllers/boolean_provider.dart';
import 'package:fit_med/methods/formatNum.dart';
import 'package:fit_med/models/product_model.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:fit_med/views/cart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

cartNotifiBox(
    {required BuildContext ctx, required List<ProductModel> cartitems}) {
  return Stack(
    children: [
      IconButton(
          onPressed: () {
            ctx.read<CompleteSaleProvider>().value = false;
            Navigator.pushNamed(ctx, Cart.routeName);
          },
          icon: const FaIcon(
            Icons.shopping_cart_outlined,
            size: 30,
            color: Colors.green,
          )),
      Visibility(
        visible: cartitems.isNotEmpty,
        child: Positioned(
          top: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.red,
            ),
            padding: const EdgeInsets.only(left: 2, right: 2),
            child: Center(
                child: Text(
              formater(value: cartitems.length),
              style: CustomTheme.textTheme(color: Colors.white).bodySmall,
            )),
          ),
        ),
      )
    ],
  );
}
