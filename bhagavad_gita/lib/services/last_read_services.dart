import 'package:bhagavad_gita/models/verse_detail_model.dart';
import 'package:bhagavad_gita/services/shared_preferences.dart';
import 'package:flutter/material.dart';

class LocalNotification {
  static LocalNotification instance = new LocalNotification();

  ValueNotifier<LastReadVerse?> needToShowLastRead = ValueNotifier(null);
  ValueNotifier<bool> needToRefreshVerseOfTheDay = ValueNotifier(false);

  void setNeedToShowLastRead(LastReadVerse lastReadVerse) {
    SharedPref.saveLastRead(lastReadVerse);
    needToShowLastRead.value = lastReadVerse;
    needToShowLastRead.notifyListeners();
  }

  void refreshVerseOfTheDay() {
    needToRefreshVerseOfTheDay.value = !needToRefreshVerseOfTheDay.value;
    needToRefreshVerseOfTheDay.notifyListeners();
  }
}
