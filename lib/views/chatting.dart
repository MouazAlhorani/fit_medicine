import 'dart:io';
import 'package:fit_med/controllers/chatItems_provider.dart';
import 'package:fit_med/controllers/audiorecorder_provider.dart';
import 'package:fit_med/controllers/pickImage_provider.dart';
import 'package:fit_med/controllers/textformfield_provider.dart';
import 'package:fit_med/methods/imagepick_method.dart';
import 'package:fit_med/models/chat_model.dart';
import 'package:fit_med/models/user_model.dart';
import 'package:fit_med/statics.dart';
import 'package:fit_med/themes/light_mode.dart';
import 'package:fit_med/widgets/chat_box.dart';
import 'package:fit_med/widgets/chatappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;
import 'package:just_audio/just_audio.dart' as just_audio;

class Chatting extends StatelessWidget {
  static String routeName = "Chatting";
  const Chatting({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = ModalRoute.of(context)!.settings.arguments as UserModel;

    List<ChatModel?> chatItemsWatch =
        context.watch<ChatItemsProvider>().chatItems;
    ChatItemsProvider chatItemsRead = context.read<ChatItemsProvider>();

    List<String?> imageWatch = context.watch<PickimageProvider>().imagepathes;
    PickimageProvider? imageRead = context.read<PickimageProvider>();
    File? chatimage;
    TFMModel tfmWatch = context.watch<TFMProvider>().tf;
    TFMProvider tfmRead = context.read<TFMProvider>();
    final ScrollController chatscrollController =
        context.watch<ChatItemsProvider>().getScrollcontroller();

    ARModel arWatch = context.watch<ARProvider>().recorder;
    ARProvider arRead = context.read<ARProvider>();

    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                appBar: AppBar(
                  flexibleSpace: Hero(
                      tag: "${routeName}_${user.name}",
                      child: Chatappbar(item: user)),
                ),
                body: Column(children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: chatscrollController,
                      child: Column(
                        children: [
                          SizedBox(
                            height: chatItemsWatch.isEmpty ? 500 : 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(500),
                                    child: ConstrainedBox(
                                        constraints: const BoxConstraints(
                                            minHeight: 120,
                                            minWidth: 120,
                                            maxHeight: 140,
                                            maxWidth: 140),
                                        child: Center(
                                          child: user.photo != null
                                              ? Image.network(
                                                  user.photo!,
                                                  fit: BoxFit.cover,
                                                )
                                              : const FaIcon(
                                                  FontAwesomeIcons.userDoctor,
                                                  size: 70,
                                                ),
                                        ))),
                                ListTile(
                                  title: Text(
                                    textAlign: TextAlign.center,
                                    user.name,
                                    style: CustomTheme.textTheme().titleMedium,
                                  ),
                                  subtitle: Text(
                                    textAlign: TextAlign.center,
                                    user.specialization ?? '',
                                    style: CustomTheme.textTheme(
                                            color: Colors.black)
                                        .titleSmall,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: chatItemsWatch.isEmpty,
                            child: SizedBox(
                              height: 200,
                              child: Center(
                                child: Text(
                                  "بدء الدردشة",
                                  style:
                                      CustomTheme.textTheme(color: Colors.grey)
                                          .titleLarge,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                              visible: chatItemsWatch.isNotEmpty,
                              child: Column(
                                children: [
                                  ...chatItemsWatch.map((e) => ChatBox(
                                        item: e,
                                        index: chatItemsWatch.indexOf(e),
                                        playrecord: () => chatItemsRead
                                            .playAudio(item: e!.content),
                                        pauserecord: () => chatItemsRead
                                            .pausePlayer(item: e!.content),
                                      ))
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                  choosenItemsbar(chatItemsWatch, chatItemsRead),
                  Stack(children: [
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: imageWatch.isNotEmpty
                                        ? null
                                        : Border.all(color: Colors.green)),
                                child: Column(
                                  children: [
                                    imageWatch.isNotEmpty
                                        ? pickedImagesbeforSend(
                                            imageWatch, imageRead)
                                        : const SizedBox(),
                                    KeyboardListener(
                                      focusNode: FocusNode(),
                                      onKeyEvent: (KeyEvent event) {
                                        if (event.logicalKey ==
                                                LogicalKeyboardKey.enter ||
                                            event.physicalKey ==
                                                PhysicalKeyboardKey.enter) {
                                          final newText =
                                              '${tfmWatch.controller.text}\n';
                                          tfmWatch.controller.value =
                                              TextEditingValue(
                                            text: newText,
                                            selection: TextSelection.collapsed(
                                                offset: newText.length),
                                          );
                                          tfmRead.addline();
                                        } else if (event.logicalKey ==
                                            LogicalKeyboardKey.backspace) {
                                          if (tfmWatch.controller.text
                                              .endsWith('\n')) {
                                            tfmRead.removeline();
                                          }
                                        }
                                      },
                                      child: textFieldSender(
                                          tfmWatch,
                                          imageWatch,
                                          chatItemsRead,
                                          tfmRead,
                                          imageRead),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  chatimage =
                                      await pickImage(ImageSource.gallery);
                                  if (chatimage != null) {
                                    imageRead.addimage(chatimage!.path);
                                  }
                                },
                                icon: const FaIcon(
                                  Icons.image_outlined,
                                  color: Colors.green,
                                )),
                            IconButton(
                                onPressed: () async {
                                  chatimage =
                                      await pickImage(ImageSource.camera);
                                  if (chatimage != null) {
                                    imageRead.addimage(chatimage!.path);
                                  }
                                },
                                icon: const FaIcon(
                                  Icons.linked_camera_outlined,
                                  color: Colors.green,
                                )),
                            GestureDetector(
                              onTap: arWatch.status
                                  ? null
                                  : () => arRead.startrecorder(
                                      chatitemsRead: chatItemsRead),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Transform.translate(
                                  offset: Offset(0, arWatch.status ? -20 : 0),
                                  child: FaIcon(
                                    arWatch.status ? Icons.mic : Icons.mic_none,
                                    color: Colors.green,
                                    size: arWatch.status ? 40 : 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    arWatch.status == true
                        ? Padding(
                            padding: const EdgeInsets.only(left: 70),
                            child: SizedBox(
                              height: 80,
                              child: Card(
                                child: recordVoiceSender(
                                    arWatch, arRead, context, chatItemsRead),
                              ),
                            ),
                          )
                        : const SizedBox()
                  ])
                ]))));
  }

  Row recordVoiceSender(ARModel arWatch, ARProvider arRead,
      BuildContext context, ChatItemsProvider chatItemsRead) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 1), (x) => x),
          builder: (context, snapshot) {
            if (snapshot.hasData && arWatch.status) {
              final seconds = snapshot.data! % 60;
              final minutes = snapshot.data! ~/ 60;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'),
              );
            } else {
              return const SizedBox();
            }
          }),
      const Spacer(),
      TextButton(
          child: Text(
            'إرسال',
            style: CustomTheme.textTheme(color: Colors.green).bodyMedium,
          ),
          onPressed: () async {
            await arRead.stoprecorder();
            if (arWatch.filepath != null && context.mounted) {
              String name = p.basenameWithoutExtension(arWatch.filepath!);
              // var ss = await File(arWatch.filepath!)
              //     .readAsBytes();
              // String size =
              //     (ss.lengthInBytes / 1024 / 1024)
              //         .toStringAsFixed(1);
              chatItemsRead.additem(ChatModel<String>(
                  time: DateTime.now(),
                  type: ContentType.voiceRecord,
                  senderId: kmyid,
                  recipientId: 1,
                  recorder: just_audio.AudioPlayer(),
                  mainicon: FontAwesomeIcons.play,
                  pauseicon: FontAwesomeIcons.pause,
                  duration: Duration.zero,
                  position: Duration.zero,
                  content: arWatch.filepath!,
                  details: name));
            }
          }),
      TextButton(
        child: Text(
          'إلغاء',
          style: CustomTheme.textTheme(color: Colors.red).bodyMedium,
        ),
        onPressed: () => arRead.cancle(),
      )
    ]);
  }

  TextFormField textFieldSender(
    TFMModel tfmWatch,
    List<String?> imageWatch,
    ChatItemsProvider chatItemsRead,
    TFMProvider tfmRead,
    PickimageProvider imageRead,
  ) {
    return TextFormField(
        controller: tfmWatch.controller,
        keyboardType: TextInputType.multiline,
        maxLines: tfmWatch.maxlines,
        decoration: InputDecoration(
            prefixIcon: IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.faceSmile)),
            suffixIcon: IconButton(
                onPressed: () {
                  if (tfmWatch.controller.text.isNotEmpty ||
                      imageWatch.isNotEmpty) {
                    chatItemsRead.additem(
                      ChatModel<List<String?>>(
                        type: ContentType.image,
                        senderId: kmyid,
                        recipientId: 1,
                        time: DateTime.now(),
                        content: imageWatch,
                      ),
                    );
                    chatItemsRead.additem(
                      ChatModel<String>(
                        senderId: kmyid,
                        recipientId: 1,
                        time: DateTime.now(),
                        content: tfmWatch.controller.text,
                      ),
                    );

                    tfmRead.clear();
                    imageRead.reset();
                  }
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.green,
                )),
            hintText: "كتابة رسالة",
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green))));
  }
}

