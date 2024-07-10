import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final OnAudioQuery audioQuery = OnAudioQuery(); 
  final AudioPlayer audioPlayer = AudioPlayer(); 

  var playIndex = (-1).obs;                          
  var isPlaying = false.obs;                      
  var songList = <SongModel>[].obs;               
  var filteredSongs = <SongModel>[].obs;  // Updated for search results
  var currentPosition = Duration.zero.obs;        
  var songDuration = Duration.zero.obs;           
  var searchQuery = ''.obs;  // Observable to hold search query

  @override
  void onInit() {
    super.onInit();
    checkPermission();

    // Listen to the player's position stream to update currentPosition
    audioPlayer.positionStream.listen((position) {
      currentPosition.value = position;
    });

    // Listen to the player's duration stream to update songDuration
    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        songDuration.value = duration;
      }
    });
  }

  // Function to play a song based on its URI and index
  void playSong(String? uri, int index) {
    playIndex.value = index;
    if (uri != null) {
      try {
        audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri)));
        audioPlayer.play();
        isPlaying(true);
      } catch (e) {
        print("Error playing song: $e");
      }
    } else {
      print("URI is null");
    }
  }

  // Function to pause the currently playing song
  void pauseSong() {
    audioPlayer.pause();
    isPlaying(false);
  }

  // Function to resume the currently paused song
  void resumeSong() {
    audioPlayer.play();
    isPlaying(true);
  }

  // Function to skip to the next song in the list
  void skipSong() {
    if (playIndex.value < songList.length - 1) {
      playIndex.value += 1;
      playSong(songList[playIndex.value].uri, playIndex.value);
    }
  }

  // Function to go back to the previous song in the list
  void previousSong() {
    if (playIndex.value > 0) {
      playIndex.value -= 1;
      playSong(songList[playIndex.value].uri, playIndex.value);
    }
  }

  // Function to check and request storage permission
  void checkPermission() async {
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
      fetchSongs();
    } else {
      checkPermission();
    }
  }

  // Function to fetch songs from the device
  Future<List<SongModel>> fetchSongs() async {
    try {
      var songs = await audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        uriType: UriType.EXTERNAL,
      );
      songList.addAll(songs);
      filteredSongs.addAll(songs);  // Initialize filteredSongs with all songs
      return songs;
    } catch (e) {
      print("Error fetching songs: $e");
    }
    return [];
  }

  // Function to search songs by title
  void searchSongs(String query) {
    searchQuery.value = query; // Update the search query
    if (query.isEmpty) {
      filteredSongs.assignAll(songList); // If query is empty, show all songs
    } else {
      var results = songList.where((song) => song.title.toLowerCase().contains(query.toLowerCase())).toList();
      filteredSongs.assignAll(results);
    }
  }
}
