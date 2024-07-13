import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:mymusic/models/playlist_provider.dart';
import "package:mymusic/pages/song_page.dart";
import "package:provider/provider.dart";
import "package:mymusic/models/song.dart";

class LikedPage extends StatelessWidget {
  const LikedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child)
    {
      // get Playlist
      final likedSongs = value.likedSongs;

      // get Current Song Index
      final currentSong = likedSongs[value.currentSongIndex ?? 0];
      return Scaffold(
        appBar: AppBar(title: const Text("Favourite Songs")),
        body: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: likedSongs.length,
                itemBuilder: (context, index) {
                  // get individual Song
                  final Song song = likedSongs[index];

                  return ListTile(
                    title: Text(song.songName),
                    subtitle: Text(song.artistName),
                    leading: Image.asset(song.albumArtImagePath),
                    onTap: ()  {
                      value.play();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SongPage()));
                    },
                  );
                },
              ),
            ),

          ],
        ),
      );
    });


  }
}
