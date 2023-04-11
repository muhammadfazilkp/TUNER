import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project/SongPlay/GetallSongController.dart';

class Playcontrollers extends StatefulWidget {
  const Playcontrollers(
      {super.key,
      required this.count,
      required this.songModel,
      required this.firstsong,
      required this.lastsong});
  final int count;
  final SongModel songModel;
  final bool firstsong;
  final bool lastsong;

  @override
  State<Playcontrollers> createState() => _PlaycontrollersState();
}

class _PlaycontrollersState extends State<Playcontrollers> {
  bool isplaying = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(65, 10, 65, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          widget.firstsong
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      Getallsongs.currentindexgetallsongs--;
                      if (Getallsongs.currentindexgetallsongs < 0) {
                        Getallsongs.currentindexgetallsongs =
                            widget.songModel.size;
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.skip_previous,
                    size: 40,
                    color: Color.fromARGB(255, 127, 142, 126),
                  ))
              : IconButton(
                  onPressed: () {
                    if (Getallsongs.audioPlayer.hasPrevious) {
                      Getallsongs.audioPlayer.seekToPrevious();
                    }
                  },
                  icon: const Icon(
                    Icons.skip_previous,
                    size: 40,
                    color: Colors.white,
                  )),
          Center(
            child: CircleAvatar(
              radius: 30,
              backgroundColor: const  Color.fromARGB(255, 157, 12, 99),
              child: Padding(
                padding: const EdgeInsets.only(right: 7, bottom: 4),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        isplaying = !isplaying;
                      });
                      if (Getallsongs.audioPlayer.playing) {
                        Getallsongs.audioPlayer.pause();
                      } else {
                        Getallsongs.audioPlayer.play();
                      }
                    },
                    icon: Icon(
                      isplaying ? Icons.pause : Icons.play_arrow,
                      size: 40,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
          widget.lastsong
              ? const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.skip_next,
                    size: 40,
                    color: Colors.white,
                  ))
              : IconButton(
                  onPressed: () {
                    if (Getallsongs.audioPlayer.hasNext) {
                      Getallsongs.audioPlayer.seekToNext();
                    }
                  },
                  icon: const Icon(Icons.skip_next,
                      size: 40, color: Colors.white)),
        ],
      ),
    );
  }
}
