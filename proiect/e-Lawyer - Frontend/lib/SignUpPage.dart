import 'package:first_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'models/register_request_model.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  void initState() {
    super.initState();
  }

  /*Variables that store the fields strings. They get updated whenever an user 
  makes any kind of changes to their respective fields*/
  var correctFields = true;
  var _firstNameString = '';
  var _lastNameString = '';
  var _emailString = '';
  var _passwordString = '';
  var _password2String = '';
  var _firstNameValidationText = '';
  var _lastNameValidationText = '';
  var _emailValidationText = '';
  var _passwordValidationText = '';
  var _password2ValidationText = '';
  bool isApiCallProcess = false;
  String mail_message = '';
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
      _firstNameString = val;
      if (borderColorFirstName == Color.fromARGB(81, 85, 126, 255)) {
        _whiteSpaceNameWidth = 175;
      }
    });
  }

  //Function that gets the last name string whenever the user updates it
  void _updateTextLastName(val) {
    setState(() {
      borderColorLastName = Color.fromARGB(81, 85, 126, 255);
      _lastNameValidationText = '';
      _lastNameString = val;
    });
  }

  //Function that gets the email string whenever the user updates it
  void _updateTextEmail(val) {
    setState(() {
      borderColorEmail = Color.fromARGB(81, 85, 126, 255);
      _emailValidationText = '';
      _emailString = val;
    });
  }

  //Function that gets the password string whenever the user updates it
  void _updateTextPassword(val) {
    setState(() {
      borderColorPassword = Color.fromARGB(81, 85, 126, 255);
      _passwordValidationText = '';
      _passwordString = val;
    });
  }

  /*Function that gets the password confirmation string whenever the user 
  updates it*/
  void _updateTextPassword2(val) {
    setState(() {
      borderColorPassword2 = Color.fromARGB(81, 85, 126, 255);
      _password2ValidationText = '';
      _password2String = val;
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyHomePage(title: 'Home');
                }));
              },
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(children: [
            Padding(
              padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Text('Sign Up',
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
              child: Row(
                children: [
                  Text(
                    'Parolă:',
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
              child: buildPassword()),
          Padding(
              padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(children: [
                Text(
                  _passwordValidationText,
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
                    'Confirmați parola:',
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
            height: 5,
          ),
          Padding(
              padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: buildConfirmPassword()),
          Padding(
              padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(children: [
                Text(
                  _password2ValidationText,
                  style: TextStyle(color: Color.fromARGB(173, 255, 0, 0)),
                ),
              ])),
          SizedBox(
            height: 15,
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
                          onPressed: () {
                            if (_firstNameString.isEmpty) {
                              correctFields = false;
                              HapticFeedback.heavyImpact();
                              setState(() {
                                _whiteSpaceNameWidth = 60;
                                borderColorFirstName =
                                    Color.fromARGB(173, 255, 0, 0);
                                _firstNameValidationText = 'Câmp obligatoriu';
                              });
                            }

                            if (_lastNameString.isEmpty) {
                              correctFields = false;
                              HapticFeedback.heavyImpact();
                              setState(() {
                                borderColorLastName =
                                    Color.fromARGB(173, 255, 0, 0);
                                _lastNameValidationText = 'Câmp obligatoriu';
                              });
                            }

                            if (_emailString.isEmpty) {
                              correctFields = false;
                              HapticFeedback.heavyImpact();
                              setState(() {
                                borderColorEmail =
                                    Color.fromARGB(173, 255, 0, 0);
                                _emailValidationText = 'Câmp obligatoriu';
                              });
                            } else {
                              isValidEmail =
                                  EmailValidator.validate(_emailString);
                              if (isValidEmail == false) {
                                HapticFeedback.heavyImpact();
                                setState(() {
                                  borderColorEmail =
                                      Color.fromARGB(173, 255, 0, 0);
                                  _emailValidationText = 'Email invalid';
                                });
                              }
                            }

                            if (_passwordString.isEmpty) {
                              correctFields = false;
                              HapticFeedback.heavyImpact();
                              setState(() {
                                borderColorPassword =
                                    Color.fromARGB(173, 255, 0, 0);
                                _passwordValidationText = 'Câmp obligatoriu';
                              });
                            }

                            if (_password2String.isEmpty) {
                              correctFields = false;
                              HapticFeedback.heavyImpact();
                              setState(() {
                                borderColorPassword2 =
                                    Color.fromARGB(173, 255, 0, 0);
                                _password2ValidationText = 'Câmp obligatoriu';
                              });
                            } else {
                              var comparePassword =
                                  _passwordString.compareTo(_password2String);
                              if (comparePassword != 0) {
                                correctFields = false;
                                setState(() {
                                  borderColorPassword2 =
                                      Color.fromARGB(173, 255, 0, 0);
                                  _password2ValidationText =
                                      'Parolele nu corespund';
                                });
                              }
                            }

                            setState(() {
                              isApiCallProcess = true;
                            });
                            if (correctFields == true) {
                              register_request_model model =
                                  register_request_model(
                                      name: _firstNameString,
                                      surname: _lastNameString,
                                      password: _passwordString,
                                      email: _emailString,
                                      role: "client");

                              APIService.register(model, context)
                                  .then((response) {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                              });

                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context),
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

  //Custom widget that creates the password field
  Widget buildPassword() => Container(
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
          _updateTextPassword(val);
        },
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(13),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: borderColorPassword,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: borderColorPassword,
              width: 3.0,
            ),
          ),
        ),
        textInputAction: TextInputAction.done,
      ));

  //Custom widget that creates the password confirmation field
  Widget buildConfirmPassword() => Container(
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
          _updateTextPassword2(val);
        },
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(13),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: borderColorPassword2,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: borderColorPassword2,
              width: 3.0,
            ),
          ),
        ),
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

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Cont creat cu succes'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Vă mulțumim că utilizați serviciul\ne-Lawyer! 🙂"),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyHomePage(title: 'Home');
            }));
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
