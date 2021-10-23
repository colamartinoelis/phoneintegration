import 'package:flutter/material.dart';
import 'package:phoneintegration/Component/BodyCustom.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:core';
import 'package:phoneintegration/Component/AppBarCustom.dart';

//https://picsum.photos/id/124/200/200

final messagePhotoUrl =
    "https://i.picsum.photos/id/385/5066/3377.jpg?hmac=6j9_jSefMGXEPyS0LUAF-efQ40TiMXZO2t5DUidTnqg";

void _onPhoneclick() async {
  final scheme = "tel";
  final phone = "+39 339 276 7616";
  final url = "$scheme:$phone";

  await canLaunch(url) ? await launch(url) : print("Error: onPhoneClick");
}

void _onMailClick() async {
  final scheme = "mailto";
  final email = "info@prova.com";
  final subject = "Email from Flutter App - Fudeo Advanced";
  final body = "Hi, What's up?";
  final url = "$scheme:$email?subject=$subject&body=$body";

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print("Error: onEmailClick");
  }
}

void _onLinkClick() async {
  final url = messagePhotoUrl;

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print("Error: onLinkClick");
  }
}

class Phone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: appBarCustom(),
      body: new BodyCustom(),
    );
  }
}

Widget appBarCustom() => new AppBar(
      leading: new Center(
          child: new CircleAvatar(
        radius: 20,
        backgroundImage: new NetworkImage("https://picsum.photos/id/9/200/200"),
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
          onPressed: _onPhoneclick,
        ),
        new IconButton(
          icon: new Icon(Icons.mail),
          onPressed: _onMailClick,
        ),
        new IconButton(
          icon: new Icon(Icons.link),
          onPressed: _onLinkClick,
        )
      ],
    );

