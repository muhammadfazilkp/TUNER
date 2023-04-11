import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


import 'package:project/model.dart/model.dart';

class PlaylistDB {
  static ValueNotifier<List<Plyermodel>> playlistNotifier = ValueNotifier([]);
  static final PlaylistDb = Hive.box<Plyermodel>('playlistDb');
  static Future<void> addplaylist(Plyermodel value) async {
    final PlaylistDb = Hive.box<Plyermodel>('playlistDb');
    await PlaylistDb.add(value);
    playlistNotifier.value.add(value);
  }

  static Future<void> getAllplaylist() async {
    final PlaylistDb = Hive.box<Plyermodel>('playlistDb');
    playlistNotifier.value.clear();
    playlistNotifier.notifyListeners();
  }

  static Future<void> deleteplaylist(int index) async {
    final PlaylistDb = Hive.box<Plyermodel>('playlistDb');
    await PlaylistDb.deleteAt(index);
    
    getAllplaylist();
  }

  static Future<void> editlist(
    Plyermodel value,
    int index,
  ) async {
    final PlaylistDb = Hive.box<Plyermodel>('playlistDb');
    PlaylistDb.putAt(index, value);
    getAllplaylist();
  }
}
