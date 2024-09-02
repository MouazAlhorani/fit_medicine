import 'package:fit_med/controllers/boolean_provider.dart';
import 'package:fit_med/models/disease_model.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:fit_med/views/showDisease.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DiseaseBox extends StatelessWidget {
  final DiseaseModel item;
  const DiseaseBox({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          context.read<ShowMoreProvider>().reset(4);
          Navigator.pushNamed(context, Showdisease.routeName, arguments: item);
        },
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ConstrainedBox(
                  constraints: const BoxConstraints(
                      minHeight: 50,
                      minWidth: 50,
                      maxHeight: 100,
                      maxWidth: 100),
                  child: Center(
                      child: item.image != null
                          ? Image.network(item.image!, fit: BoxFit.cover)
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
                            item.type ?? "",
                            textAlign: TextAlign.start,
                            style: CustomTheme.textTheme(color: Colors.black)
                                .bodyMedium,
                          ),
                          Row(
                            children: [
                              const Text("العلاج"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: Colors.orangeAccent.shade100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          item.medicine != null
                                              ? item.medicine!.name
                                              : "",
                                          style: CustomTheme.textTheme(
                                                  color: Colors.black)
                                              .bodySmall,
                                        ),
                                        const SizedBox(
                                          width: 40,
                                        ),
                                        const FaIcon(FontAwesomeIcons.flask)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
