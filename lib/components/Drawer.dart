import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mymusic/pages/HomePage.dart';
import 'package:mymusic/pages/SettingsPage.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              child: Icon(
            Icons.home,
            size: 50,
          )),
          //Home Tile
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text(
                  "Home",
                  style: TextStyle(fontSize: 26),
                ),
                leading: Icon(
                  Icons.home,
                  size: 34,
                  color: Colors.brown,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  SettingsPage()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: ListTile(
                title: Text(
                  "Settings",
                  style: TextStyle(fontSize: 26),
                ),
                leading: Icon(
                  Icons.settings,
                  size: 34,
                  color: Colors.brown,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
