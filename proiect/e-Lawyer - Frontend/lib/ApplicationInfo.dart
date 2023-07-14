import 'package:first_app/NavBar.dart';
import 'package:flutter/material.dart';

class ApplicationInfo extends StatefulWidget {
  ApplicationInfo({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _ApplicationInfoState createState() => _ApplicationInfoState();
}

class _ApplicationInfoState extends State<ApplicationInfo> {
  void initState() {
    super.initState();
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
                    return NavBar(title: 'Home');
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
                  child: Text("Cum se realizează comunicarea\ncu avocații? ",
                      style: TextStyle(
                        fontFamily: 'HPSimplified',
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 0, 0, 0),
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ))),
            ]),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Padding(
                  padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text(
                      "Comunicarea cu avocații aplicației se\nrealizează prin intermediul email-ului.\nClientul este contactat de către avocat\nîn cazul în care există neclarități.",
                      style: TextStyle(
                        fontFamily: 'HPSimplified',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 0, 0, 0),
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ))),
            ]),
            SizedBox(
              height: 50,
            ),
            Row(children: [
              Padding(
                  padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text("Cum se realizează plata\nplângerilor? ",
                      style: TextStyle(
                        fontFamily: 'HPSimplified',
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 0, 0, 0),
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ))),
            ]),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Padding(
                  padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text(
                      "Plata produselor se realizează prin\nintermediul platformei PayPal.\nUtilizatorul este nevoit să își creeze un\ncont de Paypal. Ulterior poate să\nfolosească orice metodă de\nplată digitală pe care o dorește.",
                      style: TextStyle(
                        fontFamily: 'HPSimplified',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 0, 0, 0),
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ))),
            ]),
            SizedBox(
              height: 50,
            ),
            Row(children: [
              Padding(
                  padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text(
                      "Ce se întâmplă în cazul în care\no plângere a fost respinsă? ",
                      style: TextStyle(
                        fontFamily: 'HPSimplified',
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 0, 0, 0),
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ))),
            ]),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Padding(
                  padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text(
                      "În cazul în care un avocat respinge o\nplângere, clientul are opțiunea să\nediteze datele în continuare. În cazul în\ncare datele au fost editate, plângerea\ntrece din statusul de \"Respins\" în cel de\n\"În așteptare\", iar avocatul trebuie să ia\ndin nou o decizie în funcție de noile date.",
                      style: TextStyle(
                        fontFamily: 'HPSimplified',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 0, 0, 0),
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ))),
            ]),
            SizedBox(
              height: 50,
            ),
            Row(children: [
              Padding(
                  padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text("Cum îmi șterg contul de\nutilizator? ",
                      style: TextStyle(
                        fontFamily: 'HPSimplified',
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 0, 0, 0),
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ))),
            ]),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Padding(
                  padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text(
                      "Pentru ștergerea contului de utilizator\nvă rugăm să contactați echipa e-Lawyer\npe mail: uvtelawyer23@gmail.com.\nContul nu poate să fie șters în cazul în\ncare există plângeri în desfășurare!",
                      style: TextStyle(
                        fontFamily: 'HPSimplified',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 0, 0, 0),
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ))),
            ]),
            SizedBox(
              height: 50,
            ),
          ])
        ]));
  }
}
