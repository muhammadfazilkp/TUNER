import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lottie/lottie.dart';
import 'package:project/BottomNavigator/bottom.dart';
import 'package:project/Bulder.Condroller.dart';
import 'Home_page.dart';

class TunurPage extends StatefulWidget {
  const TunurPage({super.key});

  @override
  State<TunurPage> createState() => _TunurPageState();
}

class _TunurPageState extends State<TunurPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    tuner(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 5, 8),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 120,
          ),
          Text(
            'T U N E R',
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 50, fontWeight: FontWeight.w700),
          ),
          Center(
              child: Lottie.asset('assets/animation/14467-music (1).json',height: 350,width: 250)),
          
          const SizedBox(
            height: 120,
          ),
          Text(
            'LIFE IS BEAUTIFUL MELODY,\nONLY THE LYRICS  ARE MESSED UP’',
            style: GoogleFonts.poppins(
                fontSize: 17, fontWeight: FontWeight.w400, color: Colors.white),
          )
        ],
      ),
    );
  }
}
Future<void>tuner(BuildContext context)async{
  await Future.delayed(const Duration(seconds: 3));
  // ignore: use_build_context_synchronously
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>   const BottomNavigationPage()), (route) => false);

}
