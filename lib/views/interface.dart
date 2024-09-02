import 'package:fit_med/themes/light_mode.dart';
import 'package:fit_med/views/homepage.dart';
import 'package:fit_med/widgets/addtocartbutton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InterFace extends StatelessWidget {
  const InterFace({super.key});
  static String routeName = "InterFace";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFCC48), Color(0xFFD47C10)],
              )),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Image.asset(
                      'lib/asset/imgs/doc_1.png',
                      fit: BoxFit.cover,
                      // height: 400,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 70,
                    child: Image.asset(
                      'lib/asset/imgs/dog_p1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 90,
                    child: Image.asset(
                      'lib/asset/imgs/bone.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 15),
                          child: Text(
                            style: CustomTheme.textTheme().titleMedium,
                            "أهلاً بك في تطبيق",
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Text(
                            style: CustomTheme.textTheme().titleLarge,
                            "Fit Medic",
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const Spacer(),
                        Hero(
                            tag: HomePage.routeName,
                            child: customButton(
                                icon: FontAwesomeIcons.house,
                                function: () {
                                  Navigator.pushNamed(
                                      context, HomePage.routeName);
                                },
                                width0: 250,
                                label: "ابدأ",
                                textsize: 25,
                                textColor: Colors.green,
                                iconColor: Color(0xFFD47C10),
                                ctx: context,
                                backColor: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
