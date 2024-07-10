import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controller/playercontroller.dart';
import 'package:musicplayer/view/HomePage/widgets/MiniPlayer/mini.dart';
import 'package:musicplayer/view/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MyDetail extends StatefulWidget {
  const MyDetail({super.key});

  @override
  State<MyDetail> createState() => _MyDetailState();
}

class _MyDetailState extends State<MyDetail> {
  final PlayerController controller = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    controller.audioQuery.scanMedia('/storage/emulated/0');
    return Scaffold(
            body: FutureBuilder<List<SongModel>>(
        future: controller.fetchSongs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Nothing found",
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage
        ("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKnQeYX7k8PasPxYo_-U6eg_22nwoQMwoKh-KvUawUqSNSr27-SUdESablFJCuRBZyg_k&usqp=CAU"),fit: BoxFit.fill)),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                        childAspectRatio: 0.75, // Adjust this ratio to fit your design
                      ),
                      itemBuilder: (context, index) {
                        final song = snapshot.data![index];
                        return Container(
                          color: const Color.fromARGB(0, 207, 206, 206),
                          margin: const EdgeInsets.all(4),
                          child: Obx(() => GestureDetector(
                            onTap: () {
                              controller.playSong(song.data, index);
                              Get.to(() => PlayerScreen());
                            },
                            child: GridTile(
                              header: controller.playIndex.value == index && controller.isPlaying.value
                                  ? const Icon(Icons.play_arrow, color: Colors.white)
                                  : null,
                              child: QueryArtworkWidget(
                                id: song.id,
                                type: ArtworkType.AUDIO,
                              ), 
                              footer: GridTileBar(
                                backgroundColor: Colors.black54,
                                title: Text(
                                  song.displayNameWOExt,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  song.artist ?? "Unknown Artist",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )),
                        );
                      },
                    ),
                  ),
                  Obx(() {
                    if (controller.songList.isNotEmpty && controller.playIndex.value>=0) {
                      return BottomPlayer(controller: controller);
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
