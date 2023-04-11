import 'package:flutter/material.dart';
import 'package:project/SongPlay/GetallSongController.dart';
import 'package:project/SongPlay/SongPlay_widget.dart';

class Miniplayers extends StatefulWidget {
  const Miniplayers({super.key});

  @override
  State<Miniplayers> createState() => _MiniplayersState();
}

bool firstsong = false;
bool isplaying = true;
bool isPlaying = false;

class _MiniplayersState extends State<Miniplayers> {
  @override
  void initState() {
    Getallsongs.audioPlayer.currentIndexStream.listen((index) {
      if (index == null && mounted) {
        setState(() {
          index == 0 ? firstsong = true : firstsong = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return NowPlayingScreen(
              songmodel: Getallsongs.playsong,
            );
          },
        ));
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 59,
          width: 350,
          decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    child: StreamBuilder<bool>(
                        stream: Getallsongs.audioPlayer.playingStream,
                        builder: (context, snapshot) {
                          bool? playingstage = snapshot.data;
                          if (playingstage != null && playingstage) {
                            return Text(
                              Getallsongs
                                  .playsong[
                                      Getallsongs.audioPlayer.currentIndex!]
                                  .displayNameWOExt,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white60),
                            );
                          } else {
                            return Text(
                              Getallsongs
                                  .playsong[
                                      Getallsongs.audioPlayer.currentIndex!]
                                  .displayNameWOExt,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white60),
                            );
                          }
                        }),
                  ),
                  firstsong
                      ? IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_previous,
                            color: Colors.white54,
                          ))
                      : IconButton(
                          onPressed: () {
                            if (Getallsongs.audioPlayer.hasPrevious) {
                              setState(() {
                                Getallsongs.audioPlayer.seekToPrevious();
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.skip_previous,
                            color: Colors.white54,
                          )),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: const CircleBorder()),
                    onPressed: () async {
                      setState(() {});
                      if (Getallsongs.audioPlayer.playing) {
                        await Getallsongs.audioPlayer.pause();
                        setState(() {});
                      } else {
                        await Getallsongs.audioPlayer.play();
                        setState(() {});
                      }
                    },
                    child: StreamBuilder<bool>(
                      stream: Getallsongs.audioPlayer.playingStream,
                      builder: (context, snapshot) {
                        bool? playingStage = snapshot.data;
                        if (playingStage != null && playingStage) {
                          return const Icon(
                            Icons.pause_circle,
                            color: Color.fromARGB(255, 219, 219, 219),
                            size: 35,
                          );
                        } else {
                          return const Icon(
                            Icons.play_circle,
                            color: Color.fromARGB(255, 219, 219, 219),
                            size: 35,
                          );
                        }
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (Getallsongs.audioPlayer.hasNext) {
                          setState(() {
                            Getallsongs.audioPlayer.seekToNext();
                          });
                        }
                      },
                      icon: const Icon(Icons.skip_next, color: Colors.white54))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
