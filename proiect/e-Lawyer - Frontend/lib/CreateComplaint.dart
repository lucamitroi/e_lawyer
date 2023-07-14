import 'package:first_app/services/api_service.dart';
import 'package:first_app/services/remote_services.dart';
import 'package:flutter/material.dart';
import 'NavBar.dart';
import 'models/complaint_request_model.dart';
import 'models/user_model.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';
import 'package:first_app/globals.dart' as globals;

void main() {
  runApp(MaterialApp(
    home: CreateComplaint(),
  ));
}

class CreateComplaint extends StatefulWidget {
  CreateComplaint({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  State<CreateComplaint> createState() => _CreateComplaintState();
}

class _CreateComplaintState extends State<CreateComplaint> {
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
  bool isChecked = false;
  var police_institution = '';
  var police_adr = '';
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

  //Controllers for  text fields and other fields
  late final name_controller = TextEditingController();
  late final surname_controller = TextEditingController();
  late final phone_controller = TextEditingController();
  late final email_controller = TextEditingController();
  late final CIseries_controller = TextEditingController();
  late final CInr_controller = TextEditingController();
  late final CNP_controller = TextEditingController();
  late final City_controller = TextEditingController();
  late final County_controller = TextEditingController();
  late final Street_controller = TextEditingController();
  late final Bl_controller = TextEditingController();
  late final Sc_controller = TextEditingController();
  late final Ap_controller = TextEditingController();
  late final address_controller = TextEditingController();
  late final police_name_controller = TextEditingController();
  late final police_surname_controller = TextEditingController();
  late final police_quality_controller = TextEditingController();
  late final event_place_controller = TextEditingController();
  String verbal_process_answer = 'NU';
  late final series_verbal_process_controller = TextEditingController();
  late final number_verbal_process_controller = TextEditingController();
  late final verbal_process_date_text_controller = TextEditingController();
  late final date_of_handing_out_text_controller = TextEditingController();
  late final date_of_event_text_controller = TextEditingController();
  String paid_answer = 'NU';
  late var payTheFineSum_controller = TextEditingController();
  late final description_of_event_verbal_controller = TextEditingController();
  late final description_of_event_person_controller = TextEditingController();
  late final law_number_event_controller = TextEditingController();
  late final law_paragraph_event_controller = TextEditingController();
  late final law_rule_event_controller = TextEditingController();
  late final law_number_pay_controller = TextEditingController();
  late final law_paragraph_pay_controller = TextEditingController();
  late final law_rule_pay_controller = TextEditingController();
  late final WitnessesData_controller = TextEditingController();
  late final police_inst_city_controller = TextEditingController();
  late final police_inst_name_controller = TextEditingController();
  late final police_inst_street_controller = TextEditingController();
  String witness_answer = 'NU';
  String lawyer_answer = 'NU';
  late final title_controller = TextEditingController();
  late final observation_controller = TextEditingController();

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

  submitComplaint() {
    complaint_request_model data = complaint_request_model(
        name: name_controller.text,
        surname: surname_controller.text,
        phone: phone_controller.text,
        email: email_controller.text,
        CIseries: CIseries_controller.text,
        CInr: CInr_controller.text,
        CNP: CNP_controller.text,
        City: City_controller.text,
        County: County_controller.text,
        Street: Street_controller.text,
        Bl: Bl_controller.text,
        Sc: Sc_controller.text,
        Ap: Ap_controller.text,
        policeName: police_name_controller.text,
        policeSurname: police_surname_controller.text,
        policeInstitution: police_institution,
        PoliceAdr: police_adr,
        eventPlace: event_place_controller.text,
        verbalProcess: verbal_process_answer,
        seriesVerbalProcess: series_verbal_process_controller.text,
        numberVerbalProcess: number_verbal_process_controller.text,
        dateVerbalProcess: verbal_process_date_text_controller.text,
        handingOutVerbalProcess: selectval_possesion,
        dateOfHandingOutVerbalProcess: date_of_handing_out_text_controller.text,
        dateOfEvent: date_of_event_text_controller.text,
        payTheFine: paid_answer,
        payTheFineSum: payTheFineSum_controller.text,
        options: selectval_solicitate,
        descriptionOfTheEventInVerbalProcess:
            description_of_event_verbal_controller.text,
        descriptionOfTheEventInPersonalOpinion:
            description_of_event_person_controller.text,
        lawNumberEvent: law_number_event_controller.text,
        lawParagraphEvent: law_paragraph_event_controller.text,
        lawRuleEvent: law_rule_event_controller.text,
        lawNumberPay: law_number_pay_controller.text,
        lawParagraphPay: law_paragraph_pay_controller.text,
        lawRulePay: law_rule_pay_controller.text,
        witnesses: witness_answer,
        WitnessesData: WitnessesData_controller.text,
        judge: selectval_presence,
        lawyer: lawyer_answer,
        Accept: true,
        pay: "NU",
        userID: globals.userID,
        title: title_controller.text,
        observations: observation_controller.text,
        status: "În așteptare");

    setState(() {
      isApiCallProcess = true;
    });

    APIService.postComplaint(data).then((response) {
      setState(() {
        isApiCallProcess = false;
      });
    });
  }

  getData() async {
    _userModel = await RemoteService().getPost();
    if (_userModel != null) {
      setState(() {
        isLoaded = true;
        for (int i = 0; i < _userModel!.length; i++) {
          listCounty_temp.add(_userModel![i].county);
        }
        listCounty = listCounty_temp.toList();
        listCounty = listCounty..sort();
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
            child: ListView(
              children: [
                Column(
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: CloseButton(
                          color: Color.fromARGB(255, 255, 255, 255),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NavBar(title: 'Home');
                            }));
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
                              'Vă rugăm să completaţi numele,\nprenumele, şi instituţia din\ncare face parte agentul constatator :',
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
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                        padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Row(children: [
                          Text(
                              'Instituția din care face parte\nagentul constatator:',
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
                        child: Row(children: [
                          Text(
                            'Județ:',
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
                        ])),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Row(children: [
                          Container(
                            height: 50,
                            width: 170,
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
                              value: selectval_county,
                              menuMaxHeight: 300.0,
                              isExpanded: true,
                              dropdownColor: Color.fromARGB(255, 43, 43, 40),
                              onChanged: (value) {
                                setState(() {
                                  borderColor_city =
                                      Color.fromARGB(81, 85, 126, 255);
                                  listCity_temp.clear();
                                  listCity.clear();
                                  listName_temp.clear();
                                  listName.clear();
                                  listStreet_temp.clear();
                                  listStreet.clear();
                                  alt_option_name_text_color =
                                      Color.fromARGB(23, 239, 232, 232);
                                  name_text_color =
                                      Color.fromARGB(23, 239, 232, 232);
                                  street_text_color =
                                      Color.fromARGB(23, 239, 232, 232);

                                  borderColor_street_alt =
                                      Color.fromARGB(23, 239, 232, 232);
                                  borderColor_street =
                                      Color.fromARGB(23, 239, 232, 232);
                                  borderColor_name_alt =
                                      Color.fromARGB(23, 239, 232, 232);
                                  readOnly_Name = true;
                                  borderColor_city_alt =
                                      Color.fromARGB(23, 239, 232, 232);
                                  borderColor_name =
                                      Color.fromARGB(23, 239, 232, 232);
                                  alt_option_city_text_color =
                                      Color.fromARGB(23, 239, 232, 232);
                                  alt_option_street_text_color =
                                      Color.fromARGB(23, 239, 232, 232);
                                  readOnly_City = true;
                                  readOnly_Street = true;
                                  readOnly_Name = true;
                                  selectval_city = null;
                                  selectval_county = value.toString();
                                  if (selectval_county != null) {
                                    city_text_color =
                                        Color.fromARGB(255, 255, 255, 255);
                                    for (int i = 0;
                                        i < _userModel!.length;
                                        i++) {
                                      if (_userModel![i].county ==
                                          selectval_county) {
                                        listCity_temp.add(_userModel![i].city);
                                      }
                                    }
                                  }
                                  listCity = listCity_temp.toList();
                                  listCity.add('- Altă opțiune -');
                                  listCity..sort();
                                });
                              },
                              items: listCounty.map((itemone) {
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
                          ),
                        ])),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Row(children: [
                          Text(
                            'Localitate:',
                            style: TextStyle(
                              fontFamily: 'HPSimplified',
                              fontSize: 18,
                              color: city_text_color,
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 100),
                          Text(
                            'Altă opțiune:',
                            style: TextStyle(
                              fontFamily: 'HPSimplified',
                              fontSize: 18,
                              color: alt_option_city_text_color,
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
                          Container(
                            height: 50,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(43, 239, 232, 232),
                              border: Border.all(
                                  color: borderColor_city, width: 2.0),
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
                              value: selectval_city,
                              menuMaxHeight: 300.0,
                              isExpanded: true,
                              dropdownColor: Color.fromARGB(255, 43, 43, 40),
                              onChanged: (value) {
                                setState(() {
                                  listName_temp.clear();
                                  listName.clear();
                                  listStreet_temp.clear();
                                  listStreet.clear();
                                  selectval_name = null;
                                  selectval_city = null;
                                  readOnly_Name = true;
                                  readOnly_Street = true;
                                  borderColor_name =
                                      Color.fromARGB(81, 85, 126, 255);
                                  borderColor_street =
                                      Color.fromARGB(81, 85, 126, 255);
                                  borderColor_name_alt =
                                      Color.fromARGB(23, 239, 232, 232);
                                  borderColor_street_alt =
                                      Color.fromARGB(23, 239, 232, 232);
                                  alt_option_name_text_color =
                                      Color.fromARGB(23, 239, 232, 232);
                                  alt_option_street_text_color =
                                      Color.fromARGB(23, 239, 232, 232);
                                  borderColor_street =
                                      Color.fromARGB(23, 239, 232, 232);
                                  street_text_color =
                                      Color.fromARGB(23, 239, 232, 232);
                                  selectval_city = value.toString();
                                  if (selectval_city == '- Altă opțiune -') {
                                    borderColor_city_alt =
                                        Color.fromARGB(81, 85, 126, 255);
                                    readOnly_City = false;
                                    alt_option_city_text_color =
                                        Color.fromARGB(255, 255, 255, 255);
                                  } else {
                                    borderColor_city_alt =
                                        Color.fromARGB(23, 239, 232, 232);
                                    readOnly_City = true;
                                    alt_option_city_text_color =
                                        Color.fromARGB(23, 239, 232, 232);
                                  }
                                  if (selectval_city != null) {
                                    name_text_color =
                                        Color.fromARGB(255, 255, 255, 255);
                                    for (int i = 0;
                                        i < _userModel!.length;
                                        i++) {
                                      if (_userModel![i].city ==
                                          selectval_city) {
                                        listName_temp.add(_userModel![i].name);
                                      }
                                      listName = listName_temp.toList();
                                      listName.add('- Altă opțiune -');
                                      listName..sort();
                                    }
                                  }
                                });
                              },
                              items: listCity.map((itemone) {
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
                          ),
                          SizedBox(width: 10),
                          Container(
                              height: 50,
                              width: 160,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(43, 239, 232, 232),
                                border: Border.all(
                                    color: borderColor_city_alt, width: 2.0),
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
                                  readOnly: readOnly_City,
                                  controller: police_inst_city_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300)))
                        ])),
                    SizedBox(height: 30),
                    Padding(
                        padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Row(children: [
                          Text(
                            'Numele secției:',
                            style: TextStyle(
                              fontFamily: 'HPSimplified',
                              fontSize: 18,
                              color: name_text_color,
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 132),
                        ])),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: new EdgeInsets.fromLTRB(30, 0, 27, 0),
                        child: Row(children: [
                          Container(
                            height: 70,
                            width: 325,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(43, 239, 232, 232),
                              border: Border.all(
                                  color: borderColor_name, width: 2.0),
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
                              value: selectval_name,
                              menuMaxHeight: 300.0,
                              isExpanded: true,
                              dropdownColor: Color.fromARGB(255, 43, 43, 40),
                              onChanged: (value) {
                                setState(() {
                                  listStreet_temp.clear();
                                  listStreet.clear();
                                  selectval_name = value.toString();
                                  selectval_street = null;
                                  readOnly_Name = true;
                                  readOnly_Street = true;
                                  borderColor_street =
                                      Color.fromARGB(81, 85, 126, 255);
                                  borderColor_street_alt =
                                      Color.fromARGB(23, 239, 232, 232);
                                  alt_option_street_text_color =
                                      Color.fromARGB(23, 239, 232, 232);
                                  if (selectval_name == '- Altă opțiune -') {
                                    readOnly_Name = false;
                                    borderColor_name_alt =
                                        Color.fromARGB(81, 85, 126, 255);
                                    alt_option_name_text_color =
                                        Color.fromARGB(255, 255, 255, 255);
                                  } else {
                                    borderColor_name_alt =
                                        Color.fromARGB(23, 239, 232, 232);

                                    alt_option_name_text_color =
                                        Color.fromARGB(23, 239, 232, 232);

                                    readOnly_Name = true;
                                  }

                                  if (selectval_name != null) {
                                    street_text_color =
                                        Color.fromARGB(255, 255, 255, 255);
                                    for (int i = 0;
                                        i < _userModel!.length;
                                        i++) {
                                      if (_userModel![i].name ==
                                              selectval_name &&
                                          _userModel![i].city ==
                                              selectval_city) {
                                        listStreet_temp
                                            .add(_userModel![i].adress);
                                      }
                                      listStreet = listStreet_temp.toList();
                                      listStreet.add('- Altă opțiune -');
                                      listStreet..sort();
                                    }
                                  }
                                });
                              },
                              items: listName.map((itemone) {
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
                          ),
                          SizedBox(width: 10),
                        ])),
                    SizedBox(height: 10),
                  ],
                ),
                Padding(
                    padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Row(children: [
                      Text(
                        'Altă opțiune:',
                        style: TextStyle(
                          fontFamily: 'HPSimplified',
                          fontSize: 18,
                          color: alt_option_name_text_color,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 0, 0, 0),
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      )
                    ])),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Row(
                    children: [
                      Container(
                          height: 50,
                          width: 325,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(43, 239, 232, 232),
                            border: Border.all(
                                color: borderColor_name_alt, width: 2.0),
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
                              readOnly: readOnly_Name,
                              controller: police_inst_name_controller,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300)))
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                    padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Row(children: [
                      Text(
                        'Adresa:',
                        style: TextStyle(
                          fontFamily: 'HPSimplified',
                          fontSize: 18,
                          color: street_text_color,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 0, 0, 0),
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 132),
                    ])),
                SizedBox(height: 10),
                Padding(
                    padding: new EdgeInsets.fromLTRB(30, 0, 27, 0),
                    child: Row(children: [
                      Container(
                        height: 70,
                        width: 325,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(43, 239, 232, 232),
                          border:
                              Border.all(color: borderColor_street, width: 2.0),
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
                          value: selectval_street,
                          menuMaxHeight: 300.0,
                          isExpanded: true,
                          dropdownColor: Color.fromARGB(255, 43, 43, 40),
                          onChanged: (value) {
                            setState(() {
                              selectval_street = value.toString();

                              if (selectval_street == '- Altă opțiune -') {
                                readOnly_Street = false;
                                borderColor_street_alt =
                                    Color.fromARGB(81, 85, 126, 255);
                                alt_option_street_text_color =
                                    Color.fromARGB(255, 255, 255, 255);
                              } else {
                                borderColor_street_alt =
                                    Color.fromARGB(23, 239, 232, 232);
                                alt_option_street_text_color =
                                    Color.fromARGB(23, 239, 232, 232);
                                readOnly_Street = true;
                              }
                            });
                          },
                          items: listStreet.map((itemone) {
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
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              offset: Offset(2, 2),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ))));
                          }).toList(),
                        )),
                      ),
                      SizedBox(width: 10),
                    ])),
                SizedBox(height: 10),
                Padding(
                    padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Row(children: [
                      Text(
                        'Altă opțiune:',
                        style: TextStyle(
                          fontFamily: 'HPSimplified',
                          fontSize: 18,
                          color: alt_option_street_text_color,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 0, 0, 0),
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      )
                    ])),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Row(
                    children: [
                      Container(
                          height: 50,
                          width: 325,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(43, 239, 232, 232),
                            border: Border.all(
                                color: borderColor_street_alt, width: 2.0),
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
                              readOnly: readOnly_Street,
                              controller: police_inst_street_controller,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300)))
                    ],
                  ),
                ),
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
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
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
                dateField(dateController_crime, date_of_event_text_controller),
                SizedBox(
                  height: 50,
                ),
                yesNoField(
                  text: 'Aţi plătit amenda instituită prin\nprocesul verbal?',
                  onAnswerChanged: handleAnswerChanged_paid_answer,
                ),
                SizedBox(
                  height: 50,
                ),
                wideField_bigText("Vă rugăm să introduceți valoarea\namenzii:",
                    TextInputType.number, 50, payTheFineSum_controller),
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
                                        padding:
                                            new EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                wideField("Norma legală în care sunt prevăzute\nsancţiunile :",
                    TextInputType.text, law_rule_event_controller),
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
                wideField("Norma legală în care sunt prevăzute\nsancţiunile :",
                    TextInputType.text, law_rule_pay_controller),
                SizedBox(
                  height: 50,
                ),
                yesNoField(
                  text:
                      'Aveţi martori care să fie audiaţi de\ninstanţa de judecată şi care sunt\npregatiţi să vă probeze nevinovaţia?',
                  onAnswerChanged: handleAnswerChanged_witness_answer,
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
                          'Cu ce alte documente vă puteţi\napăra în faţa instanţei de judecată?',
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
                          value: selectval_defend,
                          isExpanded: true,
                          dropdownColor: Color.fromARGB(255, 43, 43, 40),
                          onChanged: (value) {
                            setState(() {
                              selectval_defend = value.toString();
                            });
                          },
                          items: defendList.map((itemone) {
                            return DropdownMenuItem(
                                value: itemone,
                                child: Center(
                                    child: Padding(
                                        padding:
                                            new EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                                        padding:
                                            new EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                yesNoField(
                  text:
                      "Doriţi să fiţi asistat de un avocat în\nsala de judecată?",
                  onAnswerChanged: handleAnswerChanged_lawyer_answer,
                ),
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
                Padding(
                    padding: new EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: CheckboxListTile(
                      title: Text(
                          'Acord de consimțământ pentru prelucrarea datelor personale conform GDPR',
                          style: TextStyle(
                            fontFamily: 'HPSimplified',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
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
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                      fillColor: MaterialStateProperty.all(
                          Color.fromARGB(81, 85, 126, 255)),
                    )),
                SizedBox(
                  height: 30,
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
                            print(isChecked);
                            if (selectval_county != null &&
                                selectval_city != null &&
                                selectval_name != null &&
                                selectval_street != null) {
                              var selectval_city_temp = '';
                              var selectval_name_temp = '';
                              var selectval_street_temp = '';
                              if (selectval_city == "- Altă opțiune -") {
                                selectval_city_temp =
                                    police_inst_city_controller.text;
                              } else {
                                selectval_city_temp = selectval_city!;
                              }

                              if (selectval_name == "- Altă opțiune -") {
                                selectval_name_temp =
                                    police_inst_name_controller.text;
                              } else {
                                selectval_name_temp = selectval_name!;
                              }

                              if (selectval_street == "- Altă opțiune -") {
                                selectval_street_temp =
                                    police_inst_street_controller.text;
                              } else {
                                selectval_street_temp = selectval_street!;
                              }

                              police_institution = selectval_name_temp;
                              police_adr = selectval_street_temp +
                                  " " +
                                  selectval_city_temp +
                                  ", județul " +
                                  selectval_county!;
                              print(police_adr);
                            }
                            if (name_controller.text == '' ||
                                surname_controller.text == '' ||
                                phone_controller.text == '' ||
                                email_controller.text == '' ||
                                CIseries_controller.text == '' ||
                                CInr_controller.text == '' ||
                                CNP_controller.text == '' ||
                                City_controller.text == '' ||
                                County_controller.text == '' ||
                                Street_controller.text == '' ||
                                Bl_controller.text == '' ||
                                Sc_controller.text == '' ||
                                Ap_controller.text == '' ||
                                police_name_controller.text == '' ||
                                police_surname_controller.text == '' ||
                                WitnessesData_controller.text == '' ||
                                payTheFineSum_controller.text == '' ||
                                event_place_controller.text == '' ||
                                series_verbal_process_controller.text == '' ||
                                number_verbal_process_controller.text == '' ||
                                verbal_process_date_text_controller.text ==
                                    '' ||
                                selectval_possesion == '' ||
                                date_of_handing_out_text_controller.text ==
                                    '' ||
                                date_of_event_text_controller.text == '' ||
                                selectval_solicitate == '' ||
                                description_of_event_verbal_controller.text ==
                                    '' ||
                                description_of_event_person_controller.text ==
                                    '' ||
                                law_number_event_controller.text == '' ||
                                law_paragraph_event_controller.text == '' ||
                                law_rule_event_controller.text == '' ||
                                law_number_pay_controller.text == '' ||
                                law_paragraph_pay_controller.text == '' ||
                                law_rule_pay_controller.text == '' ||
                                selectval_presence == '' ||
                                police_institution == '' ||
                                title_controller.text == '' ||
                                isChecked == false ||
                                observation_controller.text == '') {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context),
                              );
                            } else {
                              submitComplaint();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialogConfirm(context),
                              );
                            }
                          },
                          child: Text(
                            'Submit',
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
                )
              ],
            ),
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
  final void Function(String) onAnswerChanged;

  const yesNoField({
    required this.text,
    required this.onAnswerChanged,
  });

  @override
  _yesNoFieldState createState() => _yesNoFieldState();
}

class _yesNoFieldState extends State<yesNoField> {
  String answer = '';

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

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('Atenție!'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            "Toate câmpurile sunt obligatorii. Vă rugăm să încercați din nou."),
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

Widget _buildPopupDialogConfirm(BuildContext context) {
  return new AlertDialog(
    title: const Text('Succes'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            "Formularul a fost generat cu succes. Vă rugăm să plătiți taxa pentru a putea continua."),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NavBar(title: 'Home');
          }));
        },
        child: const Text('Close'),
      ),
    ],
  );
}
