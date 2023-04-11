import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project/SongPlay/GetallSongController.dart';
import 'package:project/SongPlay/SongPlay_widget.dart';
import 'package:project/functions/db_most.dart';

class Mostlyplayedlist extends StatefulWidget {
  const Mostlyplayedlist({super.key});

  @override
  State<Mostlyplayedlist> createState() => _MostlyplayedlistState();
}

class _MostlyplayedlistState extends State<Mostlyplayedlist> {
  OnAudioQuery audioQuery = OnAudioQuery();
  List<SongModel> mostly = [];

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    await MostDB.getmostltplyed();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MostDB.getmostltplyed(),
      builder: (context, item) {
        return ValueListenableBuilder(
          valueListenable: MostDB.mostplaynotifier,
          builder: (context, value, child) {
            if (value.isEmpty) {
              return const Center(
                child: Text(
                  'Your Mostly Played Is Empty',
                  style: TextStyle(fontSize: 20, color: Colors.white60),
                ),
              );
            } else {
              final temp = value.reversed.toList();
              mostly = temp.toSet().toList();
              return FutureBuilder(
                future: audioQuery.querySongs(
                    sortType: null,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: true),
                builder: (context, item) {
                  if (item.data == null) {
                    const Center(child: CircularProgressIndicator());
                  } else if (item.data!.isEmpty) {
                    const Center(
                      child: Text(
                        'No Songs In Your Internal',
                        style: TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: mostly.length > 10 ? 10 : mostly.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.grey,
                        child: ListTile(
                          leading: QueryArtworkWidget(
                            id: mostly[index].id,
                            type: ArtworkType.AUDIO,
                            artworkHeight: 60,
                            artworkWidth: 60,
                            nullArtworkWidget: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.music_note,
                                color: Colors.white60,
                              ),
                            ),
                            artworkBorder: BorderRadius.circular(10),
                            artworkFit: BoxFit.cover,
                          ),
                          title: Text(mostly[index].displayNameWOExt,
                              maxLines: 1,
                              style: const TextStyle(color: Colors.white70)),
                          subtitle: Text(
                            '${mostly[index].artist}',
                            style: const TextStyle(color: Colors.white70),
                            maxLines: 1,
                          ),
                          onTap: () {
                            Getallsongs.audioPlayer.setAudioSource(
                                Getallsongs.createsongslist(mostly));
                            Getallsongs.audioPlayer.play();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NowPlayingScreen(
                                      songmodel: Getallsongs.playsong),
                                ));
                          },
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
