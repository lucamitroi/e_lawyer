import 'dart:convert';
import 'package:first_app/CreatePDF.dart';
import 'package:first_app/EditComplaint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:first_app/CreateComplaint.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'NavBar.dart';
import "services/api_service.dart";
import 'globals.dart' as globals;
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  bool isFabVisible = true;
  String userData = "";
  String userComplaints = "";
  String userName = "";
  List<String> complaintTitleListNotPaid = List.generate(1000, (index) => '');
  List<String> complaintStatusListNotPaid = List.generate(1000, (index) => '');
  List<String> complaintJudgeListNotPaid = List.generate(1000, (index) => '');
  List<String> complaintIDListNotPaid = List.generate(1000, (index) => '');
  List<String> complaintTitleListPaid = List.generate(1000, (index) => '');
  List<String> complaintStatusListPaid = List.generate(1000, (index) => '');
  List<String> complaintJudgeListPaid = List.generate(1000, (index) => '');
  List<String> complaintIDListPaid = List.generate(1000, (index) => '');
  List<dynamic>? jsonMapComplaints;
  int jsonSize = 0;
  int jsonSizePaid = 0;
  var _isLoading = false;
  var payed = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    userData = await APIService.getUserProfile();
    userComplaints = await APIService.getUserComplaints();
    Map<String, dynamic> jsonMap = await json.decode(userData);
    userName = await jsonMap['Name'];
    jsonMapComplaints = await json.decode(userComplaints);
    globals.complaintID = '';
    setState(() {
      complaintTitleListNotPaid.clear();
      complaintStatusListNotPaid.clear();
      complaintJudgeListNotPaid.clear();
      complaintIDListNotPaid.clear();
      complaintTitleListPaid.clear();
      complaintStatusListPaid.clear();
      complaintJudgeListPaid.clear();
      complaintIDListPaid.clear();
      for (var entry in jsonMapComplaints!) {
        if (entry['Pay'] == 'NU') {
          complaintTitleListNotPaid.add(entry['Title']);
          complaintStatusListNotPaid.add(entry['Status']);
          complaintJudgeListNotPaid.add(entry['Lawyer']);
          complaintIDListNotPaid.add(entry['_id']);
        } else {
          complaintTitleListPaid.add(entry['Title']);
          complaintStatusListPaid.add(entry['Status']);
          complaintJudgeListPaid.add(entry['Lawyer']);
          complaintIDListPaid.add(entry['_id']);
        }
      }
    });
    jsonSize = complaintTitleListNotPaid.length;
    jsonSizePaid = complaintTitleListPaid.length;
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: _isLoading,
        child: Scaffold(
          backgroundColor: Color.fromARGB(23, 239, 232, 232),
          body: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.direction == ScrollDirection.forward) {
                  if (!isFabVisible) setState(() => isFabVisible = true);
                } else if (notification.direction == ScrollDirection.reverse) {
                  if (isFabVisible) setState(() => isFabVisible = false);
                }

                return true;
              },
              child: Align(
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
                              return NavBar(title: 'Home');
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
                        child: Text("Plângerile neplătite: ",
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
                    if (complaintTitleListNotPaid.length != 0)
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: jsonSize,
                          itemBuilder: (context, index) {
                            var height;
                            if (complaintTitleListNotPaid[index].length > 42) {
                              height = 330.0;
                            } else {
                              height = 310.0;
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
                                        color:
                                            Color.fromARGB(33, 239, 232, 232),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.8),
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
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 0, 20, 0),
                                              child: Row(
                                                children: [
                                                  Text("Titlul plângerii:",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
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
                                                ],
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 0, 20, 0),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                      child: Text(
                                                    complaintTitleListNotPaid[
                                                        index],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 0, 20, 0),
                                              child: Row(
                                                children: [
                                                  Text("Statusul plângerii:",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
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
                                                ],
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 0, 20, 0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    complaintStatusListNotPaid[
                                                        index],
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 113, 149, 177),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 0, 20, 0),
                                              child: Row(
                                                children: [
                                                  Text("Tipul cererii:",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
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
                                                ],
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 0, 20, 0),
                                              child: Row(
                                                children: [
                                                  if (complaintJudgeListNotPaid[
                                                          index] ==
                                                      'NU')
                                                    Text(
                                                      "Fără reprezentare în instanță",
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                    ),
                                                  if (complaintJudgeListNotPaid[
                                                          index] ==
                                                      'DA')
                                                    Text(
                                                      "Cu reprezentare în instanță",
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                    ),
                                                ],
                                              )),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 0, 20, 0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 56, 58, 60),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                                                          complaintIDListNotPaid[
                                                              index];
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return EditComplaint(
                                                            title:
                                                                'Edit Complaint');
                                                      }));
                                                    },
                                                    child: Text("Editare",
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              113,
                                                              149,
                                                              177),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          shadows: [
                                                            Shadow(
                                                              color: Color
                                                                  .fromARGB(255,
                                                                      0, 0, 0),
                                                              offset:
                                                                  Offset(1, 1),
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
                                                          BorderRadius.circular(
                                                              8),
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
                                                        String payment = '';
                                                        if (complaintJudgeListNotPaid[
                                                                index] ==
                                                            'NU') {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  UsePaypal(
                                                                      sandboxMode:
                                                                          true,
                                                                      clientId:
                                                                          "AX9I_PCcYBUJ2MHO--rQHoauuxG3pwld6nEBE_Z9hfGPRAkfUdGEoIwDJKXdA_7nPOVwjoXQq_GGLAbf",
                                                                      secretKey:
                                                                          "ENPjmJl67JVAz8dATjkRCEdz1W3EV82zhbmXYzfs8-ERZDzyHwezkJXBJXPoZLHA4xUbO0BvauQdcouk",
                                                                      returnURL:
                                                                          "https://samplesite.com/return",
                                                                      cancelURL:
                                                                          "https://samplesite.com/cancel",
                                                                      transactions: const [
                                                                        {
                                                                          "amount":
                                                                              {
                                                                            "total":
                                                                                '20.00',
                                                                            "currency":
                                                                                "EUR",
                                                                            "details":
                                                                                {
                                                                              "subtotal": '20.00',
                                                                              "shipping": '0',
                                                                              "shipping_discount": 0
                                                                            }
                                                                          },
                                                                          "description":
                                                                              "The payment transaction description.",
                                                                          "item_list":
                                                                              {
                                                                            "items":
                                                                                [
                                                                              {
                                                                                "name": "Generare plângere",
                                                                                "quantity": 1,
                                                                                "price": '20.00',
                                                                                "currency": "EUR"
                                                                              }
                                                                            ],
                                                                            "shipping_address":
                                                                                {
                                                                              "recipient_name": "e-Lawyer",
                                                                              "line1": "Timis County",
                                                                              "line2": "",
                                                                              "city": "Timisoara",
                                                                              "country_code": "RO",
                                                                              "postal_code": "0000",
                                                                              "phone": "+00000000",
                                                                              "state": "Timis"
                                                                            },
                                                                          }
                                                                        }
                                                                      ],
                                                                      note:
                                                                          "Contact us for any questions on your order.",
                                                                      onSuccess:
                                                                          (Map
                                                                              params) async {
                                                                        print(
                                                                            "onSuccess: $params");
                                                                        payment =
                                                                            params['status'];

                                                                        setState(
                                                                            () {
                                                                          _isLoading =
                                                                              false;
                                                                          payed =
                                                                              true;
                                                                        });

                                                                        if (payment ==
                                                                            'success') {
                                                                          APIService.patchComplaint(
                                                                              "Pay",
                                                                              "DA",
                                                                              complaintIDListNotPaid[index]);
                                                                        }
                                                                        payment =
                                                                            '';
                                                                      },
                                                                      onError:
                                                                          (error) {
                                                                        print(
                                                                            "onError: $error");
                                                                      },
                                                                      onCancel:
                                                                          (params) {
                                                                        print(
                                                                            'cancelled: $params');
                                                                      }),
                                                            ),
                                                          );
                                                        } else {
                                                          String payment = '';
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  UsePaypal(
                                                                      sandboxMode:
                                                                          true,
                                                                      clientId:
                                                                          "AX9I_PCcYBUJ2MHO--rQHoauuxG3pwld6nEBE_Z9hfGPRAkfUdGEoIwDJKXdA_7nPOVwjoXQq_GGLAbf",
                                                                      secretKey:
                                                                          "ENPjmJl67JVAz8dATjkRCEdz1W3EV82zhbmXYzfs8-ERZDzyHwezkJXBJXPoZLHA4xUbO0BvauQdcouk",
                                                                      returnURL:
                                                                          "https://samplesite.com/return",
                                                                      cancelURL:
                                                                          "https://samplesite.com/cancel",
                                                                      transactions: const [
                                                                        {
                                                                          "amount":
                                                                              {
                                                                            "total":
                                                                                '100.00',
                                                                            "currency":
                                                                                "EUR",
                                                                            "details":
                                                                                {
                                                                              "subtotal": '100.00',
                                                                              "shipping": '0',
                                                                              "shipping_discount": 0
                                                                            }
                                                                          },
                                                                          "description":
                                                                              "The payment transaction description.",
                                                                          "item_list":
                                                                              {
                                                                            "items":
                                                                                [
                                                                              {
                                                                                "name": "Generare plângere",
                                                                                "quantity": 1,
                                                                                "price": '100.00',
                                                                                "currency": "EUR"
                                                                              }
                                                                            ],
                                                                            "shipping_address":
                                                                                {
                                                                              "recipient_name": "e-Lawyer",
                                                                              "line1": "Timis County",
                                                                              "line2": "",
                                                                              "city": "Timisoara",
                                                                              "country_code": "RO",
                                                                              "postal_code": "0000",
                                                                              "phone": "+00000000",
                                                                              "state": "Timis"
                                                                            },
                                                                          }
                                                                        }
                                                                      ],
                                                                      note:
                                                                          "Contact us for any questions on your order.",
                                                                      onSuccess:
                                                                          (Map
                                                                              params) async {
                                                                        print(
                                                                            "onSuccess: $params");
                                                                        payment =
                                                                            params['status'];
                                                                        setState(
                                                                            () {
                                                                          _isLoading =
                                                                              false;
                                                                          payed =
                                                                              true;
                                                                        });
                                                                        if (payment ==
                                                                            'success') {
                                                                          APIService.patchComplaint(
                                                                              "Pay",
                                                                              "DA",
                                                                              complaintIDListNotPaid[index]);
                                                                        }
                                                                        payment =
                                                                            '';
                                                                      },
                                                                      onError:
                                                                          (error) {
                                                                        print(
                                                                            "onError: $error");
                                                                      },
                                                                      onCancel:
                                                                          (params) {
                                                                        print(
                                                                            'cancelled: $params');
                                                                      }),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      child: Text('Plată',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    113,
                                                                    149,
                                                                    177),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            shadows: [
                                                              Shadow(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                offset: Offset(
                                                                    1, 1),
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
                          })
                    else
                      Padding(
                          padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Text("Nu există nicio cerere de plată",
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
                        child: Text("Plângerile plătite: ",
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
                    if (complaintTitleListPaid.length != 0)
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: jsonSizePaid,
                          itemBuilder: (context, index) {
                            return complaintInterfacePaid(
                              complaintTitle: complaintTitleListPaid[index],
                              complaintStatus: complaintStatusListPaid[index],
                              judgePresence: complaintJudgeListPaid[index],
                              complaintID: complaintIDListPaid[index],
                            );
                          })
                    else
                      Padding(
                          padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Text("Nu există nicio plângere plătită",
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
                  ]))),
          floatingActionButton: isFabVisible
              ? FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CreateComplaint(title: 'New Complaint');
                    }));
                  },
                  label: const Text(
                    'Plângere nouă',
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(255, 0, 0, 0),
                          offset: Offset(1, 1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  icon: const Icon(Icons.add),
                  backgroundColor: Color.fromARGB(255, 0, 0, 0),
                )
              : null,
        ),
        replacement: Scaffold(
            backgroundColor: Color.fromARGB(23, 239, 232, 232),
            body: ListView(children: [
              if (payed == false)
                SizedBox(
                  height: 300,
                ),
              if (payed == false)
                Center(
                  child: CircularProgressIndicator(),
                ),
              if (payed == true)
                SizedBox(
                  height: 300,
                ),
              if (payed == true)
                Center(
                    child: Text("Plată finalizată cu succes!",
                        style: TextStyle(
                          fontFamily: 'HPSimplified',
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 0, 0, 0),
                              offset: Offset(1, 1),
                              blurRadius: 4,
                            ),
                          ],
                        ))),
              if (payed == true)
                SizedBox(
                  height: 20,
                ),
              if (payed == true)
                Center(
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
                            minimumSize: Size(200, 50),
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NavBar()),
                            );
                          },
                          child: Text(
                            'Continuă',
                            style: TextStyle(
                              fontFamily: 'HPSimplified',
                              fontSize: 17,
                              color: Color.fromARGB(255, 255, 255, 255),
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
                        ))),
            ])));
  }
}

