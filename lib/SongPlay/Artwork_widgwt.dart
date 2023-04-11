import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';



import 'package:on_audio_query/on_audio_query.dart';

import 'package:project/SongPlay/SongPlay_widget.dart';

class ArtWorkwidgwt extends StatelessWidget {
   ArtWorkwidgwt({super.key ,required this.widget, required this.curentindex});

  final NowPlayingScreen widget;
  int curentindex;

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(id: widget.songmodel[curentindex].id, type: ArtworkType.AUDIO,
  keepOldArtwork: true,
    artworkWidth: 200,
    artworkBorder: BorderRadius.circular(30),
    artworkHeight: 200,
    artworkFit: BoxFit.cover,
    nullArtworkWidget:   CircleAvatar(
      backgroundColor:Color.fromARGB(115, 73, 68, 68),
      radius: 70,
      child: Align(
        alignment: Alignment.center,
        child: Lottie.asset('assets/animation/52679-music-loader.json')),
    ),
    );
  }
}