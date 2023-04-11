import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

class favoriteDB {
  static bool isInitilazed = false;
  static final musicDb = Hive.box<int>('FavoriteDB');
  static ValueNotifier<List<SongModel>> favoriteSongsNotifier = ValueNotifier([]);

  static isintialazed(List<SongModel> songs) {
    favoriteSongsNotifier.value.clear();
    for (SongModel song in songs) {
      if (isFavor(song)) {
        favoriteSongsNotifier.value.add(song);
      }
    }
    isInitilazed = true;
  }

  static isFavor(SongModel song) {
    if (musicDb.values.contains(song.id)) {
      return true;
    }
    return false;
  }

  static add(SongModel song) async {
 
    musicDb.add(song.id);
    
    favoriteSongsNotifier.value.add(song);
    
    favoriteDB.favoriteSongsNotifier.notifyListeners();
  }

  static  void delete(int id) async {
    int DLT = 0;
    if (!musicDb.values.contains(id)) {
      musicDb.deleteAt(id);
    }

    final Map<dynamic,int> map= musicDb.toMap();
    map.forEach((key, value) {
      if(value==id){
        DLT=key;
      }
    });
    musicDb.delete(DLT);
    favoriteSongsNotifier.value.removeWhere((song) => song.id==id);
    
  }

  
  
     
   
  
  
  
  
  
  
}
