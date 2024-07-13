import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mymusic/components/neu_box.dart';
import 'package:mymusic/pages/song_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:mymusic/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class AudioListPage extends StatefulWidget {
  @override
  _AudioListPageState createState() => _AudioListPageState();
}

class _AudioListPageState extends State<AudioListPage> {
  late final dynamic playlistProvider;
  final AudioPlayer _audioPlayer = AudioPlayer();
  static List<FileSystemEntity> _audioFiles = [];

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
    _requestPermission();
  }

  Future<void> _loadAudioFiles() async {
    try {
      final directory = Directory('/storage/emulated/0/Download/');
      print(directory);
      if (await directory.exists()) {
        print('Directory exists: ${directory.path}');
        final files = directory
            .listSync(
                recursive: true) // Set recursive to true to list all files
            .where((entity) => entity is File && entity.path.endsWith('.mp3'))
            .toList();
        print(files);
        if (files.isEmpty) {
          print('No mp3 files found in ${directory.path}');
        } else {
          print('Found ${files.length} mp3 files in ${directory.path}');
        }
        setState(() {
          _audioFiles = files;
        });
      } else {
        print('Directory does not exist: ${directory.path}');
      }
    } catch (e) {
      print('Error loading files: $e');
    }
  }

  Future<void> _requestPermission() async {
    if (await Permission.storage.request().isGranted) {
      _loadAudioFiles();
    } else {
      // Handle the case where the user denies the permission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Storage permission is required to access audio files.'),
        ),
      );
    }
  }

  Future<void> _playAudio(String path) async {
    await _audioPlayer.setFilePath(path);
    print(path);
    _audioPlayer.play();
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
      appBar: AppBar(
        title: Text('Audio Files'),
      ),
      body: _audioFiles.isEmpty
          ? Center(
              child: InkWell(
                onTap: _loadAudioFiles,
                child: Text('No audio files found'),
              ),
            )
          : ListView.builder(
              itemCount: _audioFiles.length,
              itemBuilder: (context, index) {
                final file = _audioFiles[index];

                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        _playAudio(file.path);
                        goToSong(index);
                        print(index);
                        print("---------------------------------------------------------------------------------------------");
                        print(file);
                        print(_audioFiles);
                      },
                      child: NeuBox(
                        child: Text(file.path.split('/').last),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            ),
    );
  }
}
