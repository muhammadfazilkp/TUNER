import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/pages/mostplyed/moslyplyd_list.dart';

class MostplayScreen extends StatelessWidget {
  const MostplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: Colors.black,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 35),
            child: Text(
              'MostlyPlayed',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
                image: AssetImage('assets/blur3.jpg'), fit: BoxFit.cover)),
        child: Column(
          children: const [
            SizedBox(
              height: 10,
              width: 10,
            ),
            Expanded(child: Mostlyplayedlist())
          ],
        ),
      ),
    );
  }
}
