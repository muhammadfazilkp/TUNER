import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project/Condroller_homepage.dart';

class MostDB {
  // static  final mostplayed = Hive.box<int>('Mostplay');
  static ValueNotifier<List<SongModel>> mostplaynotifier = ValueNotifier([]);

  static Future<void> addmostplayed(item) async {
    final mostDB = await Hive.openBox('MostplayDB');
    mostDB.add(item);
    getmostltplyed();
    mostplaynotifier.notifyListeners();
  }

  static Future<void> getmostltplyed() async {
    final mostDB = await Hive.openBox("MostplayDB");
    mostDB.values.toList();
    mostlydisplay();
    mostplaynotifier.notifyListeners();
  }

  static Future mostlydisplay() async {
    final mostDB = await Hive.openBox('MostplayDB');
    final mostlyiteam = mostDB.values.toList();
    final mostplsy = mostDB.values.toSet().toList();
    mostplaynotifier.value.clear();

    int value = 0;
    for (var i = 0; i < mostlyiteam.length; i++) {
      for (var j = 0; j < mostplsy.length; j++) {
        if (mostlyiteam[i] == mostplsy[j]) {
          value++;
        }
      }
      if (value > 4) {
        for (var f = 0; f < startsong.length; f++) {
          if (mostlyiteam[i] == startsong[f].id) {
            mostplaynotifier.value.add(startsong[f]);
            mostplsy.add(startsong[f]);
          }
        }
        value = 0;
      }
    }
    return mostplaynotifier;
  }
}
