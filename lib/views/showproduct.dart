import 'package:fit_med/controllers/boolean_provider.dart';
import 'package:fit_med/controllers/bottombar_provider.dart';
import 'package:fit_med/controllers/cartITems_provider.dart';
import 'package:fit_med/controllers/counter_provider.dart';
import 'package:fit_med/methods/bottombarItems.dart';
import 'package:fit_med/methods/formatNum.dart';
import 'package:fit_med/methods/setcountValuefromText.dart';
import 'package:fit_med/models/bottombar_m.dart';
import 'package:fit_med/models/product_model.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:fit_med/widgets/addtocartbutton.dart';
import 'package:fit_med/widgets/customAppbar.dart';
import 'package:fit_med/widgets/bottombar_box.dart';
import 'package:fit_med/widgets/productCountTF.dart';
import 'package:fit_med/widgets/showMoreWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ShowProduct extends StatelessWidget {
  const ShowProduct(
      {super.key,
      required this.title,
      required this.routeName,
      this.priceUnit,
      required this.selectedModel});
  final String title, routeName;
  final String? priceUnit;
  final ProductType selectedModel;

  @override
  Widget build(BuildContext context) {
    List typeofk = [
      {'type': 'طن', 'selected': !context.watch<ChooseTypeofKProvider>().value},
      {
        'type': 'كيلو غرام',
        'selected': context.watch<ChooseTypeofKProvider>().value
      },
    ];
    List<bool> showmore = context.watch<ShowMoreProvider>().value;
    ShowMoreProvider showmoreRead = context.read<ShowMoreProvider>();
    context.read<BottomBarItemProvider>().list = mainBottombarItems;
    List<BottomBarItemModel> bitems =
        context.watch<BottomBarItemProvider>().list;
    for (var i in bitems) {
      i.function = () {
        context.read<BottomBarItemProvider>().chooseItem(bitems.indexOf(i));
        if (i.routeName != routeName && i.page != null) {
          Navigator.pushNamed(context, i.routeName!);
        }
      };
    }
    ProductModel item =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    double countWatch = context.watch<CounterProvider>().count;
    CounterProvider countRead = context.read<CounterProvider>();
    CartItemsProvider cartItemsRead = context.read<CartItemsProvider>();
    TextEditingController countFromText =
        TextEditingController(text: formater(value: countWatch));
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Hero(
              tag: "${routeName}_${item.name}",
              child: CustomAppBar(
                title: title,
                showcart: true,
              ),
            ),
          ),
          drawer: const Drawer(),
          body: Column(children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          SizedBox(
                              height: 250,
                              width: double.infinity,
                              child: Center(
                                child: item.img != null
                                    ? Image.network(
                                        item.img!,
                                        fit: BoxFit.cover,
                                      )
                                    : const Center(
                                        child: FaIcon(FontAwesomeIcons.image)),
                              )),
                          Stack(
                            children: [
                              ListTile(
                                title: Text(item.name,
                                    style: CustomTheme.textTheme().titleLarge),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    item.type != null
                                        ? Container(
                                            padding: const EdgeInsets.all(5),
                                            color: const Color(0xFFFFF1DD),
                                            child: Text(
                                              item.type!,
                                              style: CustomTheme.textTheme()
                                                  .bodySmall,
                                            ))
                                        : const SizedBox(),
                                    item.category != null
                                        ? Container(
                                            padding: const EdgeInsets.all(5),
                                            color: const Color(0xFFFFF1DD),
                                            child: Text(
                                              item.category!,
                                              style: CustomTheme.textTheme()
                                                  .bodySmall,
                                            ))
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 10,
                                top: 10,
                                child: Text(
                                    "${priceUnit ?? ''} ${formater(value: item.price, format: "#,###.00") ?? 'السعر غير محدد'} ل.س",
                                    style: CustomTheme.textTheme(
                                            color: Colors.black)
                                        .titleSmall),
                              )
                            ],
                          ),
                          showdesc(
                              title: "الوصف",
                              index: 0,
                              text: item.usage,
                              showmore: showmore[0],
                              showmoreRead: showmoreRead),
                          showdesc(
                              title: "التركيب",
                              index: 1,
                              text: item.composition,
                              showmore: showmore[1],
                              showmoreRead: showmoreRead),
                          Visibility(
                            visible: selectedModel == ProductType.food,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 50),
                                  SizedBox(
                                    width: 250,
                                    child: Card(
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "اختر الكمية المطلوبة",
                                          style: CustomTheme.textTheme()
                                              .bodyMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      productCountTF(
                                          width: 120.0,
                                          countFromText: countFromText,
                                          countRead: countRead,
                                          submit: (v) => countRead.setvalue(v)),
                                      Column(
                                        children: [
                                          ...typeofk.map((e) => GestureDetector(
                                                onTap: () {
                                                  context
                                                          .read<
                                                              ChooseTypeofKProvider>()
                                                          .value =
                                                      !context
                                                          .read<
                                                              ChooseTypeofKProvider>()
                                                          .value;
                                                },
                                                child: SizedBox(
                                                  width: 100,
                                                  child: Card(
                                                    color: e['selected']
                                                        ? Colors.orangeAccent
                                                            .shade100
                                                        : Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        e['type'],
                                                        style: CustomTheme
                                                                .textTheme(
                                                                    color: Colors
                                                                        .black)
                                                            .bodyMedium,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ))
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 10),
                              child: customButton(
                                icon: FontAwesomeIcons.cartPlus,
                                function: () {
                                  return setCountValuefromText(
                                      type: selectedModel,
                                      typeofk: typeofk.firstWhere(
                                          (i) => i['selected'])['type'],
                                      countFromText: countFromText,
                                      countRead: countRead,
                                      item: item,
                                      ctx: context,
                                      cartItemsRead: cartItemsRead);
                                },
                                ctx: context,
                                label: 'أضف إلى السلة',
                              )),
                          Visibility(
                            visible: selectedModel == ProductType.medicine,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: IconButton(
                                      iconSize: 15,
                                      color: Colors.white,
                                      style: ButtonStyle(
                                          backgroundColor: WidgetStateProperty
                                              .all<Color>(countWatch == 1
                                                  ? const Color(0xffFFDCAB)
                                                  : const Color(0xffFAAD40)),
                                          shape: WidgetStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5)))),
                                      onPressed: countWatch == 1
                                          ? null
                                          : () {
                                              context
                                                  .read<CounterProvider>()
                                                  .minus();
                                            },
                                      icon:
                                          const FaIcon(FontAwesomeIcons.minus)),
                                ),
                                productCountTF(
                                    countFromText: countFromText,
                                    countRead: countRead,
                                    submit: (v) => countRead.setvalue(v)),
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
                                                    const Color(0xffFAAD40)),
                                            shape: WidgetStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)))),
                                        onPressed: () {
                                          context
                                              .read<CounterProvider>()
                                              .plus();
                                        },
                                        icon: const FaIcon(
                                            FontAwesomeIcons.plus)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ])))),
            bottombarbox(bitems: bitems)
          ])),
    ));
  }
}

class ShowMedicine extends ShowProduct {
  const ShowMedicine({super.key})
      : super(
            routeName: "ShowMedicine",
            title: "الأدوية",
            selectedModel: ProductType.medicine);
}

class ShowFood extends ShowProduct {
  const ShowFood({super.key})
      : super(
            routeName: "ShowFeed",
            priceUnit: "سعر الكيلو ",
            title: "الأعلاف",
            selectedModel: ProductType.food);
}
