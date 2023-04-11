import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project/Condroller_homepage.dart';

import 'package:project/SongPlay/GetallSongController.dart';
import 'package:project/SongPlay/SongPlay_widget.dart';
import 'package:project/functions/db_most.dart';
import 'package:project/functions/fav_functions.dart';
import 'package:project/functions/recentlyplyed.dart';

import 'package:project/model.dart/model.dart';
import 'package:project/playlist/playlist.dart';

class HomeBulder extends StatefulWidget {
  HomeBulder({super.key, required this.songmodel});
  List<SongModel> songmodel = [];

  @override
  State<HomeBulder> createState() => _HomeBulderState();
}

class _HomeBulderState extends State<HomeBulder> {
  List<SongModel> songs = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/mus18.jpg'), fit: BoxFit.cover),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        // color: Color.fromARGB(255, 43, 37, 43),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          songs.addAll(widget.songmodel);
          return SizedBox(
            height: 65,
            child: Card(
              color: const Color.fromARGB(255, 53, 48, 48),
              child: ListTile(
                leading: QueryArtworkWidget(
                  id: widget.songmodel[index].id,
                  type: ArtworkType.AUDIO,
                  artworkHeight: 60,
                  artworkWidth: 60,
                  nullArtworkWidget: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CircleAvatar(
                      radius: 20,
                      child: Lottie.asset('assets/animation/52679-music-loader.json')
                    ),
                  ),
                  artworkBorder: BorderRadius.circular(10),
                  artworkFit: BoxFit.cover,
                ),
                title: Text(
                  widget.songmodel[index].displayNameWOExt,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  '${widget.songmodel[index].artist}',
                  style: const TextStyle(color: Colors.white),
                  maxLines: 1,
                ),
                trailing: PopupMenuButton(
                  color: const Color.fromARGB(255, 178, 200, 211),
                  icon: const Icon(
                    Icons.more_vert,
                    size: 18,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Container(
                        child: Text(
                          'Add Playlist',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                      // onTap: () {
                      //  showPlaylistdialog(context,  startsong[index]);
                      // },
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text(
                        favoriteDB.isFavor(widget.songmodel[index])
                            ? 'Remove Favorites'
                            : 'Add Favorites',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 1) {
                      showPlaylistdialog(context, startsong[index]);
                    } else if (value == 2) {
                      if (favoriteDB.isFavor(widget.songmodel[index])) {
                        favoriteDB.delete(widget.songmodel[index].id);
                        const remove = SnackBar(
                          content: Center(
                            child: Text(
                              'Song removed in favorite List',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                          ),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(remove);
                      } else {
                        favoriteDB.add(widget.songmodel[index]);
                        const add = SnackBar(
                          content: Center(
                            child: Text(
                              'Song add in Favorite List',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(add);
                      }
                      favoriteDB.favoriteSongsNotifier.notifyListeners();
                    }
                  },
                ),
                onTap: () {
                  MostDB.addmostplayed(widget.songmodel[index].id);
                  GetRecentlyPlayed.addRecentlyPlayed(
                      widget.songmodel[index].id);

                  Getallsongs.audioPlayer.setAudioSource(
                      Getallsongs.createsongslist(widget.songmodel),
                      initialIndex: index);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NowPlayingScreen(songmodel: widget.songmodel)));
                },
              ),
            ),
          );
        },
        itemCount: widget.songmodel.length,
      ),
    );
  }
}

showPlaylistdialog(BuildContext ctx, SongModel songmodel) {
  showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Choose your playlist',
            style: GoogleFonts.poppins(color: Colors.black),
          ),
          content: SizedBox(
            height: 200,
            width: double.maxFinite,
            child: ValueListenableBuilder(
                valueListenable:
                    Hive.box<Plyermodel>('PlaylistDB').listenable(),
                builder: (BuildContext context, Box<Plyermodel> musiclist,
                    Widget? child) {
                  return Hive.box<Plyermodel>('playlistDb').isEmpty
                      ? Center(
                          child: Stack(
                            children: [
                              Positioned(
                                right: 30,
                                left: 30,
                                bottom: 50,
                                child: Center(
                                  child: Text(
                                    'NO PLAYLIST FOUND!!',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: musiclist.length,
                          itemBuilder: (context, index) {
                            final data1 = musiclist.values.toList()[index];
                            return Card(
                              color: Colors.white,
                              shadowColor: Colors.purpleAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: Colors.white)),
                              child: ListTile(
                                title: Text(
                                  data1.name,
                                  style:
                                      GoogleFonts.poppins(color: Colors.black),
                                ),
                                trailing: const Icon(
                                  Icons.playlist_add,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  songaddtoplaylist(
                                      songmodel, data1, data1.name, context);
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          });
                }),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  newplaylist(context, formKey);
                },
                child: Text(
                  'New play list',
                  style: GoogleFonts.poppins(),
                )),
            TextButton(
              onPressed: () {},
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        );
      });
}

void songaddtoplaylist(
    SongModel data, datas, String name, BuildContext context) {
  if (!datas.isvaluele(data.id)) {
    datas.add(data.id);
    final snake1 = SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: const Color.fromARGB(222, 38, 46, 67),
        content: Center(
            child: Text(
          'Playlist Add To $name',
          style: const TextStyle(color: Colors.black),
        )));
    ScaffoldMessenger.of(context).showSnackBar(snake1);
  } else {
    final snake2 = SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        content: Center(
          child: Text(
            'Song Allready Added in  $name',
            style: GoogleFonts.poppins(),
          ),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snake2);
  }
}

Future newplaylist(BuildContext context, formkey) {
  return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            children: [
              SimpleDialogOption(
                child: Text(
                  'New to Playlist',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SimpleDialogOption(
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: nameController,
                    maxLength: 15,
                    decoration: InputDecoration(
                        counterStyle: const TextStyle(
                            color: Colors.black, fontFamily: 'poppins'),
                        fillColor: Colors.white.withOpacity(0.7),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding:
                            const EdgeInsets.only(left: 15, top: 5)),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your playlist name";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                      nameController.clear();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        saveButtonPressed(context);
                      }
                    },
                    child: const Text(
                      'Create',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ));
}
