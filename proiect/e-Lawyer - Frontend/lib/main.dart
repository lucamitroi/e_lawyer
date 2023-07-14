import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SignInPage.dart';
import 'SignUpPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'HPSimplified',
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(16, 16, 16, 100),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'e-Lawyer',
                  style: TextStyle(
                    fontFamily: 'HPSimplified',
                    fontSize: 45,
                    color: Color.fromRGBO(81, 85, 126, 100),
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(255, 0, 0, 0),
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Dispute Romanian',
                  style: TextStyle(
                    fontFamily: 'HPSimplified',
                    fontSize: 35,
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
                Text(
                  'Traffic Fines',
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
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignInPage(title: 'Sign In');
                        }));
                      },
                      child: Container(
                          width: 130,
                          height: 45,
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
                              child: Text('Sign In',
                                  style: TextStyle(
                                    fontFamily: 'HPSimplified',
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    shadows: [
                                      Shadow(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        offset: Offset(2, 2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  )))),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUpPage(title: 'Sign Up');
                          }));
                        },
                        child: Container(
                            width: 130,
                            height: 45,
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
                              child: Text('Sign Up',
                                  style: TextStyle(
                                    fontFamily: 'HPSimplified',
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    shadows: [
                                      Shadow(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        offset: Offset(2, 2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  )),
                            ))),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
