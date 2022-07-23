import 'package:flutter/material.dart';
import 'WorkList/workList.dart';
//import 'main.dart';
import 'settingsView.dart';

class NavDrawer {
  //var localization = GalleryLocalizations.of(context)!;
  late DrawerHeader drawerHeader;
  late ListView drawerItems;

  NavDrawer(BuildContext context) {
    drawerHeader = DrawerHeader(
      child: Column(children: const [
        Text('🕒 TimeDiet 🍕',
            style: TextStyle(
                fontSize: 26,
                //color: Color.fromARGB(255, 165, 0, 0),
                fontWeight: FontWeight.bold)),
      ]),
      decoration: BoxDecoration(color: Colors.indigo),
    );
    drawerItems = ListView(
      children: [
        drawerHeader,
        ListTile(
          title: Text('Daily Work List'),
          leading: const Icon(Icons.list),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WorkList()),
            );
          },
        ),
        ListTile(
          title: Text('Settings'),
          leading: const Icon(Icons.settings),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsView()),
            );
          },
        ),
      ],
    );
  }

  get drawer => Drawer(
        child: drawerItems,
      );
}
