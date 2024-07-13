import 'package:flutter/material.dart';
import 'package:mymusic/components/AppBar.dart';
import 'package:mymusic/components/Drawer.dart';
import 'package:mymusic/models/playlist_provider.dart';
import 'package:mymusic/models/song.dart';
import 'package:provider/provider.dart';
import 'package:mymusic/pages/song_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get the palylist provider
  late final dynamic playlistProvider;

  @override
  void initState() {

    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    // update current song Index
    playlistProvider.currentSongIndex = songIndex;

    //   navigate to Song Page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          // get the playlist
          final List<Song> playlist = value.playlist;

          // return List View UI
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              // get individual Song
              final Song song = playlist[index];

              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumArtImagePath),
                onTap: ()  {
                  value.play();
                  goToSong(index);
                },
              );
            },
          );
        },
      ),
    );
  }
}
