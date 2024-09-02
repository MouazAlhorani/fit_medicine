import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

searchBox() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: DecoratedBox(
      decoration: BoxDecoration(
          color: const Color.fromARGB(87, 158, 158, 158),
          borderRadius: BorderRadius.circular(25)),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: 'بحث',
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(25), right: Radius.circular(25))),
            prefixIcon: IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.magnifyingGlass))),
      ),
    ),
  );
}
