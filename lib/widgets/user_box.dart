import 'package:fit_med/models/user_model.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:fit_med/views/chatting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserBox extends StatelessWidget {
  final UserModel item;
  const UserBox({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ConstrainedBox(
                constraints: const BoxConstraints(
                    minHeight: 50, minWidth: 50, maxHeight: 100, maxWidth: 100),
                child: Center(
                    child: item.photo != null
                        ? Image.network(item.photo!, fit: BoxFit.cover)
                        : const FaIcon(FontAwesomeIcons.image))),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      item.name,
                      style: CustomTheme.textTheme().titleSmall,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.specialization ?? "",
                          textAlign: TextAlign.start,
                          style: CustomTheme.textTheme(color: Colors.black)
                              .bodyMedium,
                        ),
                        Row(
                          children: [
                            const FaIcon(FontAwesomeIcons.mapLocation),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.address ?? "الموقع",
                                style:
                                    CustomTheme.textTheme(color: Colors.black)
                                        .bodySmall,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.end,
                                    "تواصل عن طريق التطبيق",
                                    style: CustomTheme.textTheme(
                                            color: Colors.grey)
                                        .bodyMedium,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Chatting.routeName,
                                        arguments: item);
                                  },
                                  child: Hero(
                                    tag: "${Chatting.routeName}_${item.name}",
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          right: 2.0, bottom: 2),
                                      child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Color(0xffFAAD40),
                                          child: FaIcon(
                                            FontAwesomeIcons.message,
                                            color: Colors.white,
                                            size: 15,
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VeterBox extends UserBox {
  const VeterBox({super.key, required VeterinaryModel item})
      : super(item: item);
}
