import 'dart:convert';

import 'package:first_app/EditAccount.dart';
import 'package:first_app/services/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:first_app/globals.dart' as globals;
import "services/api_service.dart";
import 'main.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userData = "";
  String userName = "";
  String userSurname = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    userData = await APIService.getUserProfile();
    print(userData);
    setState(() {
      Map<String, dynamic> jsonMap = json.decode(userData);
      userName = jsonMap['Name'];
      userSurname = jsonMap['Surname'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(23, 239, 232, 232),
      body: Align(
          alignment: Alignment.topRight,
          child: ListView(children: [
            SizedBox(
              height: 60,
            ),
            Padding(
                padding: new EdgeInsets.fromLTRB(90, 0, 30, 0),
                child: Stack(children: [
                  Icon(
                    Icons.account_box,
                    color: Colors.white,
                    size: 220.0,
                  ),
                  Container(
                    height: 190,
                    width: 190,
                    child: Icon(
                      Icons.account_box,
                      color: Colors.white,
                      size: 220.0,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          offset: Offset(15, 15),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                  ),
                ])),
            Center(
                child: Text("$userSurname $userName",
                    style: TextStyle(
                      fontFamily: 'HPSimplified',
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(255, 0, 0, 0),
                          offset: Offset(1, 1),
                          blurRadius: 4,
                        ),
                      ],
                    ))),
            SizedBox(height: 20),
            Center(
                child: Container(
                    width: 130,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.8),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(81, 85, 126, 255),
                        minimumSize: Size(130, 36),
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EditAccount(title: 'Home');
                        }));
                      },
                      child: Text(
                        'Editare cont',
                        style: TextStyle(
                          fontFamily: 'HPSimplified',
                          fontSize: 17,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 0, 0, 0),
                              offset: Offset(1, 1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ))),
            SizedBox(
              height: 5,
            ),
            Center(
                child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Color.fromARGB(81, 85, 126, 255),
                    ),
                    onPressed: () {
                      globals.userID = '';
                      SharedService.logout(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MyHomePage(title: 'main');
                      }));
                    },
                    child: Container(
                        width: 130,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 56, 58, 60),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text('Ieșire din cont',
                                style: TextStyle(
                                  fontFamily: 'HPSimplified',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  shadows: [
                                    Shadow(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      offset: Offset(1, 1),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ))))))
          ])),
    );
  }
}
