import 'package:fit_med/models/user_model.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Chatappbar extends StatelessWidget {
  const Chatappbar({super.key, required this.item});
  final UserModel item;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      height: 60,
      decoration: BoxDecoration(
          color: CustomTheme.selectedTheme == ThemeData.light()
              ? Colors.white
              : const Color.fromARGB(255, 37, 31, 31),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(60, 0, 0, 0),
              blurRadius: 2.5,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.only(right: 25),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: item.photo != null
                          ? Image.network(item.photo!)
                          : const FaIcon(FontAwesomeIcons.userDoctor),
                    ),
                  ),
                  Text(
                    item.name,
                    style:
                        CustomTheme.textTheme(color: Colors.black).bodyMedium,
                  ),
                ],
              ),
            ),
            const Spacer(),
            TextButton(
                onPressed: () {},
                child: const FaIcon(
                  FontAwesomeIcons.circleInfo,
                  color: Colors.lightGreen,
                )),
          ],
        ),
      ),
    );
  }
}
