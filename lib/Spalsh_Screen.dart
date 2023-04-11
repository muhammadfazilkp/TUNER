import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Tuner_Page.dart';

class SpalashScreen extends StatelessWidget {
  const SpalashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    splash(context);
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/mus8.jpg'), fit: BoxFit.cover),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 0, 0, 80),
                child: Text('MOVE ON YOUR TUNE ',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          )
        ],
      ),
    ));
  }

  Future<void> splash(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const TunurPage()));
  }
}