class complaintInterfacePaid extends StatelessWidget {
  final String complaintTitle;
  final String complaintStatus;
  final String judgePresence;
  final String complaintID;

  const complaintInterfacePaid(
      {Key? key,
      required this.complaintTitle,
      required this.complaintStatus,
      required this.judgePresence,
      required this.complaintID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height;
    if (complaintTitle.length > 42) {
      height = 330.0;
    } else {
      height = 310.0;
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
          height: height,
          width: 500,
          decoration: BoxDecoration(
            color: Color.fromARGB(33, 239, 232, 232),
            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      Text("Titlul plângerii:",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Color.fromARGB(255, 0, 0, 0),
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
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      Flexible(
                          child: Text(
                        complaintTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 0, 0, 0),
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
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      Text("Statusul plângerii:",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Color.fromARGB(255, 0, 0, 0),
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
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      if (complaintStatus == 'Aprobată')
                        Text(
                          complaintStatus,
                          style: TextStyle(
                            color: Color.fromARGB(255, 25, 116, 40),
                            fontSize: 18,
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
                      if (complaintStatus == 'În așteptare')
                        Text(
                          complaintStatus,
                          style: TextStyle(
                            color: Color.fromARGB(255, 113, 149, 177),
                            fontSize: 18,
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
                      if (complaintStatus == 'Respinsă')
                        Text(
                          complaintStatus,
                          style: TextStyle(
                            color: Color.fromARGB(255, 238, 38, 38),
                            fontSize: 18,
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
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      Text("Tipul cererii:",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Color.fromARGB(255, 0, 0, 0),
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
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      if (judgePresence == 'NU')
                        Text(
                          "Fără reprezentare în instanță",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18,
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
                      if (judgePresence == 'DA')
                        Text(
                          "Cu reprezentare în instanță",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18,
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
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              if (complaintStatus == 'În așteptare' ||
                  complaintStatus == 'Respinsă')
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      Container(
                        width: 312,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 56, 58, 60),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.7),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            globals.complaintID = complaintID;
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return EditComplaint(title: 'Edit Complaint');
                            }));
                          },
                          child: Text('Editare',
                              style: TextStyle(
                                color: Color.fromARGB(255, 113, 149, 177),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    offset: Offset(1, 1),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              textScaleFactor: 1.0),
                        ),
                      ),
                    ],
                  ),
                ),
              if (complaintStatus == 'Aprobată')
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      Container(
                        width: 312,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 56, 58, 60),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.7),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (await Permission.storage.request().isGranted) {
                              CreatePDF().generatePDF(complaintID);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialogGenerated(context),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialogGeneratedDenied(context),
                              );
                            }
                          },
                          child: Text('Descarcă PDF',
                              style: TextStyle(
                                color: Color.fromARGB(255, 113, 149, 177),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    offset: Offset(1, 1),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              textScaleFactor: 1.0),
                        ),
                      ),
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
  }
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
