import 'package:fit_med/themes/light_mode.dart';
import 'package:fit_med/widgets/search_box.dart';
import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    List chats = [];
    return Expanded(
      child: Column(
        children: [
          searchBox(),
          Expanded(
              child: ListView(
            children: [
              ...chats.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'lib/asset/imgs/face_1.png',
                            fit: BoxFit.cover,
                            height: 70,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '',
                          style: CustomTheme.textTheme(color: Colors.black)
                              .bodyMedium,
                        ),
                      )
                    ],
                  ),
                );
              })
            ],
          )),
        ],
      ),
    );
  }
}
