import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project/Condroller_homepage.dart';

class GetRecentlyPlayed {
  static ValueNotifier<List<SongModel>> recentSongNotifier = ValueNotifier([]);
  static List<dynamic> recentlyplayed = [];

  static Future<void> addRecentlyPlayed(songid) async {
    final recentDB = await Hive.box('recentSongNotifier');
    await recentDB.add(songid);

    getRecentlySongs();
    recentSongNotifier.notifyListeners();
  }

  static Future<void> getRecentlySongs() async {
    final recentDB = await Hive.box('recentSongNotifier');
    recentlyplayed = recentDB.values.toList();

    displayRecentlySongs();
    recentSongNotifier.notifyListeners();
  }

  static Future<void> displayRecentlySongs() async {
    final recentDB =  Hive.box('recentSongNotifier');
    final recentSongItems = recentDB.values.toList();
    recentSongNotifier.value.clear();
    recentlyplayed.clear();
    for (int i = 0; i < recentSongItems.length; i++) {
      for (int j = 0; j < startsong.length; j++) {
        if (recentSongItems[i] == startsong[j].id) {
          recentSongNotifier.value.add(startsong[j]);
          recentlyplayed.add(startsong[j]);
          // print(recentlyplayed.length);
        }
      }
    }
  }
}
