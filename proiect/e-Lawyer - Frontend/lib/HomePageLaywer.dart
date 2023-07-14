import 'dart:convert';
import 'package:first_app/EditComplaint.dart';
import 'package:first_app/NavBarLawyer.dart';
import 'package:flutter/material.dart';
import 'CreatePDF.dart';
import "services/api_service.dart";
import 'globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class HomePageLawyer extends StatefulWidget {
  HomePageLawyer({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HomeStateLawyer createState() => _HomeStateLawyer();
}

class _HomeStateLawyer extends State<HomePageLawyer> {
  bool isFabVisible = true;
  String userData = "";
  String userDataName = "";
  String complaintData = "";
  String userComplaints = "";
  String userName = "";
  String complaintDataIndividual = "";
  List<String> allUsersIDList = List.generate(1000, (index) => '');
  List<String> allComplaintsIDList = List.generate(1000, (index) => '');
  List<dynamic>? jsonMapComplaints;
  List<dynamic>? jsonMapComplaintTemp = List.generate(1000, (index) => '');
  Map<String, dynamic>? jsonMapComplaintTemp2;
  List<String> complaintTitleListNotApproved =
      List.generate(1000, (index) => '');
  List<String> complaintStatusListNotApproved =
      List.generate(1000, (index) => '');
  List<String> complaintEmailListNotApproved =
      List.generate(1000, (index) => '');
  List<String> complaintIDListNotApproved = List.generate(1000, (index) => '');
  List<String> complaintTitleListApproved = List.generate(1000, (index) => '');
  List<String> complaintStatusListApproved = List.generate(1000, (index) => '');
  List<String> complaintEmailListApproved = List.generate(1000, (index) => '');
  List<String> complaintIDListApproved = List.generate(1000, (index) => '');
  List<String> complaintUsernameListNotApproved =
      List.generate(1000, (index) => '');
  List<String> complaintUsernameListApproved =
      List.generate(1000, (index) => '');
  int jsonSize = 0;
  int jsonSizeApproved = 0;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    userData = await APIService.getAllUserProfile();
    List<dynamic> jsonMap = await json.decode(userData);
    userDataName = await APIService.getUserProfile();
    Map<String, dynamic> jsonMapUsr = await json.decode(userDataName);
    userName = await jsonMapUsr['Name'];
    setState(() {
      complaintTitleListNotApproved.clear();
      jsonMapComplaintTemp!.clear();
      complaintStatusListNotApproved.clear();
      complaintEmailListNotApproved.clear();
      complaintIDListNotApproved.clear();
      complaintTitleListApproved.clear();
      complaintStatusListApproved.clear();
      complaintEmailListApproved.clear();
      complaintIDListApproved.clear();
      allUsersIDList.clear();
      complaintUsernameListNotApproved.clear();
      complaintUsernameListApproved.clear();
      allComplaintsIDList.clear();
      for (var entry in jsonMap) {
        if (entry['Role'] == 'client') {
          allUsersIDList.add(entry['_id']);
        }
      }
    });

    for (var entry in allUsersIDList) {
      complaintData = await APIService.getUserComplaintDetails(entry);
      if (complaintData.contains("_id")) {
        jsonMapComplaintTemp = await json.decode(complaintData);

        setState(() {
          for (var entry2 in jsonMapComplaintTemp!) {
            allComplaintsIDList.add(entry2['_id']);
          }
        });
      }
    }

    print(allComplaintsIDList);
    for (var entry in allComplaintsIDList) {
      print(entry);
      complaintDataIndividual = await APIService.getComplaintDetails(entry);
      print(complaintDataIndividual);
      jsonMapComplaintTemp2 = await json.decode(complaintDataIndividual);

      setState(() {
        if (jsonMapComplaintTemp2!["Pay"] == "DA" &&
            jsonMapComplaintTemp2!["Status"] == "În așteptare") {
          complaintTitleListNotApproved.add(jsonMapComplaintTemp2!['Title']);
          complaintStatusListNotApproved.add(jsonMapComplaintTemp2!['Status']);
          complaintUsernameListNotApproved.add(jsonMapComplaintTemp2!['Name'] +
              " " +
              jsonMapComplaintTemp2!['Surname']);
          complaintEmailListNotApproved.add(jsonMapComplaintTemp2!['Email']);
          complaintIDListNotApproved.add(jsonMapComplaintTemp2!['_id']);
        }

        if (jsonMapComplaintTemp2!["Pay"] == "DA" &&
            (jsonMapComplaintTemp2!["Status"] == "Aprobată" ||
                jsonMapComplaintTemp2!["Status"] == "Respinsă")) {
          complaintTitleListApproved.add(jsonMapComplaintTemp2!['Title']);
          complaintStatusListApproved.add(jsonMapComplaintTemp2!['Status']);
          complaintUsernameListApproved.add(jsonMapComplaintTemp2!['Name'] +
              " " +
              jsonMapComplaintTemp2!['Surname']);
          complaintEmailListApproved.add(jsonMapComplaintTemp2!['Email']);
          complaintIDListApproved.add(jsonMapComplaintTemp2!['_id']);
        }

        jsonSize = complaintTitleListNotApproved.length;
        jsonSizeApproved = complaintTitleListApproved.length;
      });
    }
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: _isLoading,
        child: Scaffold(
          backgroundColor: Color.fromARGB(23, 239, 232, 232),
          body: Align(
            alignment: Alignment.topRight,
            child: ListView(children: [
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(children: [
                  Text("Bine ai venit,\n$userName",
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
                      )),
                  SizedBox(
                    width: 125,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 32.0,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return NavBarLawyer(title: 'Home');
                      }));
                    },
                  ),
                ]),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                  padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text("Plângerile nefinalizate: ",
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
              SizedBox(
                height: 20,
              ),
              if (complaintTitleListNotApproved.length != 0)
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: jsonSize,
                    itemBuilder: (context, index) {
                      var height;
                      if (complaintTitleListNotApproved[index].length > 42) {
                        height = 470.0;
                      } else {
                        height = 450.0;
                      }
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Container(
                                height: height,
                                width: 500,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(33, 239, 232, 232),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.8),
                                      offset: Offset(4, 4),
                                      blurRadius: 15,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            Text("Titlul plângerii:",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    Shadow(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      offset: Offset(1, 1),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                                textScaleFactor: 1.0),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            Flexible(
                                                child: Text(
                                              complaintTitleListNotApproved[
                                                  index],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                shadows: [
                                                  Shadow(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    offset: Offset(1, 1),
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            Text("Statusul plângerii:",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    Shadow(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      offset: Offset(1, 1),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                                textScaleFactor: 1.0),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              complaintStatusListNotApproved[
                                                  index],
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 113, 149, 177),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                shadows: [
                                                  Shadow(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    offset: Offset(1, 1),
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            Text("Plângere creată de către:",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    Shadow(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      offset: Offset(1, 1),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                                textScaleFactor: 1.0),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              complaintUsernameListNotApproved[
                                                  index],
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                shadows: [
                                                  Shadow(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    offset: Offset(1, 1),
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                                "Adresa de mail a utilizatorului:",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    Shadow(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      offset: Offset(1, 1),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                                textScaleFactor: 1.0),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              complaintEmailListNotApproved[
                                                  index],
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                shadows: [
                                                  Shadow(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    offset: Offset(1, 1),
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 56, 58, 60),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  blurRadius: 15,
                                                ),
                                              ],
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                globals.complaintID =
                                                    complaintIDListNotApproved[
                                                        index];
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return EditComplaint(
                                                      title: 'Edit Complaint');
                                                }));
                                              },
                                              child: Text("Editare",
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 113, 149, 177),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    shadows: [
                                                      Shadow(
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        offset: Offset(1, 1),
                                                        blurRadius: 4,
                                                      ),
                                                    ],
                                                  ),
                                                  textScaleFactor: 1.0),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 56, 58, 60),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    blurRadius: 15,
                                                  ),
                                                ],
                                              ),
                                              child: TextButton(
                                                onPressed: () async {
                                                  if (await Permission.storage
                                                      .request()
                                                      .isGranted) {
                                                    CreatePDF().generatePDF(
                                                        complaintIDListNotApproved[
                                                            index]);
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          _buildPopupDialogGenerated(
                                                              context),
                                                    );
                                                  } else {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          _buildPopupDialogGeneratedDenied(
                                                              context),
                                                    );
                                                  }
                                                },
                                                child: Text('Descarcă PDF',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 113, 149, 177),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      shadows: [
                                                        Shadow(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                          offset: Offset(1, 1),
                                                          blurRadius: 4,
                                                        ),
                                                      ],
                                                    ),
                                                    textScaleFactor: 1.0),
                                              )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 56, 58, 60),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  blurRadius: 15,
                                                ),
                                              ],
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      _buildPopupDialogDenied(
                                                          context,
                                                          complaintIDListNotApproved[
                                                              index],
                                                          complaintTitleListNotApproved[
                                                              index],
                                                          "RESPINSĂ",
                                                          complaintEmailListNotApproved[
                                                              index]),
                                                );
                                              },
                                              child: Text("Respingere",
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 113, 149, 177),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    shadows: [
                                                      Shadow(
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        offset: Offset(1, 1),
                                                        blurRadius: 4,
                                                      ),
                                                    ],
                                                  ),
                                                  textScaleFactor: 1.0),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 56, 58, 60),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    blurRadius: 15,
                                                  ),
                                                ],
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        _buildPopupDialogApprove(
                                                            context,
                                                            complaintIDListNotApproved[
                                                                index],
                                                            complaintTitleListNotApproved[
                                                                index],
                                                            "APROBATĂ",
                                                            complaintEmailListNotApproved[
                                                                index]),
                                                  );
                                                },
                                                child: Text('Aprobare',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 113, 149, 177),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      shadows: [
                                                        Shadow(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                          offset: Offset(1, 1),
                                                          blurRadius: 4,
                                                        ),
                                                      ],
                                                    ),
                                                    textScaleFactor: 1.0),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ]);
                    }),
              if (complaintTitleListNotApproved.length == 0)
                Padding(
                    padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text("Nu există nicio plângere nefinalizată",
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
              SizedBox(
                height: 30,
              ),
              Padding(
                  padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text("Plângerile finalizate: ",
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
              SizedBox(
                height: 20,
              ),
              if (complaintTitleListApproved.length != 0)
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: jsonSizeApproved,
                    itemBuilder: (context, index) {
                      var height;
                      if (complaintTitleListApproved[index].length > 42) {
                        height = 410.0;
                      } else {
                        height = 390.0;
                      }
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Container(
                                height: height,
                                width: 500,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(33, 239, 232, 232),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.8),
                                      offset: Offset(4, 4),
                                      blurRadius: 15,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            Text("Titlul plângerii:",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    Shadow(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      offset: Offset(1, 1),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                                textScaleFactor: 1.0),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            Flexible(
                                                child: Text(
                                              complaintTitleListApproved[index],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                shadows: [
                                                  Shadow(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    offset: Offset(1, 1),
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            Text("Statusul plângerii:",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    Shadow(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      offset: Offset(1, 1),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                                textScaleFactor: 1.0),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            if (complaintStatusListApproved[
                                                    index] ==
                                                'Aprobată')
                                              Text(
                                                complaintStatusListApproved[
                                                    index],
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 25, 116, 40),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  shadows: [
                                                    Shadow(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      offset: Offset(1, 1),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            if (complaintStatusListApproved[
                                                    index] ==
                                                'Respinsă')
                                              Text(
                                                complaintStatusListApproved[
                                                    index],
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 238, 38, 38),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  shadows: [
                                                    Shadow(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      offset: Offset(1, 1),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            Text("Plângere creată de către:",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    Shadow(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      offset: Offset(1, 1),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                                textScaleFactor: 1.0),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              complaintUsernameListApproved[
                                                  index],
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                shadows: [
                                                  Shadow(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    offset: Offset(1, 1),
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                                "Adresa de mail a utilizatorului:",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    Shadow(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      offset: Offset(1, 1),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                                textScaleFactor: 1.0),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              complaintEmailListApproved[index],
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                shadows: [
                                                  Shadow(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    offset: Offset(1, 1),
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      child: Row(
                                        children: [
                                          if (complaintStatusListApproved[
                                                  index] ==
                                              'Aprobată')
                                            Container(
                                                width: 310,
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 56, 58, 60),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.7),
                                                      blurRadius: 15,
                                                    ),
                                                  ],
                                                ),
                                                child: TextButton(
                                                  onPressed: () async {
                                                    if (await Permission.storage
                                                        .request()
                                                        .isGranted) {
                                                      CreatePDF().generatePDF(
                                                          complaintIDListApproved[
                                                              index]);
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            _buildPopupDialogGenerated(
                                                                context),
                                                      );
                                                    } else {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            _buildPopupDialogGeneratedDenied(
                                                                context),
                                                      );
                                                    }
                                                  },
                                                  child: Text('Descarcă PDF',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 113, 149, 177),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        shadows: [
                                                          Shadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            offset:
                                                                Offset(1, 1),
                                                            blurRadius: 4,
                                                          ),
                                                        ],
                                                      ),
                                                      textScaleFactor: 1.0),
                                                )),
                                          if (complaintStatusListApproved[
                                                  index] ==
                                              'Respinsă')
                                            Container(
                                                width: 310,
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 56, 58, 60),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.7),
                                                      blurRadius: 15,
                                                    ),
                                                  ],
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    globals.complaintID =
                                                        complaintIDListApproved[
                                                            index];
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return EditComplaint(
                                                          title:
                                                              'Edit Complaint');
                                                    }));
                                                  },
                                                  child: Text('Editare',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 113, 149, 177),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        shadows: [
                                                          Shadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            offset:
                                                                Offset(1, 1),
                                                            blurRadius: 4,
                                                          ),
                                                        ],
                                                      ),
                                                      textScaleFactor: 1.0),
                                                )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ]);
                    }),
              if (complaintTitleListApproved.length == 0)
                Padding(
                    padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text("Nu există nicio plângere finalizată",
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
              SizedBox(
                height: 50,
              ),
            ]),
          ),
        ),
        replacement: const Center(child: CircularProgressIndicator()));
  }

  Future send_email({
    required String complaint_title,
    required String complaint_status,
    required String to_email,
    required String user_email,
  }) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const serviceId = 'service_vtxl8jr';
    const templateId = 'template_avh8bsr';
    const userId = '0Zv7fGFgzsrdhq5pt';
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json'
        }, //This line makes sure it works for all platforms.
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'complaint_title': complaint_title,
            'complaint_status': complaint_status,
            'to_email': to_email,
            'user_email': user_email,
          },
          'accessToken': 'FG_avu0Ii1oYstPppNGO_',
        }));
    print(response.body);
    return response.statusCode;
  }

  Widget _buildPopupDialogApprove(
      BuildContext context,
      String complaintID,
      String complaintTitleListNotApproved,
      String complaintStatusListNotApproved,
      String complaintEmailListNotApproved) {
    return new AlertDialog(
      title: const Text('Atenție!'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Plângerea va fi aprobată."),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Anulează'),
        ),
        new TextButton(
          onPressed: () {
            send_email(
                complaint_title: complaintTitleListNotApproved,
                complaint_status: complaintStatusListNotApproved,
                to_email: complaintEmailListNotApproved,
                user_email: "uvtelawyer23@gmail.com");
            APIService.patchComplaint("Status", "Aprobată", complaintID);
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NavBarLawyer(title: 'Home');
            }));
          },
          child: const Text('Aprobă'),
        ),
      ],
    );
  }

  Widget _buildPopupDialogDenied(
      BuildContext context,
      String complaintID,
      String complaintTitleListNotApproved,
      String complaintStatusListNotApproved,
      String complaintEmailListNotApproved) {
    return new AlertDialog(
      title: const Text('Atenție!'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Plângerea va fi respinsă."),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Anulează'),
        ),
        new TextButton(
          onPressed: () {
            send_email(
                complaint_title: complaintTitleListNotApproved,
                complaint_status: complaintStatusListNotApproved,
                to_email: complaintEmailListNotApproved,
                user_email: "uvtelawyer23@gmail.com");
            APIService.patchComplaint("Status", "Respinsă", complaintID);
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NavBarLawyer(title: 'Home');
            }));
          },
          child: const Text('Respinge'),
        ),
      ],
    );
  }

  Widget _buildPopupDialogGenerated(BuildContext context) {
    return new AlertDialog(
      title: const Text('Succes!'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              "Fișierul PDF a fost generat. Îl puteți găsi în directorul Download al dispozitivului dumneavoastră."),
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
}

Widget _buildPopupDialogGeneratedDenied(BuildContext context) {
  return new AlertDialog(
    title: const Text('Atenție!'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            "Pentru a putea să generați fișierul PDF trebuie să dați permisiune aplicației să scrie fișiere pe dispozitiv."),
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
