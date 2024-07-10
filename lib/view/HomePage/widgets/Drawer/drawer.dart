import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
      Drawer(
        child: Column(
          children: [
            TextButton.icon(
            onPressed: () {
              // Define the action when the button is pressed
              print('Home button pressed');
            },
            icon: Icon(Icons.home),
            label: Text('Home'),)
          ],
        ),
      ),
    );
  }
}