import 'package:flutter/material.dart';
import 'package:project/Home_page.dart';
import 'package:project/SongPlay/GetallSongController.dart';
import 'package:project/pages/recentlyplyed/recentlylistview.dart';
import 'package:project/pages/search/searchPage.dart';
import 'package:project/pages/settings/settings.dart';
import 'package:project/wiget/miniplyer.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  int correntindex = 0;
  List bottomnav = [const HomePage(), const Searchwidget(),const Recentwidget(),const SettingsScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          bottomnav[correntindex],
          Positioned(
              bottom: 0,
              right: 20,
              child: Column(
                children: [
                  Getallsongs.audioPlayer.currentIndex != null
                      ? const Miniplayers()
                      : Container()
                ],
              ))
        ],
      ),

      //  bottomnav[correntindex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        
        elevation: 30.8,
        mouseCursor: MaterialStateMouseCursor.clickable,
        backgroundColor: Colors.black,
        fixedColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(Icons.home),
              label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'SEARCH'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'HISTORY'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'SETTINGS')
        ],
        currentIndex: correntindex,
        onTap: (int index) {
          setState(() {
            correntindex = index;
          });
        },
      ),
    );
  }
}
