import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/playercontroller.dart';
import 'dart:developer';

class PlayerScreen extends StatefulWidget {
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> with SingleTickerProviderStateMixin {
  late final PlayerController controller ;
  AnimationController? _animationController;
  Animation<Decoration>? _decorationAnimation;

  @override
  void initState() {
    super.initState();
   controller = Get.find<PlayerController>();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _decorationAnimation = DecorationTween(
      begin: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      end: BoxDecoration(
        color: Color.fromARGB(255, 106, 246, 239),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ).animate(_animationController!);
    
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.red,
          ),
        ),
      ),
      body: Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage
        ("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKnQeYX7k8PasPxYo_-U6eg_22nwoQMwoKh-KvUawUqSNSr27-SUdESablFJCuRBZyg_k&usqp=CAU"),fit: BoxFit.fill)),
      
        child: Column(
          children: [
            Obx(() {
              log('rebuild');
                return Center(
                  child: DecoratedBoxTransition(
                    decoration: _decorationAnimation!,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.songList[controller.playIndex.value].title,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            controller.songList[controller.playIndex.value].artist ?? 'Unknown Artist',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          Slider(
                            min: 0.0,
                            max: controller.songDuration.value.inSeconds.toDouble(),
                            value: controller.currentPosition.value.inSeconds.toDouble(),
                            onChanged: (value) {
                              final position = Duration(seconds: value.toInt());
                              controller.audioPlayer.seek(position);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_formatDuration(controller.currentPosition.value)),
                                Text(_formatDuration(controller.songDuration.value)),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.skip_previous),
                                onPressed: controller.previousSong,
                              ),
                              IconButton(
                                icon: Icon(controller.isPlaying.value ? Icons.pause : Icons.play_arrow),
                                onPressed: controller.isPlaying.value ? controller.pauseSong : controller.resumeSong,
                              ),
                              IconButton(
                                icon: Icon(Icons.skip_next),
                                onPressed: controller.skipSong,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              
            }),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$minutes:$seconds';
  }
}
