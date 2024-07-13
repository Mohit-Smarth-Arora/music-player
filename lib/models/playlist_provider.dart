import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'song.dart';
import 'package:mymusic/pages/song_page.dart';

class PlaylistProvider extends ChangeNotifier with WidgetsBindingObserver {
  final List _likedSongs = [];
  final List<Song> _playlist = [
    // song 1
    Song(
      songName: "Creeping Death",
      albumArtImagePath: "assets/images/Creeping_Death.jpg",
      artistName: "Metallica",
      audioPath: "audio/Creeping_Death_(Remastered).mp3",
    ),
    //   song 2
    Song(
      songName: "Good Cop Bad Cop",
      artistName: "Ice Cube",
      albumArtImagePath: "assets/images/everyThangs_Corrupt.jpg",
      audioPath: "audio/Ice Cube - Good Cop Bad Cop.mp3",
    ),

    //   song 3
    Song(
      songName: "Never Love Again",
      artistName: "Eminem",
      albumArtImagePath: "assets/images/musicToBeMurderedBy.jpg",
      audioPath: "audio/Never_Love_Again.mp3",
    ),
  ];

//   current song playing index
  int? _currentSongIndex;

  //  liked a song boolean

  /*
  A U D I O  P L A Y E R
   */

//   isLiked method

//   audio player

  final AudioPlayer _audioPlayer = AudioPlayer();

//   durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

//   constructor
  PlaylistProvider() {
    listenToDuration();
    WidgetsBinding.instance.addObserver(this);
  }

//   initially not playing
  bool _isPlaying = false;

  void toggleIsPlaying() {
    _isPlaying = !_isPlaying;
  }

  void likedSong() async {

    _likedSongs.add(
      Song(
        songName: _playlist[currentSongIndex!].songName,
        artistName: _playlist[_currentSongIndex!].artistName,
        albumArtImagePath: _playlist[_currentSongIndex!].albumArtImagePath,
        audioPath: _playlist[_currentSongIndex!].audioPath,
      ),
    );
    print(playlist[1]);
  }

//   play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

//   pause current song
  void pause() async {
    await _audioPlayer.pause();
    notifyListeners();
  }

//   resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

//   pause or resume

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

//   seek to a specefic position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
    notifyListeners();
  }

//   play next song
  void playNextSong() async {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < playlist.length - 1) {
        // go to the next song if it's not the last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        //   if it's the last song, loop back to the first song
        currentSongIndex = 0;
      }
    }
  }

//   play previous song
  void playPreviousSong() async {
    // if more than 2 seconds have passed, restart the current song
    if (_currentDuration.inSeconds > 2) {
      currentSongIndex = _currentSongIndex;
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        //   if its the first song
        currentSongIndex = _playlist.length - 1;
      }
    }
    //   if it's within first two seconds, go to the previous song
  }

//   listen to duration
  void listenToDuration() {
    //   listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //   listen for current duration
    _audioPlayer.onPositionChanged.listen((newDuration) {
      _currentDuration = newDuration;
      notifyListeners();
    });

    //   listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

//   dispose audio player
  @override
  void dispose() {
    _audioPlayer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      if (_isPlaying) {
        resume();
      } else {
        pause();
      }
    } else if (state == AppLifecycleState.paused) {
      if (_isPlaying) {
        resume();
      }
    } else if (state == AppLifecycleState.resumed) {
      resume();
    }
  }

/*
Getters
 */
  List<Song> get playlist => _playlist;

  List get likedSongs => _likedSongs;

  int? get currentSongIndex => _currentSongIndex;

  bool get isPlaying => _isPlaying;

  Duration get currentDuration => _currentDuration;

  Duration get totalDuration => _totalDuration;

//   S E T T E R S
  set currentSongIndex(int? newIndex) {
    // update current song index
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play();
    }
    // update UI
    notifyListeners();
  }
}
