import 'package:ecommerce_app/Authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final auth = FirebaseAuth.instance;
  late User? user = auth.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(user?.displayName ?? "Guest".toString()),
            leading: Icon(Icons.person),
          ),
          Divider(),
          ListTile(
            title: Text(user!.email.toString()),
            leading: Icon(Icons.email),
          ),
          Divider(),
          ListTile(
            title: Text("+929292119219"),
            leading: Icon(Icons.perm_contact_calendar_rounded),
          ),
          Divider(),
          InkWell(
            onTap: () {
              auth
                  .signOut()
                  .then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  })
                  .onError((error, stackTrace) {
                    debugPrint(error.toString());
                  });
            },
            child: ListTile(
              title: Text("Sign out"),
              leading: Icon(Icons.logout),
            ),
          ),
          Divider(),
          SizedBox(height: 20),
          Text("Terms & Conditons"),
        ],
      ),
    );
  }
}
