import 'package:fit_med/controllers/boolean_provider.dart';
import 'package:fit_med/controllers/bottombar_provider.dart';
import 'package:fit_med/methods/bottombarItems.dart';
import 'package:fit_med/models/bottombar_m.dart';
import 'package:fit_med/models/disease_model.dart';
import 'package:fit_med/widgets/customAppbar.dart';
import 'package:fit_med/widgets/showMoreWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Showdisease extends StatelessWidget {
  const Showdisease({super.key});
  static String routeName = "ShowDisease";

  @override
  Widget build(BuildContext context) {
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
    DiseaseModel item =
        ModalRoute.of(context)!.settings.arguments as DiseaseModel;
    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                appBar: AppBar(
                  flexibleSpace: Hero(
                    tag: "${routeName}_${item.name}",
                    child: const CustomAppBar(
                      title: "أمراض وعلاجها",
                    ),
                  ),
                ),
                drawer: const Drawer(),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8.0),
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Center(
                            child: item.image != null
                                ? Image.network(
                                    item.image!,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : const FaIcon(
                                    FontAwesomeIcons.image,
                                    size: 50,
                                  )),
                      ),
                      showdesc(
                          title: item.name,
                          index: 0,
                          text: item.details,
                          showmore: showmore[0],
                          showmoreRead: showmoreRead),
                      showdesc(
                          title: "أعراض المرض",
                          index: 1,
                          text: item.symptoms,
                          showmore: showmore[1],
                          showmoreRead: showmoreRead),
                      showdesc(
                          title: "الوقاية",
                          index: 1,
                          text: item.prevention,
                          showmore: showmore[2],
                          showmoreRead: showmoreRead),
                      showdesc(
                          title: "العلاج",
                          index: 1,
                          text: item.treatment,
                          showmore: showmore[3],
                          showmoreRead: showmoreRead),
                      ListTile(
                        title: const Text("الدواء الذي ينصح به:"),
                        subtitle: SizedBox(
                          width: 150,
                          child: Card(
                              color: Colors.orangeAccent.shade100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(item.medicine != null
                                        ? item.medicine!.name
                                        : "00")
                                  ],
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
