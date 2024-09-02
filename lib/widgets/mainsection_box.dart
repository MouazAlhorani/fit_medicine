import 'package:fit_med/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainSectionBox extends StatelessWidget {
  const MainSectionBox(
      {super.key,
      this.img,
      this.svg,
      required this.label,
      required this.routeName,
      this.function});
  final String? img;
  final String? svg;
  final String label, routeName;
  final Function()? function;
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry borderrad_1 = const BorderRadius.horizontal(
        right: Radius.circular(35), left: Radius.circular(35));
    BorderRadiusGeometry borderrad_2 = const BorderRadius.horizontal(
        right: Radius.circular(30), left: Radius.circular(30));
    double fullh = (MediaQuery.of(context).size.height / 3) - (170 / 3);

    return GestureDetector(
      onTap: function,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Hero(
          tag: routeName,
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: borderrad_1,
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                svg != null
                    ? ClipRRect(
                        borderRadius: borderrad_1,
                        child: SvgPicture.asset(
                          svg ?? '',
                          height: fullh,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : SizedBox(
                        child: ClipRRect(
                          borderRadius: borderrad_1,
                          child: Image.asset(
                            img ?? '',
                            height: fullh,
                            width: double.infinity,
                            scale: 0.4,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: fullh,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: borderrad_2),
                        child: Container(
                          height: 36,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey, offset: Offset(0, -3))
                              ],
                              gradient: const LinearGradient(colors: [
                                Color(0XFFFFEACE),
                                Color(0xFFF6F8F4)
                              ]),
                              borderRadius: borderrad_2),
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              label,
                              style: CustomTheme.textTheme().titleMedium,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
