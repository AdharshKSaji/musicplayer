import 'package:flutter/material.dart';


class AppBar extends StatefulWidget {
  const AppBar({super.key});

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          IconButton(onPressed: () {
          }, icon: Icon
          (Icons.arrow_back_ios,color: Colors.red,))
        ],
      ),
    );
  }
}