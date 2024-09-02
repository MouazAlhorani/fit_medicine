import 'dart:convert';

import 'package:fit_med/models/user_model.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:fit_med/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Peoples extends StatelessWidget {
  const Peoples({super.key});

  @override
  Widget build(BuildContext context) {
    String peoples = '''{  "sucsses":true,
                        "data":{
                               "veter": [
                          {

                            "id": 1,
                            "username" : "doctor_name_1",
                            "fullname" : "doctor_fullname_1",
                            "image" : null,
                            "email" : "d1@d.com",
                            "mobile" : "0992738933",
                            "details" : "طبيب أمراض هضمية"
                          },
                            {
                            "id": 2,
                            "username" : "doctor_name_2",
                            "fullname" : "doctor_fullname_2",
                            "image" : null,
                            "email" : "d2@d.com",
                            "mobile" : "0992738933",
                            "details" : "طبيب أمراض صدرية"
                          },
                            {
                            "id": 3,
                            "username" : "doctor_name_3",
                            "fullname" : "doctor_fullname_3",
                            "image" : null,
                            "email" : "d3@d.com",
                            "mobile" : "0992738933",
                            "details" : "طبيب أمراض جلدية"
                          },
                          ],
                          "breeder": [
                           {
                            "id": 4,
                            "username" : "breeder_name_1",
                            "fullname" : "breeder_fullname_1",
                            "image" : null,
                            "email" : "b1@d.com",
                            "mobile" : "0992738933",
                          },
                            {
                            "id": 5,
                            "username" : "breeder_name_2",
                            "fullname" : "breeder_fullname_2",
                            "image" : null,
                            "email" : "b2@d.com",
                            "mobile" : "0992738933",
                          },
                                              ]
                                }
                      }''';
    return Expanded(
        child: Column(children: [
      searchBox(),
      FutureBuilder(
          future: Future(() async => await jsonDecode(peoples)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData) {
              return const Center(child: Text("خطأ في الوصول للمخدم"));
            } else {
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text("لا يوجد أي أشخاص حالياً"));
              } else {
                List<UserModel> peoples = [];
                for (var i in snapshot.data!['data']['veter']) {
                  peoples.add(VeterinaryModel.fromdata(data: i));
                }
                for (var i in snapshot.data!['data']['breeder']) {
                  peoples.add(BreederModel.fromdata(data: i));
                }
                return Expanded(
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xffE17C00).withOpacity(0.7),
                                  const Color(0xffE17C00).withOpacity(0.4),
                                  const Color(0xffE17C00).withOpacity(0.3),
                                  const Color(0xffE17C00).withOpacity(0.2),
                                  const Color(0xffE17C00).withOpacity(0.1),
                                ]),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                height: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ...peoples.map((e) => Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: e.photo == null
                                                    ? const FaIcon(
                                                        FontAwesomeIcons.user)
                                                    : Image.network(
                                                        e.photo!,
                                                        height: 75,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                            Text(
                                              e.name,
                                              style: CustomTheme.textTheme(
                                                      color: Colors.black)
                                                  .titleMedium,
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25))),
                                child: ListView(
                                  children: [
                                    ...peoples.map((u) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.network(
                                                  u.photo!,
                                                  height: 75,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Text(
                                                u.name,
                                                style: CustomTheme.textTheme(
                                                        color: Colors.black)
                                                    .titleMedium,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    })
                                  ],
                                ),
                              ),
                            ))
                          ],
                        )));
              }
            }
          }),
    ]));
  }
}
