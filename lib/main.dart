import 'package:flutter/material.dart';
import 'package:mymusic/models/playlist_provider.dart';
import 'package:mymusic/pages/HomePage.dart';
import 'package:mymusic/pages/audio_list_page.dart';
import 'package:mymusic/pages/liked_page.dart';
import 'package:mymusic/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => PlaylistProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
