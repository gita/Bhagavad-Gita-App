import 'dart:async';
import 'dart:convert';
import 'package:bhagavad_gita/Constant/string_constant.dart';
import 'package:bhagavad_gita/models/notes_model.dart';
import 'package:bhagavad_gita/models/verse_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceConstant {
  static String lastRead = 'lastRead';
  static String bookMarkVerse = 'bookMarkVerse';
  static String verseNotes = 'verseNotes';
  static String language = "language";
  static String skipOnboardScreen = "skipOnboardScreen";
  static String onChangeFontFamily = 'onChangeFontFamily';
}

class SharedPref {
  static Future<bool> saveLastRead(LastReadVerse lastReadVerse) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        PreferenceConstant.lastRead, jsonEncode(lastReadVerse));
    return true;
  }

  static Future<LastReadVerse?> getLastRead() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? temp = sharedPreferences.getString(PreferenceConstant.lastRead);
    print("Last Read : $temp");
    if (temp != null) {
      var lastRead = jsonDecode(temp);
      print("Last Read : $lastRead");
      var tempRead = lastRead as Map<String, dynamic>;
      return LastReadVerse.fromJson(tempRead);
    }
    return null;
  }

  static Future<bool> saveBookmarkVerse(LastReadVerse lastReadVerse) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? temp =
        sharedPreferences.getString(PreferenceConstant.bookMarkVerse);
    if (temp != null) {
      var temp1 = jsonDecode(temp) as List;

      var tempArrayLsit = temp1.map((e) {
        var t2 = e as Map<String, dynamic>;
        return LastReadVerse.fromJson(t2);
      });
      var t3 = tempArrayLsit
          .where((element) => element.verseID == lastReadVerse.verseID);
      if (t3.isEmpty) {
        print("Not added");
        temp1.insert(0, lastReadVerse.toJson());
        sharedPreferences.setString(
            PreferenceConstant.bookMarkVerse, jsonEncode(temp1));
      }
    } else {
      var temp1 = jsonEncode([lastReadVerse.toJson()]);
      print("Temp 1: $temp1");
      sharedPreferences.setString(PreferenceConstant.bookMarkVerse, temp1);
    }
    return true;
  }

  static Future<bool> checkVerseIsSavedOrNot(String verseID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? temp =
        sharedPreferences.getString(PreferenceConstant.bookMarkVerse);
    if (temp != null) {
      var temp1 = jsonDecode(temp) as List;

      var tempArrayLsit = temp1.map((e) {
        var t2 = e as Map<String, dynamic>;
        return LastReadVerse.fromJson(t2);
      });
      var t3 = tempArrayLsit.where((element) => element.verseID == verseID);
      if (t3.isEmpty) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  static Future<bool> removeVerseFromSaved(String verseID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? temp =
        sharedPreferences.getString(PreferenceConstant.bookMarkVerse);
    if (temp != null) {
      var temp1 = jsonDecode(temp) as List;

      var tempArrayLsit = temp1.map((e) {
        var t2 = e as Map<String, dynamic>;
        return LastReadVerse.fromJson(t2);
      });
      var t3 = tempArrayLsit.where((element) => element.verseID != verseID);
      if (t3.isEmpty) {
        sharedPreferences.remove(PreferenceConstant.bookMarkVerse);
      } else {
        var t4 = t3.map((e) {
          return e.toJson();
        }).toList();

        sharedPreferences.setString(
            PreferenceConstant.bookMarkVerse, jsonEncode(t4));
      }
    }
    return true;
  }

  static Future<List<LastReadVerse>> getAllSaveBookmarkVerse() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? temp =
        sharedPreferences.getString(PreferenceConstant.bookMarkVerse);
    if (temp != null) {
      var temp1 = jsonDecode(temp) as List;

      var tempArrayLsit = temp1.map((e) {
        var t2 = e as Map<String, dynamic>;
        return LastReadVerse.fromJson(t2);
      }).toList();
      return tempArrayLsit;
    }
    return [];
  }

  ///// Save and fetch verse notes
  static Future<bool> saveVerseNotes(VerseNotes verseNotes) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? temp = sharedPreferences.getString(PreferenceConstant.verseNotes);
    if (temp != null) {
      var temp1 = jsonDecode(temp) as List;

      var tempArrayLsit = temp1.map((e) {
        var t2 = e as Map<String, dynamic>;
        return VerseNotes.fromJson(t2);
      });
      var t3 = tempArrayLsit
          .where((element) => element.verseID == verseNotes.verseID);
      if (t3.isEmpty) {
        print("Not added");
        temp1.insert(0, verseNotes.toJson());
        sharedPreferences.setString(
            PreferenceConstant.verseNotes, jsonEncode(temp1));
      } else {
        var t3 = tempArrayLsit
            .where((element) => element.verseID != verseNotes.verseID);
        var t4 = t3.map((e) {
          return e.toJson();
        }).toList();
        t4.insert(0, verseNotes.toJson());
        sharedPreferences.setString(
            PreferenceConstant.verseNotes, jsonEncode(t4));
      }
    } else {
      var temp1 = jsonEncode([verseNotes.toJson()]);
      print("Temp 1: $temp1");
      sharedPreferences.setString(PreferenceConstant.verseNotes, temp1);
    }
    return true;
  }

  static Future<VerseNotes?> checkVerseNotesIsSavedOrNot(String verseID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? temp = sharedPreferences.getString(PreferenceConstant.verseNotes);
    if (temp != null) {
      var temp1 = jsonDecode(temp) as List;

      var tempArrayLsit = temp1.map((e) {
        var t2 = e as Map<String, dynamic>;
        return VerseNotes.fromJson(t2);
      });
      var t3 = tempArrayLsit.where((element) => element.verseID == verseID);
      if (t3.isEmpty) {
        return null;
      } else {
        return t3.first;
      }
    }
    return null;
  }

  static Future<bool> removeVerseNotesFromSaved(String verseID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? temp = sharedPreferences.getString(PreferenceConstant.verseNotes);
    if (temp != null) {
      var temp1 = jsonDecode(temp) as List;

      var tempArrayLsit = temp1.map((e) {
        var t2 = e as Map<String, dynamic>;
        return VerseNotes.fromJson(t2);
      });
      var t3 = tempArrayLsit.where((element) => element.verseID != verseID);
      if (t3.isEmpty) {
        sharedPreferences.remove(PreferenceConstant.verseNotes);
      } else {
        var t4 = t3.map((e) {
          return e.toJson();
        }).toList();

        sharedPreferences.setString(
            PreferenceConstant.verseNotes, jsonEncode(t4));
      }
    }
    return true;
  }

  static Future<List<VerseNotes>> getAllSavedVerseNotes() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? temp = sharedPreferences.getString(PreferenceConstant.verseNotes);
    if (temp != null) {
      var temp1 = jsonDecode(temp) as List;

      var tempArrayLsit = temp1.map((e) {
        var t2 = e as Map<String, dynamic>;
        return VerseNotes.fromJson(t2);
      }).toList();
      return tempArrayLsit;
    }
    return [];
  }

  //// Save language
  static Future savelanguage(String language) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        PreferenceConstant.language, jsonEncode(language));
  }

  static Future<String?> getLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? temp = sharedPreferences.getString(PreferenceConstant.language);
    if (temp == null) {
      return "english";
    }
    return temp;
  }

  Locale getLocal() {
    Locale _temp;
    switch (langauge) {
      case 'english':
        _temp = Locale('en', 'US');
        break;
      default:
        _temp = Locale('hi', 'IN');
    }
    return _temp;
  }

  ///// Save and Check onboarding screen pass or not
  static saveSkipOnboardScreen() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(PreferenceConstant.skipOnboardScreen, true);
  }

  static Future<bool> checkOnBoardScreenIsSkip() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isSkip =
        sharedPreferences.getBool(PreferenceConstant.skipOnboardScreen);
    if (isSkip == null) {
      return false;
    }
    return isSkip;
  }
}
