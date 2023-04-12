
import 'package:flutter/material.dart';
import 'package:project/pages/recentlyplyed/recentplay.dart';

class Recentwidget extends StatefulWidget {
  const Recentwidget({super.key});

  @override
  State<Recentwidget> createState() => _RecentwidgetState();
}

class _RecentwidgetState extends State<Recentwidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/blur3.jpg'))),
        child: SizedBox(
          width: double.infinity,
          height: 790,
          child: DecoratedBox(
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color.fromARGB(255, 141, 128, 128),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Recently played',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.history,
                          color: Color.fromARGB(255, 148, 138, 138),
                        ))
                  ],
                ),
                const Expanded(child: Recentlyplayedlist())
              ],
            ),
          ),
        ),
      )),
    );
  }
}
