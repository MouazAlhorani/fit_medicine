import 'package:fit_med/controllers/cartITems_provider.dart';
import 'package:fit_med/models/product_model.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:fit_med/widgets/cartNotifi_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title, this.showcart = false});
  final String title;
  final bool showcart;
  @override
  Widget build(BuildContext context) {
    List<ProductModel> cartItems = context.watch<CartItemsProvider>().cartitems;
    return Container(
      margin: const EdgeInsets.all(4.0),
      height: 60,
      decoration: BoxDecoration(
          color: CustomTheme.selectedTheme == ThemeData.light()
              ? Colors.white
              : const Color.fromARGB(255, 37, 31, 31),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(60, 0, 0, 0),
              blurRadius: 2.5,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.only(right: 25),
        child: Row(
          children: [
            Expanded(
                child: Text(
              title,
              textAlign: TextAlign.center,
              style:
                  CustomTheme.textTheme(family: "IBMPlexSansArabic").titleLarge,
            )),
            Visibility(
                visible: showcart,
                child: cartNotifiBox(ctx: context, cartitems: cartItems))
          ],
        ),
      ),
    );
  }
}
