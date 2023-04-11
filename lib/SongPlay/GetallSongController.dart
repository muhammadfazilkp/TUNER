

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Getallsongs {
  static AudioPlayer audioPlayer=AudioPlayer();
  static List<SongModel> copysong = [];
  static List<SongModel> playsong = [];
  static int currentindexgetallsongs = -1;
  static ConcatenatingAudioSource createsongslist(List<SongModel> element) {
    List<AudioSource> songlist = [];
    playsong = element;
    for (var elements in element) {
      songlist.add(AudioSource.uri(Uri.parse(elements.uri!),
          tag: MediaItem(
              id: elements.id.toString(),
              title: elements.title,
              album: elements.album ?? 'No album',
              artist: elements.artist,
              artUri: Uri.parse(elements.id.toString()))));
              
    }
    return ConcatenatingAudioSource(children: songlist);
  }
}