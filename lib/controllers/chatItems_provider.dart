import 'package:fit_med/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart' as just_audio;

class ChatItemsProvider extends ChangeNotifier {
  ScrollController scrollController = ScrollController();
  final List<ChatModel?> _chatItems = [];
  List<ChatModel?> get chatItems => _chatItems;

  getScrollcontroller() {
    return scrollController;
  }

  additem(ChatModel? contents) {
    _chatItems.add(contents);
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 200,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );

    notifyListeners();
  }

  selectitem({required ChatModel item}) {
    item.choosen = !item.choosen;
    notifyListeners();
  }

  removeitem({mainindex, required toRemove}) {
    _chatItems.removeWhere((number) => toRemove.contains(number));
    notifyListeners();
  }

  prepareAudio({required ChatModel item}) async {
    try {
      await item.recorder!.setFilePath(item.content!);

      item.recorder!.positionStream.listen((position) {
        item.position = position;
        notifyListeners();
      });
    } catch (e) {}
    item.recorder!.playerStateStream.listen((playerState) {
      if (playerState.processingState == just_audio.ProcessingState.completed) {
        item.recorder!.stop();
        item.mainicon = FontAwesomeIcons.play;
        item.position = Duration.zero;
        notifyListeners();
      }
    });
  }

  getaudioduration({path}) async {
    just_audio.AudioPlayer audio = just_audio.AudioPlayer();
    try {
      await audio.setFilePath(path);
      await audio.load();
      Duration? dur = audio.duration;
      if (dur != null) {
        if (dur.inMinutes < 1) {
          return "${dur.inSeconds} sec.";
        }
        return "${dur.inMinutes} min.";
      }
    } catch (e) {}
  }

  playAudio({required ChatModel item}) async {
    await prepareAudio(item: item);
    just_audio.PlayerState audiostate = item.recorder!.playerState;

    item.recorder!.playerStateStream.listen((state) {
      audiostate = state;
    });

    for (var i in _chatItems.where((e) => e!.type == ContentType.voiceRecord)) {
      if (i != item) {
        await i!.recorder!.stop();
        i.mainicon = FontAwesomeIcons.play;
      }
    }
    if (audiostate.playing || item.pauseicon == FontAwesomeIcons.play) {
      item.mainicon = FontAwesomeIcons.play;
      item.pauseicon = FontAwesomeIcons.pause;
      await item.recorder!.stop();
    } else {
      item.mainicon = FontAwesomeIcons.stop;
      item.pauseicon = FontAwesomeIcons.pause;
      await item.recorder!.play();
    }
    notifyListeners();
  }

  pausePlayer({required ChatModel item}) async {
    just_audio.PlayerState audiostate = item.recorder!.playerState;

    if (audiostate.playing) {
      item.pauseicon = FontAwesomeIcons.play;
      await item.recorder!.pause();
    } else {
      item.pauseicon = FontAwesomeIcons.pause;
      await item.recorder!.play();
    }

    notifyListeners();
  }

  stopallplayer() async {
    for (var i in _chatItems.where((e) => e!.type == ContentType.voiceRecord)) {
      await i!.recorder!.stop();
    }
    notifyListeners();
  }

  seek({position, required ChatModel item}) async {
    await item.recorder!.seek(item.duration! - position);
    notifyListeners();
  }
}
