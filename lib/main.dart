

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project/Spalsh_Screen.dart';
import 'package:project/model.dart/model.dart';
import 'package:project/provider/provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   runApp(ChangeNotifierProvider(create: (context)=>Songmodelprovider(),child: const  Myapp(),));
  if (!Hive.isAdapterRegistered(PlyermodelAdapter().typeId)) {
    Hive.registerAdapter(PlyermodelAdapter());}
  await Hive.initFlutter();
   await Hive.openBox('recentSongNotifier');
   await Hive.openBox('MostplayDB');
  await Hive.openBox<int>('FavoriteDB');
  await Hive.openBox<Plyermodel>('playlistDb');
  await Hive.openBox<String>('namedata');
 
 
//  await Hive.box<Plyermodel>('playlistDb');
  
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' TUNER',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey,
        scaffoldBackgroundColor: Colors.black, 
       
      ),
      home: const SpalashScreen(),
    );
  }
}
