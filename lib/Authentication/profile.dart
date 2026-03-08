import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), centerTitle: true),
      body: Column(
        children: [
          ListTile(title: Text("Heloo"), leading: Icon(Icons.person)),
          Divider(),
          ListTile(title: Text("Heloo"), leading: Icon(Icons.email)),
          Divider(),
          ListTile(
            title: Text("Heloo"),
            leading: Icon(Icons.perm_contact_calendar_rounded),
          ),
          Divider(),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text("Sign out"),
              leading: Icon(Icons.logout),
            ),
          ),
        ],
      ),
    );
  }
}
