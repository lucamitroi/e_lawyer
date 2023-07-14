import 'package:first_app/NavBarLawyer.dart';
import 'package:first_app/models/login_request_model.dart';
import 'package:first_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'NavBar.dart';
import 'SignUpPage.dart';
import 'main.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var _emailString = '';
  var _passwordString = '';
  var _emailValidationText = '';
  var _passwordValidationText = '';
  var borderColorEmail = Color.fromARGB(81, 85, 126, 255);
  var borderColorPassword = Color.fromARGB(81, 85, 126, 255);
  bool _isLoading = true;
  String userData = '';
  String userRole = '';

  void _updateTextEmail(val) {
    setState(() {
      borderColorEmail = Color.fromARGB(81, 85, 126, 255);
      _emailValidationText = '';
      _emailString = val;
    });
  }

  void _updateTextPassword(val) {
    setState(() {
      borderColorPassword = Color.fromARGB(81, 85, 126, 255);
      _passwordValidationText = '';
      _passwordString = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromRGBO(16, 16, 16, 100),
        body: Visibility(
            visible: _isLoading,
            child: ListView(children: [
              Column(children: [
                Align(
                  alignment: Alignment.topRight,
                  child: CloseButton(
                    color: Color.fromARGB(255, 255, 255, 255),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MyHomePage(title: 'Home');
                      }));
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                    padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Row(children: [
                      Text(
                        'Sign In',
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
                        ),
                      ),
                    ])),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Row(children: [
                      Text(
                        'Nu ai cont?',
                        style: TextStyle(
                          fontFamily: 'HPSimplified',
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
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
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Color.fromARGB(81, 85, 126, 255),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUpPage(title: 'Sign Up');
                          }));
                        },
                        child: Text('Înregistrează-te',
                            style: TextStyle(
                              fontFamily: 'HPSimplified',
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Color.fromARGB(81, 85, 126, 255),
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            )),
                      ),
                    ])),
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
                  height: 5,
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
                  height: 5,
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
                                  backgroundColor:
                                      Color.fromARGB(81, 85, 126, 255),
                                  minimumSize: Size(88, 36),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  login_request_model model =
                                      login_request_model(
                                          email: _emailString,
                                          password: _passwordString);
                                  APIService.login(model).then((response) => {
                                        if (response != "")
                                          {
                                            if (response == 'client')
                                              {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return NavBar(title: 'Home');
                                                }))
                                              }
                                            else if (response == 'avocat')
                                              {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return NavBarLawyer(
                                                      title: 'Home');
                                                }))
                                              }
                                          }
                                        else
                                          {
                                            setState(() {
                                              _isLoading = true;
                                              if (!_emailString.isEmpty) {
                                                _emailValidationText =
                                                    "Utilizator invalid";
                                                borderColorEmail =
                                                    Color.fromARGB(
                                                        173, 255, 0, 0);
                                                borderColorPassword =
                                                    Color.fromARGB(
                                                        173, 255, 0, 0);
                                              }
                                            })
                                          }
                                      });
                                  if (_emailString.isEmpty) {
                                    HapticFeedback.heavyImpact();
                                    setState(() {
                                      borderColorEmail =
                                          Color.fromARGB(173, 255, 0, 0);
                                      _emailValidationText = 'Câmp obligatoriu';
                                    });
                                  }

                                  if (_passwordString.isEmpty) {
                                    HapticFeedback.heavyImpact();
                                    setState(() {
                                      borderColorPassword =
                                          Color.fromARGB(173, 255, 0, 0);
                                      _passwordValidationText =
                                          'Câmp obligatoriu';
                                    });
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
              ])
            ]),
            replacement: const Center(child: CircularProgressIndicator())));
  }

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
}
