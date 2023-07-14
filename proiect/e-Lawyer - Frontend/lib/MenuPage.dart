import 'package:first_app/ApplicationInfo.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'EditAccount.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  double fontSizeValue = 20;
  var uri_legislation = Uri.parse(
      "https://www.legislatierutiera.ro/legislatie-rutiera/codul-rutier/");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(23, 239, 232, 232),
      body: Column(children: [
        SizedBox(
          height: 100,
        ),
        Padding(
            padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(children: [
              Text("e-Lawyer",
                  style: TextStyle(
                    fontFamily: 'HPSimplified',
                    fontSize: 35,
                    color: Color.fromRGBO(81, 85, 126, 100),
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(255, 0, 0, 0),
                        offset: Offset(1, 1),
                        blurRadius: 4,
                      ),
                    ],
                  ))
            ])),
        SizedBox(
          height: 80,
        ),
        Padding(
            padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditAccount(title: 'Home');
                  }));
                },
                icon: Icon(
                  Icons.supervised_user_circle_sharp,
                  size: 33.0,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                label: Text('Contul personal',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: fontSizeValue,
                      fontWeight: FontWeight.w300,
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(255, 0, 0, 0),
                          offset: Offset(1, 1),
                          blurRadius: 4,
                        ),
                      ],
                    )),
              ),
            ])),
        SizedBox(
          height: 20,
        ),
        Padding(
            padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(children: [
              TextButton.icon(
                onPressed: () {
                  _launchUrl("https://www.google.com/maps/search/Politia");
                },
                icon: Icon(
                  Icons.pin_drop_rounded,
                  size: 33.0,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                label: Text('Locații utile',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: fontSizeValue,
                      fontWeight: FontWeight.w300,
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(255, 0, 0, 0),
                          offset: Offset(1, 1),
                          blurRadius: 4,
                        ),
                      ],
                    )),
              ),
            ])),
        SizedBox(
          height: 20,
        ),
        Padding(
            padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(children: [
              TextButton.icon(
                onPressed: () {
                  _launchUrl(
                      "https://www.legislatierutiera.ro/legislatie-rutiera/codul-rutier/");
                },
                icon: Icon(
                  Icons.info,
                  size: 33.0,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                label: Text('Informații legale',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: fontSizeValue,
                      fontWeight: FontWeight.w300,
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(255, 0, 0, 0),
                          offset: Offset(1, 1),
                          blurRadius: 4,
                        ),
                      ],
                    )),
              ),
            ])),
        SizedBox(
          height: 20,
        ),
        Padding(
            padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ApplicationInfo(title: 'Application informations');
                  }));
                },
                icon: Icon(
                  Icons.wechat,
                  size: 33.0,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                label: Text('Informații aplicație',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: fontSizeValue,
                      fontWeight: FontWeight.w300,
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(255, 0, 0, 0),
                          offset: Offset(1, 1),
                          blurRadius: 4,
                        ),
                      ],
                    )),
              ),
            ])),
      ]),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }
}
