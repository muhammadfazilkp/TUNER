import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project/SongPlay/GetallSongController.dart';
import 'package:project/SongPlay/SongPlay_widget.dart';
import 'package:project/functions/playlistdatab.dart';

import 'package:project/model.dart/model.dart';
import 'package:project/playlist/playlistsongdisplay.dart';

class playlistAddSong extends StatefulWidget {
  const playlistAddSong(
      {super.key, required this.sindex, required this.playlist});

  final int sindex;
  final Plyermodel playlist;
  @override
  State<playlistAddSong> createState() => _playlistAddSongState();
}

class _playlistAddSongState extends State<playlistAddSong> {
  @override
  Widget build(BuildContext context) {
    late List<SongModel> songplaylist;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        // title: Text(
        //   widget.playlist.name,
        //   style: GoogleFonts.poppins(color: Colors.white),
        // ),
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Text(
            'T U N E R',
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
        )),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<Plyermodel>('playlistDb').listenable(),
                  builder: (context, Box<Plyermodel> song, Widget? child) {
                    songplaylist = listplaylist(
                        song.values.toList()[widget.sindex].songid);
                    return songplaylist.isEmpty
                        ? Container(
                            child: Text(
                              'Add Song',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        : ListView.builder(
                          itemCount: songplaylist.length,
                            itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: QueryArtworkWidget(
                                        id: songplaylist[index].id,
                                        artworkHeight: 60,
                                        artworkWidth: 60,
                                        nullArtworkWidget: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Icon(
                                            Icons.music_note,
                                            color: Color.fromARGB(255, 2, 2, 2),
                                          ),
                                        ),
                                        type: ArtworkType.AUDIO),
                                    title: Text(
                                      songplaylist[index].title,
                                      maxLines: 1,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      songplaylist[index].artist!,
                                      maxLines: 1,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          widget.playlist
                                              .deleted(songplaylist[index].id);
                                          final removesongplay = SnackBar(
                                              backgroundColor: Colors.white,
                                              duration:
                                                  const Duration(seconds: 1),
                                              content: Container(
                                                child: Text(
                                                  'Music remove in playlist',
                                                  style: GoogleFonts.poppins(),
                                                ),
                                              ));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(removesongplay);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        )),
                                    onTap: () {
                                      Getallsongs.audioPlayer.setAudioSource(
                                          Getallsongs.createsongslist(
                                              songplaylist),
                                          initialIndex: index);
                                        

                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NowPlayingScreen(
                                                    songmodel: songplaylist,
                                                    count: songplaylist.length,
                                                  )));
                                    },
                                  ),
                                ));
                  }))
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        playlistsongdisplayScreeen(playlist: widget.playlist)));
          },
          label: const Text('Add songs')),
    );
  }
}

List<SongModel> listplaylist(List<int> data) {
  List<SongModel> playsong = [];
  for (int i = 0; i < Getallsongs.copysong.length; i++) {
    for (int j = 0; j < data.length; j++) {
      if (Getallsongs.copysong[i].id == data[j]) {
        playsong.add(Getallsongs.copysong[i]);
      }
    }
  }
  return playsong;
}
