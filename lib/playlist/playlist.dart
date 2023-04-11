import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:project/functions/playlistdatab.dart';
import 'package:project/model.dart/model.dart';
import 'package:project/playlist/playlistiduvigual.dart';

class PLaylistwidget extends StatefulWidget {
  const PLaylistwidget({super.key});

  @override
  State<PLaylistwidget> createState() => _PLaylistwidgetState();
}

final GlobalKey<FormState> formkey = GlobalKey<FormState>();
final playlistnamecontroller = TextEditingController();

class _PLaylistwidgetState extends State<PLaylistwidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color.fromARGB(255, 53, 10, 34),
        body: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color.fromARGB(255, 225, 218, 218),
                        size: 22,
                      )),
                  IconButton(
                      onPressed: () {
                        newplaylist(context, formKey);
                      },
                      icon: const Icon(
                        Icons.playlist_add,
                        color: Color.fromARGB(255, 217, 224, 225),
                        size: 32,
                      )),
                ]),
            Text(
              'PlayLists',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 28),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: SizedBox(
                    width: double.infinity,
                    child: ValueListenableBuilder(
                      valueListenable:
                          Hive.box<Plyermodel>('playlistDb').listenable(),
                      builder:
                          (BuildContext context, musiclist, Widget? child) {
                        return Hive.box<Plyermodel>('playlistDb').isEmpty
                            ? Center(
                                child: SizedBox(
                                  width: 200,
                                  child: InkWell(
                                    onTap: () {
                                      newplaylist(context, formKey);
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        // Container(
                                        //   height: 200,
                                        //   width: 200,
                                        //   child: Lottie.asset(

                                        //       // 'assets/page-1/Animation/69823-add-flotting-action-button.json',repeat: true,height: 300,fit: BoxFit.cover),
                                        // ),
                                        Text(
                                          'Click to add new Playlist',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              fontFamily: 'poppins'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 2 / 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemBuilder: (context, index) {
                                  final data = musiclist.values.toList()[index];
                                  return Card(
                                    color: const Color.fromARGB(255, 18, 2, 61),
                                    shadowColor: Colors.pink,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 210, 47, 161))),
                                    child: Stack(
                                      children: [
                                        const Center(
                                          child: Icon(
                                            Icons.music_note,
                                            size: 40,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        // ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        playlistAddSong(
                                                            sindex: index,
                                                            playlist: data)));
                                          },
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 146),
                                          child: PopupMenuButton(
                                            color: const Color.fromARGB(
                                                255, 163, 227, 223),
                                            icon: const Icon(
                                              Icons.more_vert,
                                              size: 20,
                                            ),
                                            itemBuilder: (context) => [
                                              const PopupMenuItem(
                                                value: 1,
                                                child: Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'poppins'),
                                                ),
                                              ),
                                              const PopupMenuItem(
                                                value: 2,
                                                child: Text(
                                                  'delete',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'poppins'),
                                                ),
                                              )
                                            ],
                                            onSelected: (value) {
                                              if (value == 1) {
                                                editPlaylistName(
                                                    context, data, index);
                                              } else if (value == 2) {
                                                deletePlaylist(
                                                    context, musiclist, index);
                                              }
                                            },
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 25),
                                              child: Text(
                                                data.name,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 124, 143, 145),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16),
                                              ),
                                            ))
                                      ],
                                    ),
                                  );
                                },
                                itemCount: musiclist.length,
                              );
                      },
                    )))
          ],
        ),
      ),
    );
  }
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();

Future<dynamic> editPlaylistName(
    BuildContext context, Plyermodel data, int index) {
  nameController = TextEditingController(text: data.name);
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: const Color.fromARGB(255, 195, 79, 187),
      children: [
        SimpleDialogOption(
          child: Text(
            "Edit Playlist '${data.name}'",
            style: const TextStyle(
                fontFamily: 'poppins',
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
                fontWeight: FontWeight.w600),
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
                      color: Colors.white, fontFamily: 'poppins'),
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.only(left: 15, top: 5)),
              style: const TextStyle(
                  fontFamily: 'poppins',
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
                Navigator.of(context).pop();
                nameController.clear();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Color.fromARGB(255, 247, 246, 248),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final name = nameController.text.trim();
                  if (name.isEmpty) {
                    return;
                  } else {
                    final playlistname = Plyermodel(name: name, songid: []);
                    PlaylistDB.editlist(playlistname, index);
                  }
                  nameController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Update',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Color.fromARGB(255, 248, 246, 248),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

//to create playlist//
Future newplaylist(BuildContext context, formKey) {
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: const Color.fromARGB(255, 193, 30, 234),
      children: [
        const SimpleDialogOption(
          child: Text(
            'New to Playlist',
            style: TextStyle(
                fontFamily: 'poppins',
                color: Color.fromARGB(255, 24, 22, 22),
                fontSize: 18,
                fontWeight: FontWeight.w600),
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
                      color: Color.fromARGB(255, 54, 52, 52), fontFamily: 'poppins'),
                  fillColor: Color.fromARGB(255, 97, 94, 94).withOpacity(0.7),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.only(left: 15, top: 5)),
              style: const TextStyle(
                  fontFamily: 'poppins',
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
                Navigator.of(context).pop();
                nameController.clear();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Color.fromARGB(255, 220, 212, 212),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  saveButtonPressed(context);
                  Navigator.pop(context);

                }

        
                
                // PlaylistDB.addplaylist(Plyermod) 
              },
              child:  Text(
                'Create',
                style: GoogleFonts.poppins(color: Colors.black)
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

//save button and add to database//

Future<void> saveButtonPressed(ctx) async {
  final name = nameController.text.trim();
  final music = Plyermodel(name: name, songid: []);
  final datas = PlaylistDB.PlaylistDb.values.map((e) => e.name.trim()).toList();
  if (name.isEmpty) {
    return;
  } else if (datas.contains(music.name)) {
    const snackbar3 = SnackBar(
        duration: Duration(milliseconds: 750),
        backgroundColor: Colors.black,
        content: Text(
          'playlist already exist',
          style: TextStyle(color: Colors.redAccent),
        ));
    ScaffoldMessenger.of(ctx).showSnackBar(snackbar3);
    Navigator.of(ctx).pop();
  } else {
    PlaylistDB.addplaylist(music);
    const snackbar4 = SnackBar(
        duration: Duration(milliseconds: 750),
        backgroundColor: Colors.black,
        content: Text(
          'playlist created successfully',
          style: TextStyle(color: Colors.white),
        ));
    ScaffoldMessenger.of(ctx).showSnackBar(snackbar4);
    Navigator.pop(ctx);
    nameController.clear();
  }
}

//delete playlist//

Future<dynamic> deletePlaylist(
    BuildContext context, Box<Plyermodel> musicList, int index) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 52, 6, 105),
        title: const Text(
          'Delete Playlist',
          style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
        ),
        content: const Text('Are you sure you want to delete this playlist?',
            style: TextStyle(color: Colors.white, fontFamily: 'poppins')),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No',
                style: TextStyle(
                    color: Colors.purpleAccent, fontFamily: 'poppins')),
          ),
          TextButton(
            onPressed: () {
              musicList.deleteAt(index);
              Navigator.pop(context);
              const snackBar = SnackBar(
                backgroundColor: Colors.black,
                content: Text(
                  'Playlist is deleted',
                  style: TextStyle(color: Colors.white),
                ),
                duration: Duration(milliseconds: 350),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Text('Yes',
                style: TextStyle(
                    color: Colors.purpleAccent, fontFamily: 'poppins')),
          ),
        ],
      );
    },
  );
}
