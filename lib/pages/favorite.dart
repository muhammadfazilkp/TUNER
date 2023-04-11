import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project/Bulder.Condroller.dart';
import 'package:project/functions/fav_functions.dart';

class LikedsongPage extends StatefulWidget {
  const LikedsongPage({super.key});

  @override
  State<LikedsongPage> createState() => _LikedsongPageState();
}

class _LikedsongPageState extends State<LikedsongPage> {
  @override
  Widget build(BuildContext context) {
    double basewidth = 360;
    double fem = MediaQuery.of(context).size.width / basewidth;
    double ffem = fem * 0.97;
    return ValueListenableBuilder(
        valueListenable: favoriteDB.favoriteSongsNotifier,
        builder: (context, List<SongModel> favdata, child) {
          return Scaffold(
            body: SafeArea(
              child: SizedBox(
                width: 800 * fem,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/WhatsApp_Image1.jpg'),
                          fit: BoxFit.cover)),
                  child: Scaffold(
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 15, bottom: 10),
                          child: Text(
                            'Favorite songs',
                            style: GoogleFonts.poppins(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 720,
                          child: ValueListenableBuilder(
                              valueListenable: favoriteDB.favoriteSongsNotifier,
                              builder: (context, List<SongModel> favdata,
                                  Widget? child) {
                                if (favdata.isEmpty) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 300),
                                      child: Text(
                                        'No songs in favorite',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  );
                                } else {
                                  final temp = favdata.reversed.toList();
                                  favdata = temp.toSet().toList();

                                  return HomeBulder(songmodel: favdata);
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
