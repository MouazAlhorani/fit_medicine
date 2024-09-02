import 'dart:convert';

import 'package:fit_med/models/group_model.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:fit_med/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Groups extends StatelessWidget {
  const Groups({super.key});

  @override
  Widget build(BuildContext context) {
    String data = '''{  "sucsses":true,
                        "data":{
                               "groups": [
                          {
                            "id": 1,
                            "name": "مربي الأبقار",
                            "image": null,
                            "members": []
                          },
                            {
                            "id": 2,
                            "name": "مربي الكلاب",
                            "image": null,
                            "members": []
                          },
                            {
                            "id": 3,
                            "name": "مربي القطط",
                            "image": null,
                            "members": []
                          },
                                              ]
                                }
                      }''';
    return Expanded(
        child: Stack(children: [
      Column(
        children: [
          searchBox(),
          FutureBuilder(
              future: Future<List>(() async => await jsonDecode(data)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData) {
                  return const Center(child: Text("خطأ في الوصول للمخدم"));
                } else {
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text("لا يوجد أي مجموعات حالياً"));
                  } else {
                    List<GroupModel> groups = [];
                    for (var i in snapshot.data!) {
                      groups
                          .add(GroupModel.fromdata(data: i['data']['groups']));
                    }
                    return Expanded(
                        child: ListView(
                      children: [
                        ...groups.map((g) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: g.groupprofile == null
                                            ? const FaIcon(
                                                FontAwesomeIcons.userGroup)
                                            : Image.network(
                                                g.groupprofile!,
                                                fit: BoxFit.cover,
                                                height: 80,
                                              )),
                                    Transform.translate(
                                      offset: const Offset(-40, 50),
                                      child: const CircleAvatar(
                                          child: FaIcon(
                                        FontAwesomeIcons.userGroup,
                                        color: Colors.grey,
                                        size: 20,
                                      )),
                                    )
                                  ],
                                ),

                                //===========
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15.0),
                                          child: Text(
                                            "مجتمع ${g.groupname}",
                                            style: CustomTheme.textTheme(
                                                    color: Colors.black)
                                                .bodyLarge,
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: TextButton(
                                              style: TextButton.styleFrom(
                                                  shape:
                                                      const BeveledRectangleBorder(),
                                                  backgroundColor:
                                                      const Color(0xffFDECD4),
                                                  shadowColor: Colors.grey,
                                                  elevation: 2),
                                              onPressed: () {},
                                              child: Text(
                                                'الانضمام إلى الدردشة',
                                                style: CustomTheme.textTheme(
                                                        color: Colors.black)
                                                    .bodySmall,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //============
                                SizedBox(
                                  width: 80,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${g.members.isEmpty ? '0' : '${g.members.length}'} عضو",
                                        style: CustomTheme.textTheme(
                                                color: Colors.black)
                                            .bodySmall,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: FaIcon(
                                          FontAwesomeIcons.userGroup,
                                          color: Colors.lightGreen,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                      ],
                    ));
                  }
                }
              }),
        ],
      ),
      Positioned(
          bottom: 25,
          right: 25,
          child: DecoratedBox(
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(color: Colors.grey, offset: Offset(1, 1), blurRadius: 4)
            ], borderRadius: BorderRadius.circular(50)),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.lightGreen.withOpacity(0.7),
              child: IconButton(
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (_) {
                    //   return Creategroup();
                    // }));
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                    size: 40,
                  )),
            ),
          ))
    ]));
  }
}
