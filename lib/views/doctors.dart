import 'dart:convert';

import 'package:fit_med/controllers/bottombar_provider.dart';
import 'package:fit_med/methods/bottombarItems.dart';
import 'package:fit_med/models/bottombar_m.dart';
import 'package:fit_med/models/user_model.dart';
import 'package:fit_med/statics.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:fit_med/widgets/customAppbar.dart';
import 'package:fit_med/widgets/bottombar_box.dart';
import 'package:fit_med/widgets/user_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Veters extends StatelessWidget {
  static String routeName = "Doctors";
  const Veters({super.key});

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
              child: const CustomAppBar(title: "أطباء بيطريين")),
        ),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder(future: Future(() async {
              var resp = await http
                  .get(Uri.http(khostName, '/api/app/get-veterinarians'));
              return jsonDecode(resp.body);
            }), builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (!snapshot.hasData) {
                return Center(
                    child: Text(
                  "خطأ في الوصول للمخدم",
                  style: CustomTheme.textTheme(color: Colors.black).bodyMedium,
                ));
              } else {
                if (snapshot.data!['data']['Veterinarians'].isEmpty) {
                  return Center(
                      child: Text(
                    "لا يوجد أي أطباء في القائمة",
                    style:
                        CustomTheme.textTheme(color: Colors.black).bodyMedium,
                  ));
                } else {
                  List<VeterinaryModel> veters = [];
                  for (var i in snapshot.data!['data']['Veterinarians']) {
                    veters.add(VeterinaryModel.fromdata(data: i));
                  }

                  return ListView.builder(
                      itemCount: veters.length,
                      itemBuilder: (_, x) {
                        return VeterBox(
                          item: veters[x],
                        );
                      });
                }
              }
            })),
            bottombarbox(bitems: bitems)
          ],
        ),
      ),
    ));
  }
}
