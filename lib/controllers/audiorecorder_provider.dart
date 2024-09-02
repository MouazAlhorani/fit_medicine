import 'dart:io';
import 'package:fit_med/controllers/chatItems_provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:intl/intl.dart' as dt;

class ARModel {
  AudioRecorder recorder;
  bool status;
  String? filepath;
  ARModel({
    required this.recorder,
    required this.status,
    required this.filepath,
  });
}

class ARProvider extends ChangeNotifier {
  final ARModel _recorder =
      ARModel(recorder: AudioRecorder(), status: false, filepath: null);
  ARModel get recorder => _recorder;
  startrecorder({required ChatItemsProvider chatitemsRead}) async {
    await chatitemsRead.stopallplayer();
    Directory appDir = await getApplicationDocumentsDirectory();
    Directory recordDir = Directory('${appDir.path}/chats/records');
    if (!await recordDir.exists()) {
      await recordDir.create(recursive: true);
    }
    _recorder.filepath =
        "${recordDir.path}/me__${dt.DateFormat('yyyy_MM_dd_HH_mm_ss').format(DateTime.now())}_aa.aac";
    _recorder.status = true;
    await _recorder.recorder
        .start(const RecordConfig(), path: _recorder.filepath!);
    notifyListeners();
  }

  stoprecorder() async {
    _recorder.status = false;
    _recorder.filepath = _recorder.filepath!;
    await _recorder.recorder.stop();
    notifyListeners();
  }

  cancle() async {
    _recorder.status = false;
    _recorder.filepath = null;
    await _recorder.recorder.stop();
    notifyListeners();
  }
}
