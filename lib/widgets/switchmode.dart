// import 'package:fit_med/controllers/switchmode_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';

// class SwitchMode extends StatelessWidget {
//   const SwitchMode({super.key});

//   @override
//   Widget build(BuildContext context) {
//     IconData icon() =>
//         context.watch<SwitchModeProvider>().theme == ThemeData.light()
//             ? FontAwesomeIcons.solidMoon
//             : FontAwesomeIcons.sun;
//     return IconButton(
//       onPressed: () {
//         context.read<SwitchModeProvider>().toggoletheme();
//       },
//       icon: FaIcon(
//         icon(),
//       ),
//     );
//   }
// }
