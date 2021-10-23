import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sensors/sensors.dart';
import 'dart:io';

// questo progetto funziona con versione vecchie di flutter in quelle nuove
// bisogna adare a modificare il manifest di android
// https://github.com/ngiuliani-ng/flutter_advanced_phone_app/blob/master/lib/main.dart
// https://github.com/ngiuliani-ng/flutter_advanced_phone_app/blob/master/android/app/src/main/AndroidManifest.xml

class BodyCustom extends StatefulWidget {
  @override
  _BodyCustomState createState() => _BodyCustomState();
}

class _BodyCustomState extends State<BodyCustom> {
  bool privateMode = false;
  ImagePicker imagePicher = new ImagePicker();
  List<String> listaFoto = [];

  void onPhotoClick() async {
    if (await Permission.camera.request().isGranted) {
      final foto = await imagePicher.getImage(source: ImageSource.camera);
      print(foto.path);
      setState(() {
        listaFoto.add(foto.path);
      });
    }
  }

  @override
  void initState() {
       super.initState();
    attivaGiroscopio();
  }


  void attivaGiroscopio() {
    gyroscopeEvents.listen((event) async {
      if (event.y.abs() > 8) {

        setState(() {
          privateMode = true;
        });

        await Future.delayed(Duration(seconds: 10));

        setState(() {
          privateMode = false;
        });

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Column(
        children: [
          privateMode ? privatePlaceHolder() : listaMessaggi(),
          inputChat(),
        ],
      ),
    );
  }

  Widget privatePlaceHolder() => new Expanded(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Icon(
            Icons.warning,
            size: 150,
            color: Colors.white24,
          ),
          new Text(
            'Private MODE',
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ));

  Widget listaMessaggi() => new Expanded(
        child: new ListView.builder(
          reverse: true,
          itemBuilder: (context, index) => message(listaFoto[index]),
          itemCount: listaFoto.length,
        ),
      );

  Widget message(String photo) => new Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () => launch("https://i.picsum.photos/id/385/5066/3377"
            ".jpg?hmac=6j9_jSefMGXEPyS0LUAF-efQ40TiMXZO2t5DUidTnqg"),
        child: new Container(
          margin: EdgeInsets.only(right: 10, bottom: 20),
          width: 250,
          height: 200,
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(40),
            image: new DecorationImage(
                image: new FileImage(File(photo)), fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                color: Colors.yellow.withAlpha(150),
                offset: Offset(-5, -5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          /*child: new InkWell(
          onTap: (){},
          child: new Image.network(messagePhotoUrl, fit: BoxFit.cover,),
        ),*/
        ),
      ));

  Widget inputChat() => new Padding(
      padding: EdgeInsets.fromLTRB(15, 5, 5, 15),
      child: new Row(
        children: [
          chatTextField(),
          new SizedBox(
            width: 20,
          ),
          chatCameraFab(),
        ],
      ));

  Widget chatTextField() => new Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(150),
                offset: Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 3,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Say something nice",
              border: InputBorder.none,
            ),
          ),
        ),
      );

/*
     * ************************************************************************
   Qui di seguito il texfield con InputDecoration per avere i bordi colorati del texfield

                  child: new TextField(
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 30),
                      hintText: "Say something "
                          "nice",
                      fillColor: Colors.black12,
                      filled: true,
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            new BorderSide(color: Colors.transparent, width: 5.0),
                      ),
                      focusedBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              new BorderSide(color: Colors.transparent, width: 5.0)),

                    ),
                  ),***************************************************/

//Widget privacyMode()=>

  Widget chatCameraFab() => new FloatingActionButton(
        tooltip: "foto",
        onPressed: onPhotoClick,
        backgroundColor: Colors.black,
        child: new IconButton(
          icon: new Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
        ),
      );
}
