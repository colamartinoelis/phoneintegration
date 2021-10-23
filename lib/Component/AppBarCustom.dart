import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PreferredSize(
      child: new AppBar(
        leading: new Center(
            child: new CircleAvatar(
          radius: 20,
          backgroundImage:
              new NetworkImage("https://picsum.photos/id/9/200/200"),
        )),
        title: new ListTile(
          title: new Text(
            "Elis",
          ),
          subtitle: new Text('Now available'),
        ),
        actions: [
          new IconButton(
            icon: new Icon(Icons.phone),
            onPressed: () {},
          ),
          new IconButton(
            icon: new Icon(Icons.mail),
            onPressed: () {},
          ),
          new IconButton(
            icon: new Icon(Icons.link),
            onPressed: () {},
          )
        ]),
      preferredSize: const Size.fromHeight(100),);
  }
}
