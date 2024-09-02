// import 'package:fit_med/controllers/speek_provider.dart';
// import 'package:fit_med/methods/textToSpeek_method.dart';
// import 'package:fit_med/models/speek_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;

// class SpeekTotext extends StatelessWidget {
//   const SpeekTotext({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => SpeekProvider(),
//       child: ListenApp(),
//     );
//   }
// }

// class ListenApp extends StatelessWidget {
//   const ListenApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     SpeekModel isListen = context.watch<SpeekProvider>().listenW;
//     TextEditingController textc = TextEditingController(text: isListen.text);
//     return Row(
//       children: [
//         Expanded(
//             child: TextFormField(
//           controller: textc,
//           decoration: InputDecoration(
//               label: Text("اكتب للبحث او تحدث بعد الضغط على الميكروفون")),
//         )),
//         IconButton(
//             onPressed: () {
//               speekToText(isListening: isListen.isListening, ctx: context);
//             },
//             icon: Icon(isListen.icon)),
//         IconButton(
//             onPressed: () {
//               textToSpeek(textc.text);
//             },
//             icon: Icon(Icons.play_arrow))
//       ],
//     );
//   }

//   speekToText({bool isListening = false, required BuildContext ctx}) async {
//     stt.SpeechToText _speech = stt.SpeechToText();

//     if (!isListening) {
//       bool available = await _speech
//           .initialize(options: [stt.SpeechToText.androidIntentLookup]);
//       if (available) {
//         _speech.listen(
//           onResult: (val) {
//             ctx.read<SpeekProvider>().listenW = SpeekModel(
//                 isListening: true, icon: Icons.mic, text: val.recognizedWords);
//           },
//           onSoundLevelChange: (level) {
//             if (level == 0) {
//               ctx.read<SpeekProvider>().listenW = SpeekModel(
//                   isListening: false,
//                   icon: Icons.mic_none_rounded,
//                   text: ctx.read<SpeekProvider>().listenW.text);
//               _speech.stop();
//             }
//           },
//         );
//       }
//     }
//   }
// }
