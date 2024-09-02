import 'package:fit_med/controllers/bottombar_provider.dart';
import 'package:fit_med/methods/bottombarItems.dart';
import 'package:fit_med/models/bottombar_m.dart';
import 'package:fit_med/views/feed.dart';
import 'package:fit_med/widgets/customAppbar.dart';
import 'package:fit_med/widgets/bottombar_box.dart';
import 'package:fit_med/widgets/mainsection_box.dart';
import 'package:fit_med/models/mainsection_model.dart';
import 'package:fit_med/views/doctors.dart';
import 'package:fit_med/views/medicin.dart';
import 'package:fit_med/views/diseases.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String routeName = "HomePage";
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
    List<MainSectionModel> caItems = [
      MainSectionModel(
        label: "أدويـــة",
        routeName: Medicine.routeName,
        img: "lib/asset/imgs/medicine.png",
      ),
      MainSectionModel(
        label: "أمراض وعلاجها",
        routeName: Diseases.routeName,
        img: "lib/asset/imgs/sickness.jpg",
      ),
      MainSectionModel(
        label: "أطبــــاء",
        routeName: Veters.routeName,
        img: "lib/asset/imgs/doctors.png",
      ),
      MainSectionModel(
        label: "أعلاف",
        routeName: Feed.routeName,
        img: "lib/asset/imgs/food.png",
      )
    ];

    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Hero(
            tag: HomePage.routeName,
            child: const CustomAppBar(
              title: "الرئيسية",
            ),
          ),
        ),
        drawer: const Drawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: caItems.length,
                    itemBuilder: (_, x) {
                      return MainSectionBox(
                        function: () {
                          Navigator.pushNamed(context, caItems[x].routeName);
                        },
                        routeName: caItems[x].routeName,
                        label: caItems[x].label,
                        svg: caItems[x].svg,
                        img: caItems[x].img,
                      );
                    })),
            bottombarbox(bitems: bitems)
          ],
        ),
      ),
    ));
  }
}
