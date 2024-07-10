import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/playercontroller.dart';

class BottomPlayer extends StatelessWidget {
  final PlayerController controller;

  BottomPlayer({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.songList.isEmpty) {
        return Container(
          color: Colors.black87,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: Text(
              'No songs available',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
      final currentSong = controller.songList[controller.playIndex.value];
      return Container(
        color: Colors.black87,
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              leading: Icon(Icons.music_note, color: Colors.white),
              title: Text(
                currentSong.title,
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              subtitle: Text(
                currentSong.artist ?? 'Unknown Artist',
                style: TextStyle(color: Colors.white70, fontSize: 12.0),
              ),
              trailing: IconButton(
                icon: Icon(
                  controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (controller.isPlaying.value) {
                    controller.pauseSong();
                  } else {
                    controller.resumeSong();
                  }
                },
              ),
            ),
            Slider(
              value: controller.currentPosition.value.inSeconds.toDouble(),
              max: controller.songDuration.value.inSeconds.toDouble(),
              onChanged: (value) {
                controller.audioPlayer.seek(Duration(seconds: value.toInt()));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.currentPosition.value
                        .toString()
                        .split('.')
                        .first,
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                  Text(
                    controller.songDuration.value.toString().split('.').first,
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous, color: Colors.white),
                    onPressed: controller.previousSong,
                  ),
                  IconButton(
                    icon: Icon(controller.isPlaying.value ? Icons.pause : Icons.play_arrow, color: Colors.white),
                    onPressed: controller.isPlaying.value ? controller.pauseSong : controller.resumeSong,
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next, color: Colors.white),
                    onPressed: controller.skipSong,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
