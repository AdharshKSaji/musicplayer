import 'package:flutter/material.dart';

class BottomNaviHome extends StatefulWidget {
  const BottomNaviHome({super.key});

  @override
  State<BottomNaviHome> createState() => _BottomNaviHomeState();
}

class _BottomNaviHomeState extends State<BottomNaviHome> {
  @override
  Widget build(BuildContext context) {
    return 
       BottomNavigationBar(
        backgroundColor: Colors.black,
        items: <BottomNavigationBarItem>[
         BottomNavigationBarItem(
      icon:IconButton(onPressed: () {

        
      }, icon: Icon(Icons.home,color: Colors.blue,)) ,
      label: '',
    ),
    //       BottomNavigationBarItem(
    //   icon:IconButton(onPressed: () {
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => SearchBar()));
        
    //   }, icon: Icon(Icons.search,color: Colors.blue,)) ,
    //   label: '',
    // ),
          
          BottomNavigationBarItem(
      icon:IconButton(onPressed: () {
        
      }, icon: Icon(Icons.library_music,color: Colors.blue,)) ,
      label: '',
    ),
         BottomNavigationBarItem(
      icon:IconButton(onPressed: () {
        
      }, icon: Icon(Icons.settings,color: Colors.blue,)) ,
      label: '',
    ),
        ],
        
        type: BottomNavigationBarType.fixed,
      );
    
  }
}