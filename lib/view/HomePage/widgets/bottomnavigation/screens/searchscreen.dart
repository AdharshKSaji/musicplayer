import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/playercontroller.dart';

class SearchScreen extends StatelessWidget {
  final PlayerController controller = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search songs...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            controller.searchSongs(value); // Call search function on text change
          },
        ),
      ),
      body: Obx(() {
        if (controller.searchQuery.isEmpty) {
          return Center(
            child: Text('Enter a song title to search.'),
          );
        } else if (controller.filteredSongs.isEmpty) {
          return Center(
            child: Text('No songs found.'),
          );
        } else {
          return ListView.builder(
            itemCount: controller.filteredSongs.length,
            itemBuilder: (context, index) {
              var song = controller.filteredSongs[index];
              return ListTile(
                title: Text(song.title),
                subtitle: Text(song.artist ?? 'Unknown Artist'),
                onTap: () {
                  controller.playSong(song.uri, index); // Play song on tap
                },
              );
            },
          );
        }
      }),
    );
  }
}
