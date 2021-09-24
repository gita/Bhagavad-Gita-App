import 'dart:convert';
import 'package:bhagavad_gita/models/verse_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceConstant {
  static String lastRead = 'lastRead';
  static String bookMarkVerse = 'bookMarkVerse';
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
      var temp1 = jsonDecode(temp);
      print("Temp 3 : $temp1");
      temp1.add(lastReadVerse.toJson());
      print("Temp 2 : $temp1");
      sharedPreferences.setString(
          PreferenceConstant.bookMarkVerse, jsonEncode(temp1));
    } else {
      var temp1 = jsonEncode([lastReadVerse.toJson()]);
      print("Temp 1: $temp1");
      sharedPreferences.setString(PreferenceConstant.bookMarkVerse, temp1);
    }
    return true;
  }
}
