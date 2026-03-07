import 'package:flutter/material.dart';

class LogOut extends StatefulWidget {
  const LogOut({super.key});

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
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
