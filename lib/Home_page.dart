import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:project/BottomNavigator/bottom.dart';

import 'package:project/Condroller_homepage.dart';
import 'package:project/pages/favorite.dart';
import 'package:project/pages/mostplyed/most_dispPlay.dart';
import 'package:project/pages/recentlyplyed/recentlylistview.dart';
import 'package:project/pages/search/searchPage.dart';
import 'package:project/playlist/playlist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int b = 0;
  List<Widget> WidgetA = [const ControllerHomepage()];
  final _auodioQuery = new OnAudioQuery();
  void inistate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  height: 90,
                ),
                Container(
                  height: 40,
                  width: 100,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/logo.png'))),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Searchwidget()));
                            },
                            child: Row(
                              children: [
                                Center(
                                  child: Text(
                                    'T U N E R',
                                    style: GoogleFonts.poppins(
                                        color: Colors.pink,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(left: 166),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(3, 10, 290, 10),
              child: Text(
                'Library',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const MostplayScreen()));
                        },
                        child: Container(
                          width: 100,
                          height: 70,
                          child: const Icon(Icons.queue_music_outlined),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.pink),
                        ),
                      ),
                      Text(
                        'Mostlyplyed',
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const PLaylistwidget()));
                        },
                        child: Container(
                          width: 100,
                          height: 70,
                          child: const Icon(
                            Icons.playlist_add_circle,
                            color: Colors.white,
                            size: 33,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 51, 76, 81)),
                        ),
                      ),
                      Text(
                        'Playlist',
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Recentwidget()));
                        },
                        child: Container(
                          width: 100,
                          height: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 17, 74, 67)
                              //  image: DecorationImage(image: AssetImage('assets/WhatsApp_Image1.jpg'),fit: BoxFit.cover)
                              ),
                          child: const Icon(
                            Icons.restore_outlined,
                            color: Colors.white,
                            size: 33,
                          ),
                        ),
                      ),
                      Text(
                        'Recent',
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LikedsongPage()));
                        },
                        child: Container(
                          width: 100,
                          height: 70,
                          child: const Icon(
                            Icons.favorite,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 141, 207, 207)
                              //  image: const DecorationImage(image: AssetImage('assets/WhatsApp_Image1.jpg'),fit: BoxFit.cover)
                              ),
                        ),
                      ),
                      Text(
                        'Favorite',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 280, 0),
              child: Text(
                'Allsongs',
                style: GoogleFonts.poppins(fontSize: 25, color: Colors.white),
              ),
            ),
            Expanded(child: WidgetA[b]),
          ],
        ),
      ),
    );
  }
}
