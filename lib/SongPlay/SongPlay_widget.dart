import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project/BottomNavigator/bottom.dart';
import 'package:project/SongPlay/Artwork_widgwt.dart';
import 'package:project/SongPlay/GetallSongController.dart';
import 'package:project/SongPlay/PlayController.dart';
import 'package:project/functions/fav_functions.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({
    super.key,
    required this.songmodel,
    this.count = 0,
  });

  final List<SongModel> songmodel;
  final int count;
  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  Duration _duration = const Duration();
  Duration _position = const Duration();

  int currentindex = 0;
  bool firstsong = false;
  bool lastsong = false;
  int large = 0;
  bool isfavor = false;

  @override
  void initState() {
    Getallsongs.audioPlayer.currentIndexStream.listen((ind) {
      if (ind != null) {
        Getallsongs.currentindexgetallsongs = ind;
        if (mounted) {
          setState(() {
            large = widget.count - ind;
            currentindex = ind;
            ind == 0 ? firstsong = true : firstsong = false;
            ind == large ? lastsong = true : lastsong = false;
          });
        }
      }
    });
    // ignore: todo
    // TODO: implement initState
    super.initState();
    playSong();
  }

  playSong() {
    Getallsongs.audioPlayer.play();
    Getallsongs.audioPlayer.durationStream.listen((d) {
      if (mounted) {
        setState(() {
          _duration = d!;
        });
      }
    });
    Getallsongs.audioPlayer.positionStream.listen((p) {
      if (mounted) {
        setState(() {
          _position = p;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const BottomNavigationPage()),
                  (Route route) => false);
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          TextButton.icon(
              onPressed: () {},
              icon: Text(
                'TUNER NOW',
                style: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
              label: const Icon(
                Icons.music_note,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/blur3.jpg'), fit: BoxFit.cover)),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Center(
                child: ArtWorkwidgwt(widget: widget, curentindex: currentindex),
              ),

              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Text(
                  widget.songmodel[currentindex].displayNameWOExt,
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    color: Colors.grey,
                    fontWeight: FontWeight.w800,
                  ),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 150),
                            child: Text(
                              widget.songmodel[currentindex].artist
                                          .toString() ==
                                      "unknown"
                                  ? "Unknown Aartist"
                                  : widget.songmodel[currentindex].artist
                                      .toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.grey.shade700,
                              ),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    favoriteDB.isFavor(widget.songmodel[currentindex])
                                    ?
                                    favoriteDB.delete(widget.songmodel[currentindex].id)
                                    
                                   :favoriteDB
                                        .add(widget.songmodel[currentindex]);
                                  });
                                },
                                icon: favoriteDB
                                        .isFavor(widget.songmodel[currentindex])
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                      )),
                          )),
                    ],
                  ),
                ],
              ),

              // IconButton(onPressed: (){}, icon: const Icon(Icons.favorite,)),

              const SizedBox(
                height: 20,
              ),
              Playcontrollers(
                  count: widget.count,
                  songModel: widget.songmodel[currentindex],
                  firstsong: firstsong,
                  lastsong: lastsong),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: Slider(
                    inactiveColor: const Color.fromARGB(255, 125, 126, 126),
                    activeColor: const Color.fromARGB(255, 68, 56, 56),
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        changetoseconds(value.toInt());
                        value = value;
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40, left: 40, bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _position.toString().split(".")[0],
                      style: const TextStyle(
                          fontSize: 11,
                          color: Color.fromARGB(255, 173, 169, 169)),
                    ),
                    Text(
                      _duration.toString().split(".")[0],
                      style: const TextStyle(
                          fontSize: 11,
                          color: Color.fromARGB(255, 173, 169, 169)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changetoseconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    Getallsongs.audioPlayer.seek(duration);
  }
}
