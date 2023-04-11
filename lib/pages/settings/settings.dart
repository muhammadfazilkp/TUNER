import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:project/pages/settings/about.dart';
import 'package:project/pages/settings/privecy_Policy.dart';
import 'package:project/pages/settings/thermsAndCndn.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
        title: Text(
          'SETTINGS',
          style: GoogleFonts.poppins(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 11,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()));
            },
            child: Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 199, 203, 206))),
              child: Center(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.play_lesson,
                        color: Colors.white,
                      ),
                      label: Text(
                        'About',
                        style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 15),
                      )),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyScreen()));
            },
            child: Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.white)),
              child: Center(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.privacy_tip_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      label: Text(
                        'Privecy Policy',
                        style: GoogleFonts.poppins(color: Colors.white),
                      )),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TermsAndConditionScreen()));
            },
            child: Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.white)),
              child: Center(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.confirmation_num,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Therms & Condition ',
                        style: GoogleFonts.poppins(color: Colors.white),
                      )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
