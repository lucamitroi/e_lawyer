import 'dart:convert';

import 'package:first_app/NavBarLawyer.dart';
import 'package:first_app/services/api_service.dart';
import 'package:first_app/services/remote_services.dart';
import 'package:flutter/material.dart';
import 'NavBar.dart';
import 'models/user_model.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';
import 'globals.dart' as globals;

void main() {
  runApp(MaterialApp(
    home: EditComplaint(),
  ));
}

class EditComplaint extends StatefulWidget {
  EditComplaint({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  State<EditComplaint> createState() => _EditComplaintState();
}

class _EditComplaintState extends State<EditComplaint> {
  String userData = '';
  String userRole = '';
  String complaintData = '';
  String complaint_Name = '';
  String complaint_Surname = '';
  String complaint_Phone = '';
  String complaint_Email = '';
  String complaint_CIseries = '';
  String complaint_CInr = '';
  String complaint_CNP = '';
  String complaint_City = '';
  String complaint_County = '';
  String complaint_Street = '';
  String complaint_Bl = '';
  String complaint_Sc = '';
  String complaint_Ap = '';
  String complaint_PoliceName = '';
  String complaint_PoliceSurname = '';
  String complaint_PoliceRole = '';
  String complaint_PoliceInstitution = '';
  String complaint_EventPlace = '';
  String complaint_VerbalProcess = '';
  String complaint_SeriesVerbalProcess = '';
  String complaint_NumberVerbalProcess = '';
  String complaint_DateVerbalProcess = '';
  String complaint_HandingOutVerbalProcess = '';
  String complaint_DateOfHandingOutVerbalProcess = '';
  String complaint_DateOfEvent = '';
  String complaint_PayTheFine = '';
  String complaint_Options = '';
  String complaint_DescriptionOfTheEventInVerbalProcess = '';
  String complaint_DescriptionOfTheEventInPersonalOpinion = '';
  String complaint_LawNumberEvent = '';
  String complaint_LawParagraphEvent = '';
  String complaint_LawRuleEvent = '';
  String complaint_LawNumberPay = '';
  String complaint_LawParagraphPay = '';
  String complaint_LawRulePay = '';
  String complaint_Witnesses = '';
  String complaint_WitnessesData = '';
  String complaint_payTheFineSum = '';
  String complaint_Judge = '';
  String complaint_Lawyer = '';
  String complaint_Title = '';
  String complaint_Status = '';
  String complaint_Observations = '';
  String complaint_Pay = '';
  String complaint_PoliceAdr = '';

  TextEditingController dateController_verbal_process = TextEditingController();
  TextEditingController dateController_handover = TextEditingController();
  TextEditingController dateController_crime = TextEditingController();
  List<UserModel>? _userModel;
  Set<String> listCounty_temp = {};
  List<String> listCounty = [];
  Set<String> listName_temp = {};
  List<String> listName = [];
  Set<String> listCity_temp = {};
  List<String> listCity = [];
  Set<String> listStreet_temp = {};
  List<String> listStreet = [];
  List<String> solicitateList = [
    "Doresc anularea amenzii pentru că sunt nevinovat iar amenda este abuzivă. Am documente şi martori care să ateste nevinovaţia mea",
    "Doresc preschimbarea amenzii în avertisment pentru că deşi sunt vinovat, sunt la prima abatere contravenţională.",
    "Doresc reducerea cuantumului amenzii pentru că amenda primită reprezintă maximul din cât mi se putea aplica sau este disproporţionată în raport de veniturile mele"
  ];
  List<String> possessionList = ['PRIN ÎNMÂNARE LA FAȚA LOCULUI', 'PRIN POȘTĂ'];
  List<String> defendList = [
    "Adeverinţă de venit/talon de pensie",
    "Adeverinţă medicală",
    "Alte documente"
  ];
  List<String> presenceList = [
    "Doresc să particip la şedinţele de judecată",
    "Doresc judecarea cererii de chemare în judecată în lipsa mea",
  ];
  String? selectval_county;
  String? selectval_city;
  String? selectval_name;
  String? selectval_street;
  String? selectval_possesion;
  String? selectval_solicitate;
  String? selectval_defend;
  String? selectval_presence;
  bool isApiCallProcess = false;
  var police_institution = '';
  var isLoaded = false;
  var borderColor_city = Color.fromARGB(62, 48, 48, 49);
  var borderColor_street = Color.fromARGB(62, 48, 48, 49);
  var borderColor_city_alt = Color.fromARGB(62, 48, 48, 49);
  var readOnly_City = true;
  var readOnly_Street = true;
  var borderColor_name = Color.fromARGB(62, 48, 48, 49);
  var borderColor_street_alt = Color.fromARGB(62, 48, 48, 49);
  var borderColor_name_alt = Color.fromARGB(62, 48, 48, 49);
  var readOnly_Name = true;
  var city_text_color = Color.fromARGB(23, 239, 232, 232);
  var alt_option_city_text_color = Color.fromARGB(23, 239, 232, 232);
  var alt_option_name_text_color = Color.fromARGB(23, 239, 232, 232);
  var alt_option_street_text_color = Color.fromARGB(23, 239, 232, 232);
  var name_text_color = Color.fromARGB(23, 239, 232, 232);
  var street_text_color = Color.fromARGB(23, 239, 232, 232);

  late var name_controller = TextEditingController(text: complaint_Name);
  late var surname_controller = TextEditingController(text: complaint_Surname);
  late var phone_controller = TextEditingController(text: complaint_Phone);
  late var email_controller = TextEditingController(text: complaint_Email);
  late var CIseries_controller = TextEditingController();
  late var CInr_controller = TextEditingController();
  late var CNP_controller = TextEditingController();
  late var City_controller = TextEditingController();
  late var County_controller = TextEditingController();
  late var Street_controller = TextEditingController();
  late var Bl_controller = TextEditingController();
  late var payTheFineSum_controller = TextEditingController();
  late var Sc_controller = TextEditingController();
  late var Ap_controller = TextEditingController();
  late var PoliceAdr_controller = TextEditingController();
  late var police_name_controller =
      TextEditingController(text: complaint_PoliceName);
  late var police_surname_controller =
      TextEditingController(text: complaint_PoliceSurname);
  late var police_quality_controller =
      TextEditingController(text: complaint_PoliceRole);
  late var police_institution_controller =
      TextEditingController(text: complaint_PoliceInstitution);
  late var event_place_controller =
      TextEditingController(text: complaint_EventPlace);
  String verbal_process_answer = 'NU';
  late var series_verbal_process_controller =
      TextEditingController(text: complaint_SeriesVerbalProcess);
  late var number_verbal_process_controller =
      TextEditingController(text: complaint_NumberVerbalProcess);
  late var verbal_process_date_text_controller =
      TextEditingController(text: complaint_DateVerbalProcess);
  late var date_of_handing_out_text_controller =
      TextEditingController(text: complaint_DateOfHandingOutVerbalProcess);
  late var date_of_event_text_controller =
      TextEditingController(text: complaint_DateOfEvent);
  String paid_answer = 'NU';
  late var description_of_event_verbal_controller = TextEditingController(
      text: complaint_DescriptionOfTheEventInVerbalProcess);
  late var description_of_event_person_controller = TextEditingController(
      text: complaint_DescriptionOfTheEventInPersonalOpinion);
  late var law_number_event_controller =
      TextEditingController(text: complaint_LawNumberEvent);
  late var law_paragraph_event_controller =
      TextEditingController(text: complaint_LawParagraphEvent);
  late var law_rule_event_controller =
      TextEditingController(text: complaint_LawRuleEvent);
  late var law_number_pay_controller =
      TextEditingController(text: complaint_LawNumberPay);
  late var law_paragraph_pay_controller =
      TextEditingController(text: complaint_LawParagraphEvent);
  late var law_rule_pay_controller =
      TextEditingController(text: complaint_LawRuleEvent);
  late var police_inst_city_controller = TextEditingController();
  late var police_inst_name_controller = TextEditingController();
  late var police_inst_street_controller = TextEditingController();
  String witness_answer = 'NU';
  String lawyer_answer = 'NU';
  late var WitnessesData_controller = TextEditingController();
  late var title_controller = TextEditingController(text: complaint_Title);
  late var observation_controller =
      TextEditingController(text: complaint_Observations);

  @override
  void initState() {
    dateController_verbal_process.text = "";
    dateController_handover.text = "";
    dateController_crime.text = "";
    super.initState();
    getData();
  }

  void handleAnswerChanged_verbal_process_answer(String answer) {
    setState(() {
      verbal_process_answer = answer;
    });
  }

  void handleAnswerChanged_paid_answer(String answer) {
    setState(() {
      paid_answer = answer;
    });
  }

  void handleAnswerChanged_witness_answer(String answer) {
    setState(() {
      witness_answer = answer;
    });
  }

  void handleAnswerChanged_lawyer_answer(String answer) {
    setState(() {
      lawyer_answer = answer;
    });
  }

  getData() async {
    userData = await APIService.getUserProfile();
    Map<String, dynamic> jsonMapRole = await json.decode(userData);
    userRole = await jsonMapRole['Role'];
    _userModel = await RemoteService().getPost();
    complaintData = await APIService.getComplaintDetails(globals.complaintID);
    Map<String, dynamic> jsonMap = await json.decode(complaintData);
    complaint_Name = await jsonMap['Name'];
    complaint_Surname = await jsonMap['Surname'];
    complaint_Phone = await jsonMap['Phone'];
    complaint_Email = await jsonMap['Email'];
    complaint_CIseries = await jsonMap['CIseries'];
    complaint_CInr = await jsonMap['CInr'];
    complaint_CNP = await jsonMap['CNP'];
    complaint_City = await jsonMap['City'];
    complaint_County = await jsonMap['County'];
    complaint_Street = await jsonMap['Street'];
    complaint_Bl = await jsonMap['Bl'];
    complaint_Sc = await jsonMap['Sc'];
    complaint_Ap = await jsonMap['Ap'];
    complaint_PoliceName = await jsonMap['PoliceName'];
    complaint_PoliceSurname = await jsonMap['PoliceSurname'];
    complaint_PoliceInstitution = await jsonMap['PoliceInstitution'];
    complaint_PoliceAdr = await jsonMap['PoliceAdr'];
    complaint_EventPlace = await jsonMap['EventPlace'];
    complaint_VerbalProcess = await jsonMap['VerbalProcess'];
    complaint_SeriesVerbalProcess = await jsonMap['SeriesVerbalProcess'];
    complaint_NumberVerbalProcess = await jsonMap['NumberVerbalProcess'];
    complaint_DateVerbalProcess = await jsonMap['DateVerbalProcess'];
    complaint_HandingOutVerbalProcess =
        await jsonMap['HandingOutVerbalProcess'];
    complaint_DateOfHandingOutVerbalProcess =
        await jsonMap['DateOfHandingOutVerbalProcess'];
    complaint_DateOfEvent = await jsonMap['DateOfEvent'];
    complaint_PayTheFine = await jsonMap['PayTheFine'];
    complaint_payTheFineSum = await jsonMap['PayTheFineSum'];
    complaint_Options = await jsonMap['Options'];
    complaint_DescriptionOfTheEventInVerbalProcess =
        await jsonMap['DescriptionOfTheEventInVerbalProcess'];
    complaint_DescriptionOfTheEventInPersonalOpinion =
        await jsonMap['DescriptionOfTheEventInPersonalOpinion'];
    complaint_LawNumberEvent = await jsonMap['LawNumberEvent'];
    complaint_LawParagraphEvent = await jsonMap['LawParagraphEvent'];
    complaint_LawRuleEvent = await jsonMap['LawRuleEvent'];
    complaint_LawNumberPay = await jsonMap['LawNumberPay'];
    complaint_LawParagraphPay = await jsonMap['LawParagraphPay'];
    complaint_LawRulePay = await jsonMap['LawRulePay'];
    complaint_Witnesses = await jsonMap['Witnesses'];
    complaint_WitnessesData = await jsonMap['WitnessesData'];
    complaint_Judge = await jsonMap['Judge'];
    complaint_Lawyer = await jsonMap['Lawyer'];
    complaint_Title = await jsonMap['Title'];
    complaint_Status = await jsonMap['Status'];
    complaint_Observations = await jsonMap['Observations'];
    complaint_Pay = await jsonMap['Pay'];

    if (_userModel != null) {
      setState(() {
        isLoaded = true;
        for (int i = 0; i < _userModel!.length; i++) {
          listCounty_temp.add(_userModel![i].county);
        }
        listCounty = listCounty_temp.toList();
        listCounty = listCounty..sort();

        name_controller = TextEditingController(text: complaint_Name);
        surname_controller = TextEditingController(text: complaint_Surname);
        phone_controller = TextEditingController(text: complaint_Phone);
        email_controller = TextEditingController(text: complaint_Email);
        CIseries_controller = TextEditingController(text: complaint_CIseries);
        CInr_controller = TextEditingController(text: complaint_CInr);
        CNP_controller = TextEditingController(text: complaint_CNP);
        City_controller = TextEditingController(text: complaint_City);
        County_controller = TextEditingController(text: complaint_County);
        Street_controller = TextEditingController(text: complaint_Street);
        Bl_controller = TextEditingController(text: complaint_Bl);
        Sc_controller = TextEditingController(text: complaint_Sc);
        Ap_controller = TextEditingController(text: complaint_Ap);
        police_name_controller =
            TextEditingController(text: complaint_PoliceName);
        police_surname_controller =
            TextEditingController(text: complaint_PoliceSurname);
        police_quality_controller =
            TextEditingController(text: complaint_PoliceRole);
        police_institution_controller =
            TextEditingController(text: complaint_PoliceInstitution);
        PoliceAdr_controller = TextEditingController(text: complaint_PoliceAdr);
        event_place_controller =
            TextEditingController(text: complaint_EventPlace);
        series_verbal_process_controller =
            TextEditingController(text: complaint_SeriesVerbalProcess);
        number_verbal_process_controller =
            TextEditingController(text: complaint_NumberVerbalProcess);
        verbal_process_date_text_controller =
            TextEditingController(text: complaint_DateVerbalProcess);
        date_of_handing_out_text_controller = TextEditingController(
            text: complaint_DateOfHandingOutVerbalProcess);
        date_of_event_text_controller =
            TextEditingController(text: complaint_DateOfEvent);
        description_of_event_verbal_controller = TextEditingController(
            text: complaint_DescriptionOfTheEventInVerbalProcess);
        payTheFineSum_controller =
            TextEditingController(text: complaint_payTheFineSum);
        description_of_event_person_controller = TextEditingController(
            text: complaint_DescriptionOfTheEventInPersonalOpinion);
        law_number_event_controller =
            TextEditingController(text: complaint_LawNumberEvent);
        law_paragraph_event_controller =
            TextEditingController(text: complaint_LawParagraphEvent);
        law_rule_event_controller =
            TextEditingController(text: complaint_LawRuleEvent);
        law_number_pay_controller =
            TextEditingController(text: complaint_LawNumberPay);
        law_paragraph_pay_controller =
            TextEditingController(text: complaint_LawParagraphPay);
        law_rule_pay_controller =
            TextEditingController(text: complaint_LawRulePay);
        title_controller = TextEditingController(text: complaint_Title);
        observation_controller =
            TextEditingController(text: complaint_Observations);
        selectval_possesion = complaint_HandingOutVerbalProcess;
        selectval_solicitate = complaint_Options;
        selectval_presence = complaint_Judge;
        verbal_process_answer = complaint_VerbalProcess;
        paid_answer = complaint_PayTheFine;
        witness_answer = complaint_Witnesses;
        WitnessesData_controller =
            TextEditingController(text: complaint_WitnessesData);
        lawyer_answer = complaint_Lawyer;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromARGB(23, 239, 232, 232),
        body: Visibility(
            visible: isLoaded,
            child: ListView(children: [
              Column(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: CloseButton(
                        color: Color.fromARGB(255, 255, 255, 255),
                        onPressed: () {
                          if (userRole == 'client') {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NavBar(title: 'Home');
                            }));
                          } else if (userRole == 'avocat') {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NavBarLawyer(title: 'Home');
                            }));
                          }
                        },
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(children: [
                        Text(
                            'Vă rugăm să competaţi datele\npersoanei sancţionate prin\nprocesul verbal de contravenţie:',
                            style: TextStyle(
                              fontFamily: 'HPSimplified',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            textScaleFactor: 1.0),
                      ])),
                  SizedBox(
                    height: 20,
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
                            width: 100,
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
                      child: Row(children: [
                        Container(
                            height: 50,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(43, 239, 232, 232),
                              border: Border.all(
                                  color: Color.fromARGB(81, 85, 126, 255),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.8),
                                  offset: Offset(5, 5),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: TextField(
                                controller: name_controller,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  shadows: [
                                    Shadow(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      offset: Offset(2, 2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ))),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            height: 50,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(43, 239, 232, 232),
                              border: Border.all(
                                  color: Color.fromARGB(81, 85, 126, 255),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.8),
                                  offset: Offset(5, 5),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: TextField(
                                controller: surname_controller,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  shadows: [
                                    Shadow(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      offset: Offset(2, 2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ))),
                      ])),
                  SizedBox(height: 10),
                  wideField("Număr de telefon:", TextInputType.phone,
                      phone_controller),
                  SizedBox(height: 10),
                  wideField("Adresă de mail:", TextInputType.emailAddress,
                      email_controller),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(
                        children: [
                          Text(
                            'Seria CI:',
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
                            width: 115,
                          ),
                          Text(
                            'Număr CI:',
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
                  SizedBox(height: 10),
                  Padding(
                      padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(children: [
                        Container(
                            height: 50,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(43, 239, 232, 232),
                              border: Border.all(
                                  color: Color.fromARGB(81, 85, 126, 255),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.8),
                                  offset: Offset(5, 5),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: TextField(
                                controller: CIseries_controller,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  shadows: [
                                    Shadow(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      offset: Offset(2, 2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ))),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            height: 50,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(43, 239, 232, 232),
                              border: Border.all(
                                  color: Color.fromARGB(81, 85, 126, 255),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.8),
                                  offset: Offset(5, 5),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: TextField(
                                controller: CInr_controller,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  shadows: [
                                    Shadow(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      offset: Offset(2, 2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ))),
                      ])),
                  SizedBox(
                    height: 10,
                  ),
                  wideField("Cod numeric personal:", TextInputType.number,
                      CNP_controller),
                  SizedBox(
                    height: 10,
                  ),
                  wideField("Oraș:", TextInputType.text, City_controller),
                  SizedBox(
                    height: 10,
                  ),
                  wideField("Județ:", TextInputType.text, County_controller),
                  SizedBox(
                    height: 10,
                  ),
                  wideField("Stradă:", TextInputType.text, Street_controller),
                  SizedBox(
                    height: 10,
                  ),
                  wideField("Bloc:", TextInputType.text, Bl_controller),
                  SizedBox(
                    height: 10,
                  ),
                  wideField("Scară:", TextInputType.text, Sc_controller),
                  SizedBox(
                    height: 10,
                  ),
                  wideField("Apartament:", TextInputType.text, Ap_controller),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                      padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(children: [
                        Text(
                            'Vă rugăm să completaţi numele,\nprenumele şi instituţia din\ncare face parte agentul constatator :',
                            style: TextStyle(
                              fontFamily: 'HPSimplified',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            textScaleFactor: 1.0),
                      ])),
                  SizedBox(height: 20),
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
                            width: 100,
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
                      child: Row(children: [
                        Container(
                            height: 50,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(43, 239, 232, 232),
                              border: Border.all(
                                  color: Color.fromARGB(81, 85, 126, 255),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.8),
                                  offset: Offset(5, 5),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: TextField(
                                controller: police_name_controller,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  shadows: [
                                    Shadow(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      offset: Offset(2, 2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ))),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            height: 50,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(43, 239, 232, 232),
                              border: Border.all(
                                  color: Color.fromARGB(81, 85, 126, 255),
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.8),
                                  offset: Offset(5, 5),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: TextField(
                                controller: police_surname_controller,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  shadows: [
                                    Shadow(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      offset: Offset(2, 2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ))),
                      ])),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                  ),
                  wideField_bigText(
                      'Instituția din care face parte\nagentul constatator:',
                      TextInputType.text,
                      50,
                      police_institution_controller),
                  SizedBox(
                    height: 50,
                  ),
                  wideField_bigText('Adresa instituției de poliție:',
                      TextInputType.text, 100, PoliceAdr_controller),
                  SizedBox(height: 50),
                  wideField_bigText("Locul săvârșirii contravenției:",
                      TextInputType.text, 50, event_place_controller),
                  SizedBox(
                    height: 50,
                  ),
                  yesNoField(
                    text:
                        'Ați fost de acord să semnați\nprocesul verba de contravenţie?',
                    onAnswerChanged: handleAnswerChanged_verbal_process_answer,
                    initialChoice: complaint_VerbalProcess,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                      padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(children: [
                        Text(
                            'Vă rugăm să completaţi seria, numărul\nşi data întocmirii procesului verbal:',
                            style: TextStyle(
                              fontFamily: 'HPSimplified',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            textScaleFactor: 1.0),
                      ])),
                  SizedBox(height: 20),
                  wideField('Seria:', TextInputType.text,
                      series_verbal_process_controller),
                  SizedBox(
                    height: 10,
                  ),
                  wideField("Numărul:", TextInputType.number,
                      number_verbal_process_controller),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(children: [
                        Text(
                          'Data:',
                          style: TextStyle(
                            fontFamily: 'HPSimplified',
                            fontSize: 18,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        )
                      ])),
                  SizedBox(
                    height: 10,
                  ),
                  dateField(dateController_verbal_process,
                      verbal_process_date_text_controller),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                      padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(children: [
                        Text(
                            'Cum aţi intrat în posesia procesului\nverbal de contravenţie?',
                            style: TextStyle(
                              fontFamily: 'HPSimplified',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            textScaleFactor: 1.0),
                      ])),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(children: [
                        Container(
                          height: 50,
                          width: 325,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(43, 239, 232, 232),
                            border: Border.all(
                                color: Color.fromARGB(81, 85, 126, 255),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.8),
                                offset: Offset(5, 5),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                            value: selectval_possesion,
                            menuMaxHeight: 300.0,
                            isExpanded: true,
                            dropdownColor: Color.fromARGB(255, 43, 43, 40),
                            onChanged: (value) {
                              setState(() {
                                selectval_possesion = value.toString();
                              });
                            },
                            items: possessionList.map((itemone) {
                              return DropdownMenuItem(
                                  value: itemone,
                                  child: Center(
                                      child: Text(itemone,
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                            shadows: [
                                              Shadow(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                offset: Offset(2, 2),
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ))));
                            }).toList(),
                          )),
                        )
                      ])),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                      padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(children: [
                        Text(
                            'Data înmânării / comunicării\nprocesului verbal de contravenţie:',
                            style: TextStyle(
                              fontFamily: 'HPSimplified',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            textScaleFactor: 1.0),
                      ])),
                  SizedBox(
                    height: 10,
                  ),
                  dateField(dateController_handover,
                      date_of_handing_out_text_controller),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                      padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(children: [
                        Text('Data săvârşirii faptei:',
                            style: TextStyle(
                              fontFamily: 'HPSimplified',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            textScaleFactor: 1.0),
                      ])),
                  SizedBox(
                    height: 10,
                  ),
                  dateField(
                      dateController_crime, date_of_event_text_controller),
                  SizedBox(
                    height: 50,
                  ),
                  yesNoField(
                    text: 'Aţi plătit amenda instituită prin\nprocesul verbal?',
                    onAnswerChanged: handleAnswerChanged_paid_answer,
                    initialChoice: complaint_PayTheFine,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  wideField_bigText(
                      "Vă rugăm să introduceți valoarea\namenzii:",
                      TextInputType.number,
                      50,
                      payTheFineSum_controller),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                      padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(children: [
                        Text(
                            'Care dintre opţiunile de mai jos le\nsolicitaţi instanţei de judecată?',
                            style: TextStyle(
                              fontFamily: 'HPSimplified',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            textScaleFactor: 1.0),
                      ])),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(children: [
                        Container(
                          height: 110,
                          width: 325,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(43, 239, 232, 232),
                            border: Border.all(
                                color: Color.fromARGB(81, 85, 126, 255),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.8),
                                offset: Offset(5, 5),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                            value: selectval_solicitate,
                            isExpanded: true,
                            itemHeight: 100,
                            dropdownColor: Color.fromARGB(255, 43, 43, 40),
                            onChanged: (value) {
                              setState(() {
                                selectval_solicitate = value.toString();
                              });
                            },
                            items: solicitateList.map((itemone) {
                              return DropdownMenuItem(
                                  value: itemone,
                                  child: Center(
                                      child: Padding(
                                          padding: new EdgeInsets.fromLTRB(
                                              5, 0, 0, 0),
                                          child: Text(itemone,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300,
                                                shadows: [
                                                  Shadow(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    offset: Offset(2, 2),
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              )))));
                            }).toList(),
                          )),
                        )
                      ])),
                  SizedBox(
                    height: 50,
                  ),
                  wideField_bigText(
                      "Vă rugăm să prezentaţi situaţia\ndescrisă din procesul verbal:",
                      TextInputType.text,
                      300,
                      description_of_event_verbal_controller),
                  SizedBox(
                    height: 50,
                  ),
                  wideField_bigText(
                      "Vă rugăm să prezentaţi situaţia de\nfapt din punctul dumneavoastră\nde vedere, mai ales dacă e diferită\nde de cea prezentată de agentul\nconstatator:",
                      TextInputType.text,
                      300,
                      description_of_event_person_controller),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                      padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(children: [
                        Text(
                            'Vă rugăm să completaţi articolele\nşi norma legală din procesul\nverbal cu privire la fapta comisă:',
                            style: TextStyle(
                              fontFamily: 'HPSimplified',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            textScaleFactor: 1.0),
                      ])),
                  SizedBox(
                    height: 20,
                  ),
                  wideField("Articolul:", TextInputType.text,
                      law_number_event_controller),
                  SizedBox(
                    height: 10,
                  ),
                  wideField("Aliniatul:", TextInputType.text,
                      law_paragraph_event_controller),
                  SizedBox(
                    height: 10,
                  ),
                  wideField(
                      "Norma legală în care sunt prevăzute\nsancţiunile :",
                      TextInputType.text,
                      law_rule_event_controller),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                      padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(children: [
                        Text(
                            'Vă rugăm să completaţi articolele\nşi norma legală din procesul verbal\ncu privire la sancţiunea aplicată:',
                            style: TextStyle(
                              fontFamily: 'HPSimplified',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            textScaleFactor: 1.0),
                      ])),
                  SizedBox(
                    height: 20,
                  ),
                  wideField("Articolul:", TextInputType.text,
                      law_number_pay_controller),
                  SizedBox(
                    height: 10,
                  ),
                  wideField("Aliniatul:", TextInputType.text,
                      law_paragraph_pay_controller),
                  SizedBox(
                    height: 10,
                  ),
                  wideField(
                      "Norma legală în care sunt prevăzute\nsancţiunile :",
                      TextInputType.text,
                      law_rule_pay_controller),
                  SizedBox(
                    height: 50,
                  ),
                  yesNoField(
                    text:
                        'Aveţi martori care să fie audiaţi de\ninstanţa de judecată şi care sunt\npregatiţi să vă probeze nevinovaţia?',
                    onAnswerChanged: handleAnswerChanged_witness_answer,
                    initialChoice: complaint_Witnesses,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  wideField_bigText(
                      "Enumerați detaliile despre martori\n(Nume, adresă și număr de telefon\ncu caracterul \" ; \" între martori. Dacă\nnu aveți martori introduceți\ncaracterul \" - \"):",
                      TextInputType.text,
                      300,
                      WitnessesData_controller),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                      padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(children: [
                        Text(
                            'Doriţi să vă prezentaţi la sedinţele\nde judecată sau doriţi judecarea\ncererii în lipsă?',
                            style: TextStyle(
                              fontFamily: 'HPSimplified',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            textScaleFactor: 1.0),
                      ])),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(children: [
                        Container(
                          height: 50,
                          width: 325,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(43, 239, 232, 232),
                            border: Border.all(
                                color: Color.fromARGB(81, 85, 126, 255),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.8),
                                offset: Offset(5, 5),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                            value: selectval_presence,
                            isExpanded: true,
                            dropdownColor: Color.fromARGB(255, 43, 43, 40),
                            onChanged: (value) {
                              setState(() {
                                selectval_presence = value.toString();
                              });
                            },
                            items: presenceList.map((itemone) {
                              return DropdownMenuItem(
                                  value: itemone,
                                  child: Center(
                                      child: Padding(
                                          padding: new EdgeInsets.fromLTRB(
                                              5, 0, 0, 0),
                                          child: Text(itemone,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300,
                                                shadows: [
                                                  Shadow(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    offset: Offset(2, 2),
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              )))));
                            }).toList(),
                          )),
                        )
                      ])),
                  SizedBox(
                    height: 50,
                  ),
                  if (complaint_Pay == 'NU')
                    yesNoField(
                      text:
                          "Doriţi să fiţi asistat de un avocat în\nsala de judecată?",
                      onAnswerChanged: handleAnswerChanged_lawyer_answer,
                      initialChoice: complaint_Lawyer,
                    ),
                  if (complaint_Pay == 'NU')
                    SizedBox(
                      height: 50,
                    ),
                  wideField_bigText(
                      "Adăugați un titlu sugestiv pentru\nidentificare:",
                      TextInputType.text,
                      50,
                      title_controller),
                  SizedBox(
                    height: 50,
                  ),
                  wideField_bigText("Observații suplimentare:",
                      TextInputType.text, 200, observation_controller),
                  SizedBox(
                    height: 30,
                  ),
                  if (complaint_Pay == 'NU')
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
                                backgroundColor:
                                    Color.fromARGB(81, 226, 24, 24),
                                minimumSize: Size(200, 50),
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildPopupDialogDelete(context),
                                );
                              },
                              child: Text(
                                'Ștergere',
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
                  if (complaint_Pay == 'NU')
                    SizedBox(
                      height: 20,
                    ),
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
                              APIService.patchComplaint("Name",
                                  name_controller.text, globals.complaintID);
                              APIService.patchComplaint("Surname",
                                  surname_controller.text, globals.complaintID);
                              APIService.patchComplaint("Phone",
                                  phone_controller.text, globals.complaintID);
                              APIService.patchComplaint("Email",
                                  email_controller.text, globals.complaintID);
                              APIService.patchComplaint(
                                  "CIseries",
                                  CIseries_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint("CInr",
                                  CInr_controller.text, globals.complaintID);
                              APIService.patchComplaint("CNP",
                                  CNP_controller.text, globals.complaintID);
                              APIService.patchComplaint("City",
                                  City_controller.text, globals.complaintID);
                              APIService.patchComplaint("County",
                                  County_controller.text, globals.complaintID);
                              APIService.patchComplaint("Street",
                                  Street_controller.text, globals.complaintID);
                              APIService.patchComplaint("Bl",
                                  Bl_controller.text, globals.complaintID);
                              APIService.patchComplaint("Sc",
                                  Sc_controller.text, globals.complaintID);
                              APIService.patchComplaint("Ap",
                                  Ap_controller.text, globals.complaintID);
                              APIService.patchComplaint(
                                  "PoliceName",
                                  police_name_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "PoliceSurname",
                                  police_surname_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "PoliceInstitution",
                                  police_institution_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "PoliceAdr",
                                  PoliceAdr_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "EventPlace",
                                  event_place_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint("VerbalProcess",
                                  verbal_process_answer, globals.complaintID);
                              APIService.patchComplaint(
                                  "SeriesVerbalProcess",
                                  series_verbal_process_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "NumberVerbalProcess",
                                  number_verbal_process_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "DateVerbalProcess",
                                  verbal_process_date_text_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "HandingOutVerbalProcess",
                                  selectval_possesion!,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "DateOfHandingOutVerbalProcess",
                                  date_of_handing_out_text_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "DateOfEvent",
                                  date_of_event_text_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint("PayTheFine",
                                  paid_answer, globals.complaintID);
                              APIService.patchComplaint("Options",
                                  selectval_solicitate!, globals.complaintID);
                              APIService.patchComplaint(
                                  "DescriptionOfTheEventInVerbalProcess",
                                  description_of_event_verbal_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "DescriptionOfTheEventInPersonalOpinion",
                                  description_of_event_person_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "LawNumberEvent",
                                  law_number_event_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "PayTheFineSum",
                                  payTheFineSum_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "LawParagraphEvent",
                                  law_paragraph_event_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "LawRuleEvent",
                                  law_rule_event_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "LawNumberPay",
                                  law_number_pay_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "LawParagraphPay",
                                  law_paragraph_pay_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint(
                                  "LawRulePay",
                                  law_rule_pay_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint("Witnesses",
                                  witness_answer, globals.complaintID);
                              APIService.patchComplaint(
                                  "WitnessesData",
                                  WitnessesData_controller.text,
                                  globals.complaintID);
                              APIService.patchComplaint("Judge",
                                  selectval_presence!, globals.complaintID);
                              APIService.patchComplaint(
                                  "Lawyer", lawyer_answer, globals.complaintID);

                              APIService.patchComplaint("Title",
                                  title_controller.text, globals.complaintID);
                              APIService.patchComplaint(
                                  "Observations",
                                  observation_controller.text,
                                  globals.complaintID);
                              if (complaint_Status == 'Respinsă') {
                                APIService.patchComplaint("Status",
                                    "În așteptare", globals.complaintID);
                              }
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialogConfirm(context, userRole),
                              );
                            },
                            child: Text(
                              'Modificare',
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
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ]),
            replacement: const Center(child: CircularProgressIndicator())));
  }

  Widget dateField(dateController, date_text) => Padding(
      padding: new EdgeInsets.fromLTRB(30, 0, 37, 0),
      child: Container(
          height: 50,
          width: 325,
          decoration: BoxDecoration(
            color: Color.fromARGB(43, 239, 232, 232),
            border:
                Border.all(color: Color.fromARGB(81, 85, 126, 255), width: 2.0),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.8),
                offset: Offset(5, 5),
                blurRadius: 15,
              ),
            ],
          ),
          child: TextField(
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 18,
              fontWeight: FontWeight.w300,
              shadows: [
                Shadow(
                  color: Color.fromARGB(255, 0, 0, 0),
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            controller: date_text,
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                print(pickedDate);
                String formattedDate =
                    DateFormat('dd-MM-yyy').format(pickedDate);
                print(formattedDate);

                setState(() {
                  date_text.text = formattedDate;
                });
              }
            },
          )));
}

class wideField extends StatelessWidget {
  late final String label;
  late final TextInputType textType;
  late final TextEditingController text_controller;

  wideField(String label, TextInputType textType,
      TextEditingController text_controller) {
    this.label = label;
    this.textType = textType;
    this.text_controller = text_controller;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'HPSimplified',
                  fontSize: 18,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Color.fromARGB(255, 0, 0, 0),
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 325,
                decoration: BoxDecoration(
                  color: Color.fromARGB(43, 239, 232, 232),
                  border: Border.all(
                      color: Color.fromARGB(81, 85, 126, 255), width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.8),
                      offset: Offset(5, 5),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: TextField(
                  controller: text_controller,
                  keyboardType: textType,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(255, 0, 0, 0),
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class wideField_bigText extends StatelessWidget {
  late final String label;
  late final TextInputType textType;
  late final double heightValue;
  late final TextEditingController text_controller;

  wideField_bigText(String label, TextInputType textType, double heightValue,
      TextEditingController text_controller) {
    this.label = label;
    this.textType = textType;
    this.heightValue = heightValue;
    this.text_controller = text_controller;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Row(children: [
              Text(label,
                  style: TextStyle(
                    fontFamily: 'HPSimplified',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(255, 0, 0, 0),
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  textScaleFactor: 1.0)
            ])),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            children: [
              Container(
                  height: heightValue,
                  width: 325,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(43, 239, 232, 232),
                    border: Border.all(
                        color: Color.fromARGB(81, 85, 126, 255), width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        offset: Offset(5, 5),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: TextField(
                      controller: text_controller,
                      keyboardType: textType,
                      maxLines: 100,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 0, 0, 0),
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      )))
            ],
          ),
        ),
      ],
    );
  }
}

class yesNoField extends StatefulWidget {
  final String text;
  final String initialChoice;
  final void Function(String) onAnswerChanged;

  const yesNoField(
      {required this.text,
      required this.onAnswerChanged,
      required this.initialChoice});

  @override
  _yesNoFieldState createState() => _yesNoFieldState();
}

class _yesNoFieldState extends State<yesNoField> {
  String answer = '';

  @override
  void initState() {
    super.initState();
    answer = widget.initialChoice;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  fontFamily: 'HPSimplified',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.fromLTRB(120, 0, 120, 0),
          child: Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: ToggleSwitch(
                    initialLabelIndex: answer == 'DA' ? 0 : 1,
                    totalSwitches: 2,
                    cornerRadius: 15.0,
                    activeBgColor: [Color.fromARGB(81, 85, 126, 255)],
                    inactiveBgColor: Color.fromARGB(23, 239, 232, 232),
                    customTextStyles: [
                      TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 0, 0, 0),
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 0, 0, 0),
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ],
                    labels: [
                      'DA',
                      'NU',
                    ],
                    onToggle: (index) {
                      setState(() {
                        answer = index == 0 ? 'DA' : 'NU';
                      });
                      widget.onAnswerChanged(answer);
                    },
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildPopupDialogConfirm(BuildContext context, String userRole) {
  return new AlertDialog(
    title: const Text('Succes'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Modificările au fost salvate cu succes."),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          if (userRole == 'client') {
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NavBar(title: 'Home');
            }));
          } else if (userRole == 'avocat') {
            Navigator.of(context).pop();
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

Widget _buildPopupDialogDelete(BuildContext context) {
  return new AlertDialog(
    title: const Text('Atenție!'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Plângerea va fi ștearsă iar acest lucru nu poate să fie anulat."),
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
          Navigator.of(context).pop();
          APIService.deleteComplaint(globals.complaintID);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NavBar(title: 'Home');
          }));
        },
        child: const Text('Șterge'),
      ),
    ],
  );
}
