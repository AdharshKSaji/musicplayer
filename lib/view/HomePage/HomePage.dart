import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/view/HomePage/widgets/Drawer/drawer.dart';
import 'package:musicplayer/view/HomePage/widgets/bottomnavigation/bottomnavhome.dart';
import 'package:musicplayer/view/HomePage/widgets/bottomnavigation/screens/searchscreen.dart';
import 'package:musicplayer/view/detailsongs/detailsong.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar( backgroundColor: Color.fromARGB(255, 248, 195, 237),
    title: Text("LOUD MUSIC"),actions: [
      IconButton(onPressed: () {
        Get.to(SearchScreen());
        
      }, icon: Icon(Icons.search,color: Colors.white,))
    ],),
    
     drawer: MyDrawer(),
      body:
      Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage
        ("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKnQeYX7k8PasPxYo_-U6eg_22nwoQMwoKh-KvUawUqSNSr27-SUdESablFJCuRBZyg_k&usqp=CAU"),fit: BoxFit.fill)),
      
      child:Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'AVAILABLE MUSICS..',
                      textStyle: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      speed: const Duration(milliseconds: 400),
                    ),
                  ],
                  totalRepeatCount: 4,
                  pause: const Duration(milliseconds: 300),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(child: MyDetail()),
           

         
          ],
        ),
      ),),
      bottomNavigationBar: const BottomNaviHome(),
    );
  }
}
