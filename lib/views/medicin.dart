import 'dart:convert';
import 'package:fit_med/controllers/bottombar_provider.dart';
import 'package:fit_med/controllers/cartITems_provider.dart';
import 'package:fit_med/methods/bottombarItems.dart';
import 'package:fit_med/models/bottombar_m.dart';
import 'package:fit_med/models/product_model.dart';
import 'package:fit_med/statics.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:fit_med/widgets/customAppbar.dart';
import 'package:fit_med/widgets/bottombar_box.dart';
import 'package:fit_med/widgets/product_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Medicine extends StatelessWidget {
  const Medicine({super.key});
  static String routeName = "Medicine";
  @override
  Widget build(BuildContext context) {
    context.read<BottomBarItemProvider>().list = mainBottombarItems;

    List<BottomBarItemModel> bitems =
        context.watch<BottomBarItemProvider>().list;
    for (var i in bitems) {
      i.function = () {
        context.read<BottomBarItemProvider>().chooseItem(bitems.indexOf(i));
        if (i.routeName != null && i.routeName != routeName) {
          Navigator.pushNamed(context, i.routeName!);
        }
      };
    }

    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                flexibleSpace: Hero(
                  tag: routeName,
                  child: const CustomAppBar(
                    title: "الأدوية",
                    showcart: true,
                  ),
                ),
              ),
              drawer: const Drawer(),
              body: Column(
                children: [
                  Expanded(
                    child: FutureBuilder(future: Future(() async {
                      var resp = await http.get(Uri.http(
                          khostName, '/api/app/medicines/get-medicines'));
                      return jsonDecode(resp.body);
                    }), builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (!snapshot.hasData) {
                        return Center(
                            child: Text(
                          "خطأ في الوصول للمخدم",
                          style: CustomTheme.textTheme(color: Colors.black)
                              .bodyMedium,
                        ));
                      } else {
                        if (snapshot.data['data']['medicines']!.isEmpty) {
                          return Center(
                              child: Text(
                            "لا يوجد أي أدوية في القائمة",
                            style: CustomTheme.textTheme(color: Colors.black)
                                .bodyMedium,
                          ));
                        } else {
                          List<MedicineModel> data = [];
                          for (var i in snapshot.data['data']['medicines']) {
                            data.add(MedicineModel.fromdata(data: i));
                          }
                          return SingleChildScrollView(
                            child: body(context: context, data: data),
                          );
                        }
                      }
                    }),
                  ),
                  bottombarbox(bitems: bitems)
                ],
              ),
            )));
  }

  Row body({required List<MedicineModel> data, required BuildContext context}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              ...data.where((e) => data.indexOf(e).isEven).map((o) =>
                  MedicineBox(
                      medicine: o,
                      addtocart: () => context
                          .read<CartItemsProvider>()
                          .additem(product: MedicineModel.local(data: o))))
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              ...data
                  .where((e) => data.indexOf(e).isOdd)
                  .map((o) => MedicineBox(
                        medicine: o,
                        addtocart: () => context
                            .read<CartItemsProvider>()
                            .additem(product: MedicineModel.local(data: o)),
                      ))
            ],
          ),
        )
      ],
    );
  }
}
