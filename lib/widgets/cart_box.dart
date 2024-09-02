import 'package:fit_med/controllers/cartITems_provider.dart';
import 'package:fit_med/controllers/counter_provider.dart';
import 'package:fit_med/methods/formatNum.dart';
import 'package:fit_med/models/product_model.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:fit_med/widgets/productCountTF.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CartBox extends StatelessWidget {
  final ProductModel item;
  const CartBox({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    CounterProvider countRead = context.read<CounterProvider>();
    TextEditingController countFromText =
        TextEditingController(text: formater(value: item.count));
    CartItemsProvider cartItemsRead = context.read<CartItemsProvider>();
    return SizedBox(
      height: 140,
      child: Card(
        child: Row(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: Card(
                  child: item.img != null
                      ? Center(
                          child: Image.network(
                          item.img!,
                          fit: BoxFit.cover,
                        ))
                      : const Center(child: FaIcon(FontAwesomeIcons.image))),
            ),
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ListTile(
                      title: Text(
                        item.name,
                        style: CustomTheme.textTheme().bodyMedium,
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: IconButton(
                                    iconSize: 15,
                                    color: Colors.white,
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                Colors.orange),
                                        shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)))),
                                    onPressed: item.count <= 1
                                        ? null
                                        : () {
                                            context
                                                .read<CartItemsProvider>()
                                                .removeitem(product: item);
                                          },
                                    icon: const FaIcon(FontAwesomeIcons.minus)),
                              ),
                              productCountTF(
                                  countFromText: countFromText,
                                  countRead: countRead,
                                  submit: (v) {
                                    return cartItemsRead.setvalue(
                                        ctx: context,
                                        product: item,
                                        value: countFromText.text);
                                  }),
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: Center(
                                  child: IconButton(
                                      iconSize: 15,
                                      color: Colors.white,
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  Colors.orange),
                                          shape: WidgetStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5)))),
                                      onPressed: () {
                                        context
                                            .read<CartItemsProvider>()
                                            .additem(product: item);
                                      },
                                      icon:
                                          const FaIcon(FontAwesomeIcons.plus)),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Text(
                                "${formater(value: item.count * (item.price ?? 0), format: "#,###")}",
                                style:
                                    CustomTheme.textTheme(color: Colors.black)
                                        .bodyMedium,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: TextButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Color(0xffFFDCAB))),
                        onPressed: () {
                          context
                              .read<CartItemsProvider>()
                              .removeitemcompletly(item);
                        },
                        child: Text(
                          "حذف السلة",
                          style: CustomTheme.textTheme(color: Colors.black)
                              .bodySmall,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
