import 'package:flutter/material.dart';

class Profile
 extends StatefulWidget {
  const Profile
  ({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), centerTitle: true),
      body: Column(
        children: [
          ListTile(
            title: Text("Heloo"),
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/images/shoes_1.png"),
            ),
          ),
          ListTile(
            title: Text("Heloo"),
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/images/shoes_1.png"),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: Icon(Icons.logout)),
        ],
      ),
    );
  }
}
