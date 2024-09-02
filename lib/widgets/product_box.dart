import 'package:fit_med/controllers/boolean_provider.dart';
import 'package:fit_med/controllers/counter_provider.dart';
import 'package:fit_med/methods/formatNum.dart';
import 'package:fit_med/models/product_model.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:fit_med/widgets/addtocartbutton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProductBox extends StatelessWidget {
  const ProductBox(
      {super.key,
      required this.item,
      this.addtocart,
      this.priceUnit,
      required this.routeName});
  final ProductModel item;
  final String? priceUnit;
  final String routeName;
  final Function()? addtocart;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 350),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                child: GestureDetector(
              onTap: () {
                context.read<CounterProvider>().reset();
                context.read<ShowMoreProvider>().reset(2);
                Navigator.pushNamed(context, routeName, arguments: item);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxHeight: 160,
                            maxWidth: 160,
                            minHeight: 50,
                            minWidth: 50),
                        child: Center(
                            child: item.img != null
                                ? Image.network(
                                    item.img!,
                                    fit: BoxFit.contain,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                        ),
                                      );
                                    },
                                  )
                                : const FaIcon(
                                    FontAwesomeIcons.image,
                                    size: 50,
                                  ))),
                  ),
                  ListTile(
                    title: Text(item.name,
                        style: CustomTheme.textTheme(size: 20.0).titleMedium),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        item.type != null && item.type!.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(5),
                                color: const Color(0xFFFFF1DD),
                                child: Text(
                                  item.type!,
                                  style: CustomTheme.textTheme().bodySmall,
                                ))
                            : const SizedBox(),
                        item.category != null && item.category!.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(5),
                                color: const Color(0xFFFFF1DD),
                                child: Text(
                                  item.category!,
                                  style: CustomTheme.textTheme().bodySmall,
                                ))
                            : const SizedBox()
                      ],
                    ),
                  ),
                ],
              ),
            )),
            Column(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0, top: 2),
                    child: Text(
                      "${priceUnit ?? ''} ${formater(value: item.price) ?? 'السعر غير محدد'} ل.س",
                      style:
                          CustomTheme.textTheme(color: Colors.black).bodyMedium,
                    ),
                  ),
                ),
                customButton(
                  icon: FontAwesomeIcons.cartPlus,
                  label: "أضف إلى السلة",
                  function: addtocart,
                  ctx: context,
                ),
                const Divider()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MedicineBox extends ProductBox {
  const MedicineBox(
      {super.key, required MedicineModel medicine, super.addtocart})
      : super(item: medicine, routeName: "ShowMedicine");
}

class FeedBox extends ProductBox {
  const FeedBox({super.key, required FoodModel feed, super.addtocart})
      : super(item: feed, priceUnit: "(1 كغ) ", routeName: "ShowFeed");
}