SingleChildScrollView pickedImagesbeforSend(
  List<String?> imageWatch,
  PickimageProvider imageRead,
) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        ...imageWatch.map((e) => Stack(
              children: [
                Image.file(
                  File(e!),
                  height: 120,
                  width: 120,
                ),
                Positioned(
                    left: 0,
                    child: IconButton.filled(
                        onPressed: () => imageRead.removeimage(e),
                        icon: const Icon(Icons.close)))
              ],
            ))
      ],
    ),
  );
}

Visibility choosenItemsbar(
  List<ChatModel<dynamic>?> chatItemsWatch,
  ChatItemsProvider chatItemsRead,
) {
  return Visibility(
      visible: chatItemsWatch.any((e) => e!.choosen),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "العناصر المحددة ${chatItemsWatch.where((e) => e!.choosen).length}",
            style: CustomTheme.textTheme().bodyMedium,
          ),
          TextButton.icon(
              icon: const FaIcon(FontAwesomeIcons.xmark),
              onPressed: () {
                List toRemove = [];

                for (var i in chatItemsWatch) {
                  if (i!.choosen) {
                    toRemove.add(i);
                  }
                }
                chatItemsRead.removeitem(toRemove: toRemove);
              },
              label: Text(
                "حذف",
                style: CustomTheme.textTheme(color: Colors.red).bodyMedium,
              )),
          TextButton.icon(
              icon: const FaIcon(FontAwesomeIcons.forward),
              onPressed: () {},
              label: Text(
                "تحويل",
                style: CustomTheme.textTheme(color: Colors.blue).bodyMedium,
              ))
        ],
      ));
}
