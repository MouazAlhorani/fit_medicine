import 'dart:io';
import 'package:fit_med/controllers/chatItems_provider.dart';
import 'package:fit_med/models/chat_model.dart';
import 'package:fit_med/statics.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({
    super.key,
    required this.item,
    required this.index,
    this.playrecord,
    this.pauserecord,
  });
  final ChatModel? item;
  final int index;
  final Function()? playrecord;
  final Function()? pauserecord;

  @override
  Widget build(BuildContext context) {
    List<ChatModel?> chatItemsWatch =
        context.watch<ChatItemsProvider>().chatItems;
    ChatItemsProvider chatItemsRead = context.read<ChatItemsProvider>();
    return GestureDetector(
      onLongPress: () {
        chatItemsRead.selectitem(item: item!);
      },
      onTap: () {
        if (chatItemsWatch.any((o) => o!.choosen)) {
          chatItemsRead.selectitem(item: item!);
        }
      },
      child: Stack(
        children: [
          Align(
              alignment: item!.senderId == kmyid
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  decoration: BoxDecoration(
                      borderRadius: index == 0 && item!.senderId == kmyid
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(25))
                          : index == 0 && item!.senderId != kmyid
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                  topRight: Radius.circular(25))
                              : BorderRadius.circular(25),
                      color: item!.senderId == kmyid
                          ? const Color(0xffFFDCAB)
                          : const Color(0xffE2E4DE)),
                  child: Column(
                    children: [
                      ...item!.content.map((e) {
                        return e == null
                            ? const SizedBox()
                            : e.type == 'text'
                                ? textWidget(e)
                                : e.type == 'image'
                                    ? imageWidget(context, e)
                                    : reocorderWidget(e, context);
                      })
                    ],
                  ))),
          Positioned.fill(
            child: Container(
              color: item!.choosen
                  ? Colors.blueGrey.withOpacity(0.3)
                  : Colors.transparent,
            ),
          )
        ],
      ),
    );
  }

  ConstrainedBox textWidget(e) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 150),
      child: SelectableText(e.content!),
    );
  }

  GestureDetector imageWidget(BuildContext context, e) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                content: Image.file(
                  File(e.content!),
                  width: 500,
                  fit: BoxFit.cover,
                ),
              );
            });
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(
              File(e.content),
              width: 200,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector reocorderWidget(e, BuildContext context) {
    return GestureDetector(
      child: Column(children: [
        Text(e.details!),
        Row(
          children: [
            IconButton(
                onPressed: playrecord,
                icon: Transform.scale(
                  scale: -1,
                  child: FaIcon(
                    e.mainicon,
                  ),
                )),
            Visibility(
              visible: e.recorder!.playing ||
                  e.recorder!.processingState == ProcessingState.ready,
              child: IconButton(
                  onPressed: pauserecord,
                  icon: Transform.scale(
                    scale: -1,
                    child: FaIcon(
                      e.pauseicon,
                    ),
                  )),
            ),
            GestureDetector(
              onTapDown: (details) async {
                double relativePosition = details.localPosition.dx / 250;
                Duration newPosition = Duration(
                  seconds: (relativePosition * e.duration!.inSeconds).toInt(),
                );
                context
                    .read<ChatItemsProvider>()
                    .seek(position: newPosition, item: e);
              },
              child: Stack(
                children: [
                  Container(
                      height: 20,
                      width: 250,
                      decoration: const BoxDecoration(color: Colors.grey)),
                  Positioned(
                    right: -10,
                    child: Visibility(
                      child: TweenAnimationBuilder(
                        curve: Curves.bounceInOut,
                        tween: Tween<double>(
                            begin: 0.0,
                            end: e.position!.inSeconds.toDouble() /
                                e.duration!.inSeconds.toDouble()),
                        duration: const Duration(milliseconds: 100),
                        builder: (context, end, child) {
                          return Transform.scale(
                            origin: const Offset(0, 0),
                            scaleX: -end.toDouble() * 25,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: 20,
                              width: 10,
                              color: Colors.deepOrange,
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Text("${e.position!.inSeconds.toDouble()}"),
        ),
      ]),
    );
  }
}
