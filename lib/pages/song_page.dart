import 'dart:io';

import "package:flutter/material.dart";
import 'package:mymusic/components/neu_box.dart';
import 'package:mymusic/models/playlist_provider.dart';
import 'package:mymusic/models/song.dart';
import 'package:mymusic/pages/liked_page.dart';
import 'package:provider/provider.dart';
import 'audio_list_page.dart';

class SongPage extends StatefulWidget {

  const SongPage({super.key} );

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  List<Song> favoritesList = [];
  // List<File> audioFiles = [];
  static bool _isFavorited = false;

  void _toggleFavorited() {
    setState(() {
      _isFavorited = !_isFavorited;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      // get Playlist
      final playlist = value.playlist;

      // get Current Song Index
      final currentSong = playlist[value.currentSongIndex ?? 0];

      // return Scaffold UI
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //   app bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //   back button
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                    //   title
                    const Text(
                      "P L A Y L I S T",
                      style: TextStyle(fontSize: 21),
                    ),

                    //   menu button
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LikedPage()) );
                        },
                        icon: const Icon(
                          Icons.menu,
                          size: 30,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                //   album artwork
                NeuBox(
                  child: Column(
                    children: [
                      // image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(currentSong.albumArtImagePath),
                      ),
                      //   Song and Artist Name
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.songName,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  currentSong.artistName,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                _toggleFavorited();
                                if (_isFavorited) {
                                  print(currentSong.artistName);
                                  value.likedSong();
                                  print(favoritesList);
                                }
                              },
                              child: Icon(
                                Icons.favorite,
                                color: _isFavorited ? Colors.red : Colors.grey,
                                size: 50,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                //   song Duration progress
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Start Time
                          Text(value.currentDuration.inSeconds.toString()),
                          // Shuffle Icon
                          const Icon(Icons.shuffle),
                          // repeat Icon
                          const Icon(Icons.repeat),
                          // end time
                          Text(value.totalDuration.inSeconds.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 3,
                    ),
                  ),
                  child: Slider(
                    thumbColor: Colors.white,
                    inactiveColor: Colors.grey,
                    min: 0,
                    max: value.totalDuration.inSeconds.toDouble(),
                    value: value.currentDuration.inSeconds.toDouble(),
                    activeColor: Colors.brown,
                    onChanged: (double double) {},
                    onChangeEnd: (double double) {
                      value.seek(Duration(seconds: double.toInt()));
                    },
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),
                //   playback controls

                Row(
                  children: [
                    // Skip Previous
                    Expanded(
                      child: GestureDetector(
                        onTap: value.playPreviousSong,
                        child: const NeuBox(
                          child: Icon(Icons.skip_previous),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),

                    //   Play-Pause
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: value.pauseOrResume,
                        child: NeuBox(
                          child: Icon(
                            value.isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    //   Skip Forward
                    Expanded(
                      child: GestureDetector(
                        onTap: value.playNextSong,
                        child: const NeuBox(
                          child: Icon(Icons.skip_next),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
