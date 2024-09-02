import 'package:fit_med/controllers/boolean_provider.dart';
import 'package:fit_med/controllers/cartITems_provider.dart';
import 'package:fit_med/controllers/dropdown_provider.dart';
import 'package:fit_med/methods/formatNum.dart';
import 'package:fit_med/models/locations_model.dart';
import 'package:fit_med/models/product_model.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:fit_med/widgets/addtocartbutton.dart';
import 'package:fit_med/widgets/cart_box.dart';
import 'package:fit_med/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  static String routeName = "Cart";
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProductModel> cartItemsWatch =
        context.watch<CartItemsProvider>().cartitems;
    CartItemsProvider cartItemsRead = context.read<CartItemsProvider>();
    List<Location> locations = context.watch<ChooseLocationProvider>().items;
    ChooseLocationProvider locationsRead =
        context.read<ChooseLocationProvider>();
    bool completeSaleWatch = context.watch<CompleteSaleProvider>().value;
    CompleteSaleProvider completeSaleRead =
        context.read<CompleteSaleProvider>();
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: const CustomAppBar(title: "السلة"),
          ),
          body: Hero(
            tag: routeName,
            child: cartItemsWatch.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("lib/asset/imgs/emptycart.png"),
                        Text(
                          "السلة فارغة",
                          style: CustomTheme.textTheme(color: Colors.black)
                              .titleLarge,
                        )
                      ],
                    ),
                  )
                : Column(children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: cartItemsWatch.length,
                                itemBuilder: (_, x) {
                                  return CartBox(item: cartItemsWatch[x]);
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(10),
                                      right: Radius.circular(10)),
                                  side: BorderSide(
                                      width: 0.7, color: Colors.grey)),
                              title: Text(
                                "سعر المنتجات",
                                textAlign: TextAlign.start,
                                style:
                                    CustomTheme.textTheme(color: Colors.black)
                                        .bodyMedium,
                              ),
                              trailing: Text(
                                "${cartItemsRead.gettotalprice()} ل.س",
                                style:
                                    CustomTheme.textTheme(color: Colors.black)
                                        .bodyMedium,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Visibility(
                            visible: !completeSaleWatch,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.lightGreen),
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                                left: Radius.circular(10),
                                                right: Radius.circular(10))),
                                    child: Column(
                                      children: [
                                        listile(
                                            title: "تحديد موقع التوصيل",
                                            color: Colors.lightGreen,
                                            titleColor: Colors.white,
                                            trailing: chooselocation(
                                                locations, locationsRead)),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: listile(
                                              title: "رسوم التوصيل",
                                              trailing: Text(
                                                "${formater(value: locations.firstWhere((i) => i.selected).coast)} ل.س",
                                                style: CustomTheme.textTheme(
                                                        color: Colors.black)
                                                    .bodyMedium,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: listile(
                                        title: "إجمالي قيمة الطلب",
                                        trailing: Text(
                                          "${cartItemsRead.gettotalprice(coast: locationsRead.getselectedItem().coast!)} ل.س",
                                          style: CustomTheme.textTheme(
                                                  color: Colors.black)
                                              .bodyMedium,
                                        ))),
                              ],
                            ),
                          ),
                          Visibility(
                              visible: completeSaleWatch,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: listile(
                                        title: "رقم الطلب",
                                        trailing: Card(
                                          color: Colors.green,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "100",
                                              style: CustomTheme.textTheme(
                                                      color: Colors.white,
                                                      size: 17.0)
                                                  .bodySmall,
                                            ),
                                          ),
                                        )),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: listile(
                                          title: "عنوان استلام الطلب",
                                          trailing: Card(
                                            color: Colors.green,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "اسم المنطقة",
                                                style: CustomTheme.textTheme(
                                                        color: Colors.white,
                                                        size: 17.0)
                                                    .bodySmall,
                                              ),
                                            ),
                                          )))
                                ],
                              )),
                          Column(
                            children: [
                              customButton(
                                  icon: FontAwesomeIcons.cartArrowDown,
                                  width0: 250,
                                  label: locations[locations.indexWhere((e) =>
                                                  e.location == "بدون توصيل")]
                                              .selected &&
                                          !completeSaleWatch
                                      ? "إكمال عملية الشراء"
                                      : "تأكيد عملية الشراء",
                                  textsize: 20,
                                  backColor: locations[locations.indexWhere(
                                                  (e) =>
                                                      e.location ==
                                                      "بدون توصيل")]
                                              .selected &&
                                          !completeSaleWatch
                                      ? Colors.lightGreen
                                      : Colors.orangeAccent,
                                  function: () {
                                    if (locations[locations.indexWhere((e) =>
                                                e.location == "بدون توصيل")]
                                            .selected &&
                                        completeSaleWatch == false) {
                                      completeSaleRead.value = true;
                                    } else {
                                      print('ok');
                                    }
                                  },
                                  ctx: context),
                              customButton(
                                  icon: FontAwesomeIcons.circleXmark,
                                  width0: 250,
                                  label: "حذف السلة",
                                  textsize: 20,
                                  backColor: Colors.grey,
                                  function: () {
                                    cartItemsRead.reset();
                                  },
                                  ctx: context),
                            ],
                          )
                        ],
                      ),
                    )),
                  ]),
          )),
    ));
  }

  DecoratedBox listile(
      {required String title,
      titleColor = Colors.black,
      String? subtitle,
      subtitleColor = Colors.black,
      Widget? trailing,
      color = Colors.transparent}) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(10), right: Radius.circular(10))),
      child: ListTile(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(10), right: Radius.circular(10)),
              side: BorderSide(width: 0.7, color: Colors.grey)),
          title: Text(
            title,
            textAlign: TextAlign.start,
            style: CustomTheme.textTheme(color: titleColor).bodyMedium,
          ),
          subtitle: subtitle == null
              ? null
              : Text(
                  subtitle,
                  textAlign: TextAlign.start,
                  style: CustomTheme.textTheme(color: subtitleColor).bodyMedium,
                ),
          trailing: trailing),
    );
  }

  Padding chooselocation(
      List<Location> locations, ChooseLocationProvider locationsRead) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton(
              icon: const FaIcon(
                FontAwesomeIcons.mapLocationDot,
              ),
              dropdownColor: Colors.white,
              value: locations.firstWhere((r) => r.selected),
              items: [
                ...locations.map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.location,
                        style: CustomTheme.textTheme(color: Colors.black)
                            .bodyMedium,
                      ),
                    ))
              ],
              onChanged: (x) {
                locationsRead.chooseOne(x!);
              }),
        ),
      ),
    );
  }
}
