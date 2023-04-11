import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/Bulder.Condroller.dart';
import 'package:project/functions/fav_functions.dart';
import 'package:project/playlist/playlistsongdisplay.dart';

List<SongModel> startsong = [];

class ControllerHomepage extends StatefulWidget {
  const ControllerHomepage({super.key});

  @override
  State<ControllerHomepage> createState() => _ControllerHomepageState();
}

class _ControllerHomepageState extends State<ControllerHomepage> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    requestPermission();
  }

  final _auodioQuery = OnAudioQuery();
  //  final AudioPlayer audioPlyer =AudioPlayer();

  requestPermission() async {
    bool status = await audioquery.permissionsStatus();
    if (!status) {
      await audioquery.permissionsRequest();
    }
    setState(() {});
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
        future: _auodioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
          // path: '/storage/emulated/0/TUNER',
        ),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return Text(
              'No Songs ',
              style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
            );
          }
              startsong.clear();
          for (var element in item.data!) {
            if (element.fileExtension.contains("mp3") &&
                !element.data.contains("/WhatsApp Audio")) {
              if (!element.displayName.contains("AUD")) {
                startsong.add(element);
              }
            }
          }
          favoriteDB.isintialazed(startsong);
          return HomeBulder(songmodel:startsong);
        });
  }
}
