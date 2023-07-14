class complaint_request_model {
  String? name;
  String? surname;
  String? phone;
  String? email;
  String? CIseries;
  String? CInr;
  String? CNP;
  String? City;
  String? County;
  String? Street;
  String? Bl;
  String? Sc;
  String? Ap;
  String? policeName;
  String? policeSurname;
  String? policeInstitution;
  String? PoliceAdr;
  String? eventPlace;
  String? verbalProcess;
  String? seriesVerbalProcess;
  String? numberVerbalProcess;
  String? dateVerbalProcess;
  String? handingOutVerbalProcess;
  String? dateOfHandingOutVerbalProcess;
  String? dateOfEvent;
  String? payTheFine;
  String? payTheFineSum;
  String? options;
  String? descriptionOfTheEventInVerbalProcess;
  String? descriptionOfTheEventInPersonalOpinion;
  String? lawNumberEvent;
  String? lawParagraphEvent;
  String? lawRuleEvent;
  String? lawNumberPay;
  String? lawParagraphPay;
  String? lawRulePay;
  String? witnesses;
  String? WitnessesData;
  String? judge;
  String? lawyer;
  bool? Accept;
  String? pay;
  String? userID;
  String? title;
  String? observations;
  String? status;

  complaint_request_model(
      {this.name,
      this.surname,
      this.phone,
      this.email,
      this.CIseries,
      this.CInr,
      this.CNP,
      this.City,
      this.County,
      this.Street,
      this.Bl,
      this.Sc,
      this.Ap,
      this.policeName,
      this.policeSurname,
      this.policeInstitution,
      this.PoliceAdr,
      this.eventPlace,
      this.verbalProcess,
      this.seriesVerbalProcess,
      this.numberVerbalProcess,
      this.dateVerbalProcess,
      this.handingOutVerbalProcess,
      this.dateOfHandingOutVerbalProcess,
      this.dateOfEvent,
      this.payTheFine,
      this.payTheFineSum,
      this.options,
      this.descriptionOfTheEventInVerbalProcess,
      this.descriptionOfTheEventInPersonalOpinion,
      this.lawNumberEvent,
      this.lawParagraphEvent,
      this.lawRuleEvent,
      this.lawNumberPay,
      this.lawParagraphPay,
      this.lawRulePay,
      this.witnesses,
      this.WitnessesData,
      this.judge,
      this.lawyer,
      this.Accept,
      this.pay,
      this.userID,
      this.title,
      this.observations,
      this.status});

  complaint_request_model.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    surname = json['Surname'];
    phone = json['Phone'];
    email = json['Email'];
    CIseries = json['CIseries'];
    CInr = json['CInr'];
    CNP = json['CNP'];
    City = json['City'];
    County = json['County'];
    Street = json['Street'];
    Bl = json['Bl'];
    Sc = json['Sc'];
    Ap = json['Ap'];
    policeName = json['PoliceName'];
    policeSurname = json['PoliceSurname'];
    policeInstitution = json['PoliceInstitution'];
    PoliceAdr = json['PoliceAdr'];
    eventPlace = json['EventPlace'];
    verbalProcess = json['VerbalProcess'];
    seriesVerbalProcess = json['SeriesVerbalProcess'];
    numberVerbalProcess = json['NumberVerbalProcess'];
    dateVerbalProcess = json['DateVerbalProcess'];
    handingOutVerbalProcess = json['HandingOutVerbalProcess'];
    dateOfHandingOutVerbalProcess = json['DateOfHandingOutVerbalProcess'];
    dateOfEvent = json['DateOfEvent'];
    payTheFine = json['PayTheFine'];
    payTheFineSum = json['PayTheFineSum'];
    options = json['Options'];
    descriptionOfTheEventInVerbalProcess =
        json['DescriptionOfTheEventInVerbalProcess'];
    descriptionOfTheEventInPersonalOpinion =
        json['DescriptionOfTheEventInPersonalOpinion'];
    lawNumberEvent = json['LawNumberEvent'];
    lawParagraphEvent = json['LawParagraphEvent'];
    lawRuleEvent = json['LawRuleEvent'];
    lawNumberPay = json['LawNumberPay'];
    lawParagraphPay = json['LawParagraphPay'];
    lawRulePay = json['LawRulePay'];
    witnesses = json['Witnesses'];
    WitnessesData = json['WitnessesData'];
    judge = json['Judge'];
    lawyer = json['Lawyer'];
    Accept = json['Accept'];
    pay = json['Pay'];
    userID = json['UserID'];
    title = json['Title'];
    observations = json['Observations'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Surname'] = this.surname;
    data['Phone'] = this.phone;
    data['Email'] = this.email;
    data['CIseries'] = this.CIseries;
    data['CInr'] = this.CInr;
    data['CNP'] = this.CNP;
    data['City'] = this.City;
    data['County'] = this.County;
    data['Street'] = this.Street;
    data['Bl'] = this.Bl;
    data['Sc'] = this.Sc;
    data['Ap'] = this.Ap;
    data['PoliceName'] = this.policeName;
    data['PoliceSurname'] = this.policeSurname;
    data['PoliceInstitution'] = this.policeInstitution;
    data['PoliceAdr'] = this.PoliceAdr;
    data['EventPlace'] = this.eventPlace;
    data['VerbalProcess'] = this.verbalProcess;
    data['SeriesVerbalProcess'] = this.seriesVerbalProcess;
    data['NumberVerbalProcess'] = this.numberVerbalProcess;
    data['DateVerbalProcess'] = this.dateVerbalProcess;
    data['HandingOutVerbalProcess'] = this.handingOutVerbalProcess;
    data['DateOfHandingOutVerbalProcess'] = this.dateOfHandingOutVerbalProcess;
    data['DateOfEvent'] = this.dateOfEvent;
    data['PayTheFine'] = this.payTheFine;
    data['PayTheFineSum'] = this.payTheFineSum;
    data['Options'] = this.options;
    data['DescriptionOfTheEventInVerbalProcess'] =
        this.descriptionOfTheEventInVerbalProcess;
    data['DescriptionOfTheEventInPersonalOpinion'] =
        this.descriptionOfTheEventInPersonalOpinion;
    data['LawNumberEvent'] = this.lawNumberEvent;
    data['LawParagraphEvent'] = this.lawParagraphEvent;
    data['LawRuleEvent'] = this.lawRuleEvent;
    data['LawNumberPay'] = this.lawNumberPay;
    data['LawParagraphPay'] = this.lawParagraphPay;
    data['LawRulePay'] = this.lawRulePay;
    data['Witnesses'] = this.witnesses;
    data['WitnessesData'] = this.WitnessesData;
    data['Judge'] = this.judge;
    data['Lawyer'] = this.lawyer;
    data['Accept'] = this.Accept;
    data['Pay'] = this.pay;
    data['UserID'] = this.userID;
    data['Title'] = this.title;
    data['Observations'] = this.observations;
    data['Status'] = this.status;
    return data;
  }
}
