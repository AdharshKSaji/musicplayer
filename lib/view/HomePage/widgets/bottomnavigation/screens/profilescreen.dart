import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:  Color.fromARGB(255, 32, 30, 30),
      body:Center(
        child: Container(
          child: Column(
            children: [
              CircleAvatar(
              radius: 40,
            )
            ,],
          ),
        ),
      ),

    );
  }
}