import 'dart:convert';

import 'package:first_app/NavBar.dart';
import 'package:first_app/NavBarLawyer.dart';
import 'package:first_app/services/api_service.dart';
import 'package:flutter/material.dart';

class EditAccount extends StatefulWidget {
  EditAccount({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  /*Variables that store the fields strings. They get updated whenever an user 
  makes any kind of changes to their respective fields*/
  var correctFields = true;

  var _firstNameValidationText = '';
  var _lastNameValidationText = '';
  var _emailValidationText = '';
  bool isApiCallProcess = false;
  var mail_controller = TextEditingController();
  var first_name_controller = TextEditingController();
  var last_name_controller = TextEditingController();

  String userData = '';
  String userRole = '';

  var isValidEmail;
  double _whiteSpaceNameWidth = 60;

  /*Variables that store the color of the fields border. Default color is
  Color.fromARGB(81, 85, 126, 255), and it changes to 
  Color.fromARGB(173, 255, 0, 0) when an invalid action is performed*/
  var borderColorFirstName = Color.fromARGB(81, 85, 126, 255);
  var borderColorLastName = Color.fromARGB(81, 85, 126, 255);
  var borderColorEmail = Color.fromARGB(81, 85, 126, 255);
  var borderColorCNP = Color.fromARGB(81, 85, 126, 255);
  var borderColorAddress = Color.fromARGB(81, 85, 126, 255);
  var borderColorPassword = Color.fromARGB(81, 85, 126, 255);
  var borderColorPassword2 = Color.fromARGB(81, 85, 126, 255);

  //Function that gets the first name string whenever the user updates it
  void _updateTextFirstName(val) {
    setState(() {
      borderColorFirstName = Color.fromARGB(81, 85, 126, 255);
      _firstNameValidationText = '';
      if (borderColorFirstName == Color.fromARGB(81, 85, 126, 255)) {
        _whiteSpaceNameWidth = 175;
      }
    });
  }

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    userData = await APIService.getUserProfile();
    Map<String, dynamic> jsonMap = await json.decode(userData);
    userRole = await jsonMap['Role'];
  }

  //Function that gets the last name string whenever the user updates it
  void _updateTextLastName(val) {
    setState(() {
      borderColorLastName = Color.fromARGB(81, 85, 126, 255);
      _lastNameValidationText = '';
    });
  }

  //Function that gets the email string whenever the user updates it
  void _updateTextEmail(val) {
    setState(() {
      borderColorEmail = Color.fromARGB(81, 85, 126, 255);
      _emailValidationText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromRGBO(16, 16, 16, 100),
      body: ListView(children: [
        Column(children: [
          Align(
            alignment: Alignment.topRight,
            child: CloseButton(
              color: Color.fromARGB(255, 255, 255, 255),
              onPressed: () {
                if (userRole == 'client') {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NavBar(title: 'Home');
                  }));
                } else if (userRole == 'avocat') {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NavBarLawyer(title: 'Home');
                  }));
                }
              },
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(children: [
            Padding(
              padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Text('Editarea contului de utilizator',
                  style: TextStyle(
                    fontFamily: 'HPSimplified',
                    fontSize: 25,
                    color: Color.fromARGB(255, 255, 255, 255),
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(255, 0, 0, 0),
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  )),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Row(children: [
            Padding(
              padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
              child:
                  Text('Introduceți datele pe care doriți să\nle modificați:',
                      style: TextStyle(
                        fontFamily: 'HPSimplified',
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 255, 255, 255),
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 0, 0, 0),
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      )),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                height: 50,
              )
            ],
          ),
          Padding(
              padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                children: [
                  Text(
                    'Prenume:',
                    style: TextStyle(
                      fontFamily: 'HPSimplified',
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(255, 0, 0, 0),
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 120,
                  ),
                  Text(
                    'Nume:',
                    style: TextStyle(
                      fontFamily: 'HPSimplified',
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(255, 0, 0, 0),
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                children: [
                  Expanded(
                    child: buildFirstName(),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: buildLastName(),
                  ),
                ],
              )),
          Padding(
              padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(children: [
                Text(
                  _firstNameValidationText,
                  style: TextStyle(color: Color.fromARGB(173, 255, 0, 0)),
                ),
                SizedBox(
                  width: _whiteSpaceNameWidth,
                ),
                Text(
                  _lastNameValidationText,
                  style: TextStyle(color: Color.fromARGB(173, 255, 0, 0)),
                ),
              ])),
          SizedBox(
            height: 5,
          ),
          Padding(
              padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                children: [
                  Text(
                    'Email:',
                    style: TextStyle(
                      fontFamily: 'HPSimplified',
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(255, 0, 0, 0),
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: buildEmail()),
          Padding(
              padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(children: [
                Text(
                  _emailValidationText,
                  style: TextStyle(color: Color.fromARGB(173, 255, 0, 0)),
                ),
              ])),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      decoration: BoxDecoration(
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
                            minimumSize: Size(88, 36),
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                          onPressed: () async {
                            String mail_message = '';
                            if (first_name_controller.text != '')
                              APIService.patchUserProfile(
                                  "Name", first_name_controller.text);
                            if (last_name_controller.text != '')
                              APIService.patchUserProfile(
                                  "Surname", last_name_controller.text);
                            if (mail_controller.text != '') {
                              mail_message = await APIService.patchUserProfile(
                                  "Email", mail_controller.text);
                            }
                            if (mail_message
                                .contains("duplicate key error collection")) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialogEmail(context),
                              );
                            } else if (mail_message.contains(
                                        "duplicate key error collection") ==
                                    false ||
                                mail_message == '') {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context, userRole),
                              );
                            }
                          },
                          child: Text(
                            'Continuă',
                            style: TextStyle(
                              fontFamily: 'HPSimplified',
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w300,
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ))))),
          SizedBox(
            height: 20,
          )
        ])
      ]),
    );
  }

  //Custom widget that creates the email field
  Widget buildEmail() => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromRGBO(16, 16, 16, 100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            offset: Offset(5, 5),
            blurRadius: 15,
          ),
        ],
      ),
      child: TextField(
        onChanged: (val) {
          _updateTextEmail(val);
        },
        controller: mail_controller,
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(13),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: borderColorEmail,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: borderColorEmail,
              width: 3.0,
            ),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
      ));

  //Custom widget that creates the first name field
  Widget buildFirstName() => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromRGBO(16, 16, 16, 100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            offset: Offset(5, 5),
            blurRadius: 15,
          ),
        ],
      ),
      child: TextField(
        onChanged: (val) {
          _updateTextFirstName(val);
        },
        controller: first_name_controller,
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(13),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: borderColorFirstName,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: borderColorFirstName,
              width: 3.0,
            ),
          ),
        ),
        textInputAction: TextInputAction.done,
      ));

  //Custom widget that creates the last name field
  Widget buildLastName() => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromRGBO(16, 16, 16, 100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            offset: Offset(5, 5),
            blurRadius: 15,
          ),
        ],
      ),
      child: TextField(
        onChanged: (val) {
          _updateTextLastName(val);
        },
        controller: last_name_controller,
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(13),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: borderColorLastName,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: borderColorLastName,
              width: 3.0,
            ),
          ),
        ),
        textInputAction: TextInputAction.done,
      ));
}

Widget _buildPopupDialog(BuildContext context, String userRole) {
  return new AlertDialog(
    title: const Text('Succes!'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Datele au fost modificate cu succes!"),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          if (userRole == 'client') {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NavBar(title: 'Home');
            }));
          } else if (userRole == 'avocat') {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NavBarLawyer(title: 'Home');
            }));
          }
        },
        child: const Text('Close'),
      ),
    ],
  );
}

Widget _buildPopupDialogEmail(BuildContext context) {
  return new AlertDialog(
    title: const Text('Eroare'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            "Această adresa de mail există deja în baza de date. Încercați altă varianta."),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}
