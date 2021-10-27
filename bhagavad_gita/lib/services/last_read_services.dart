import 'dart:async';

import 'package:bhagavad_gita/models/verse_detail_model.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:flutter/material.dart';

class LastReadVerseService {
  StreamController<LastReadVerse?> _lastReadController =
      StreamController<LastReadVerse?>.broadcast();

  LastReadVerseService() {
    print("Stream controller init");
    Future.delayed(Duration(milliseconds: 200), () async {
      var lastRead = await SharedPref.getLastRead();
      _lastReadController.add(lastRead);
    });
  }

  saveLastRead(LastReadVerse lastReadVerse) {
    SharedPref.saveLastRead(lastReadVerse);
    _lastReadController.add(lastReadVerse);
  }

  Stream<LastReadVerse?> get lastReadStream => _lastReadController.stream;
}

class LocalNotification {
  static LocalNotification instance = new LocalNotification();

  ValueNotifier<LastReadVerse?> needToShowLastRead = ValueNotifier(null);

  void setNeedToShowLastRead(LastReadVerse lastReadVerse) {
    SharedPref.saveLastRead(lastReadVerse);
    needToShowLastRead.value = lastReadVerse;
    needToShowLastRead.notifyListeners();
  }
}
