import 'dart:convert';
import 'dart:io';
import 'package:first_app/services/api_service.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
class CreatePDF {
  Future<void> generatePDF(String complaintID) async {
    final pdf = pw.Document();

    final font1 = await PdfGoogleFonts.openSansBold();
    final font2 = await PdfGoogleFonts.openSansRegular();

    String complaintDetails = await APIService.getComplaintDetails(complaintID);
    Map<String, dynamic> jsonMap = await json.decode(complaintDetails);
    String complaint_Name = await jsonMap['Name'];
    String complaint_Surname = await jsonMap['Surname'];
    String complaint_City = await jsonMap['City'];
    String complaint_County = await jsonMap['County'];
    String complaint_Street = await jsonMap['Street'];
    String complaint_Bl = await jsonMap['Bl'];
    String complaint_Sc = await jsonMap['Sc'];
    String complaint_Ap = await jsonMap['Ap'];
    String complaint_CIseries = await jsonMap['CIseries'];
    String complaint_CInr = await jsonMap['CInr'];
    String complaint_PayTheFineSum = await jsonMap['PayTheFineSum'];
    String complaint_CNP = await jsonMap['CNP'];
    String complaint_Title = await jsonMap['Title'];
    String complaint_PoliceInstitution = await jsonMap['PoliceInstitution'];
    String complaint_PoliceAdr = await jsonMap['PoliceAdr'];
    String complaint_SeriesVerbalProcess = await jsonMap['SeriesVerbalProcess'];
    String complaint_NumberVerbalProcess = await jsonMap['NumberVerbalProcess'];
    String complaint_DateVerbalProcess = await jsonMap['DateVerbalProcess'];
    String complaint_DateOfHandingOutVerbalProcess =
        await jsonMap['DateOfHandingOutVerbalProcess'];
    String complaint_LawNumberEvent = await jsonMap['LawNumberEvent'];
    String complaint_LawParagraphEvent = await jsonMap['LawParagraphEvent'];
    String complaint_LawRuleEvent = await jsonMap['LawRuleEvent'];
    String complaint_DescriptionOfTheEventInVerbalProcess =
        await jsonMap['DescriptionOfTheEventInVerbalProcess'];
    String complaint_VerbalProcess = await jsonMap['VerbalProcess'];
    String complaint_DescriptionOfTheEventInPersonalOpinion =
        await jsonMap['DescriptionOfTheEventInPersonalOpinion'];
    String complaint_PayTheFine = await jsonMap['PayTheFine'];
    String complaint_Witnesses = await jsonMap['Witnesses'];
    String complaint_WitnessesData = await jsonMap['WitnessesData'];
    String complaint_WitnessesDataString = '';
    List<String> temp_list = complaint_WitnessesData.split(';');
    for (var element in temp_list) {
      complaint_WitnessesDataString += '- ' + element + "\n";
    }

    String PayTheFine_Response = '';
    String VerbalProcess_Response = '';
    if (complaint_PayTheFine == 'DA') {
      PayTheFine_Response = 'achitată';
    } else if (complaint_PayTheFine == 'NU') {
      VerbalProcess_Response = 'neachitată';
    }
    if (complaint_VerbalProcess == 'DA') {
      VerbalProcess_Response = 'am fost de acord';
    } else if (complaint_VerbalProcess == 'NU') {
      VerbalProcess_Response = 'nu am fost de acord';
    }

    pdf.addPage(
      pw.Page(
          build: (pw.Context context) => pw.ListView(children: [
                pw.Column(children: [
                  pw.Row(children: [
                    pw.Text(
                      'CĂTRE\n   JUDECĂTORIA TIMIȘOARA',
                      style: pw.TextStyle(
                        font: font1,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ]),
                  pw.SizedBox(height: 40),
                  pw.Row(children: [
                    pw.Flexible(
                        child: pw.Text(
                            "     Subsemnatul ${complaint_Surname} ${complaint_Name}, cu domiciliul în ${complaint_City}, strada ${complaint_Street}, bl. ${complaint_Bl}, sc. ${complaint_Sc}, ap. ${complaint_Ap}, jud. ${complaint_County}, posesor al CI seria ${complaint_CIseries} nr. ${complaint_CInr}, CNP ${complaint_CNP}, în calitate de Petent.",
                            style: pw.TextStyle(font: font2))),
                  ]),
                  pw.SizedBox(height: 10),
                  pw.Row(children: [
                    pw.Flexible(
                      child: pw.Text(
                          "     În contradictoriu cu ${complaint_PoliceInstitution}, cu sediul în ${complaint_PoliceAdr} prin reprezentant legal, în calitate de Intimat.",
                          style: pw.TextStyle(font: font2)),
                    )
                  ]),
                  pw.SizedBox(height: 10),
                  pw.Row(children: [
                    pw.Flexible(
                      child: pw.Text(
                          "     în temeiul art. 31 din Ordonanţa nr. 2/2001 privind regimul juridic al contraveniilor precum şi art. 118 din OUG 195/2002, formulez în termenul legal şi depun prezenta",
                          style: pw.TextStyle(font: font2)),
                    )
                  ]),
                  pw.SizedBox(height: 20),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          "     PLÂNGERE CONTRAVENŢIONALĂ",
                          style: pw.TextStyle(font: font1, fontSize: 18),
                        ),
                      ]),
                  pw.SizedBox(height: 20),
                  pw.Row(children: [
                    pw.Flexible(
                        child: pw.Text(
                      "   împotriva procesului verbal de contravenție seria ${complaint_SeriesVerbalProcess} nr. ${complaint_NumberVerbalProcess} din ${complaint_DateVerbalProcess} și comunicat în ${complaint_DateOfHandingOutVerbalProcess}, solicitându-vă, ca prin sentința ce o veţi pronunța, să dispuneți:",
                      style: pw.TextStyle(font: font2),
                    )),
                  ]),
                  pw.SizedBox(height: 10),
                  pw.Bullet(
                      text:
                          'să dispuneți admiterea acțiunii, anularea procesului verbal de contravenție având în vedere modul în care este completat, dar și pentru că fapta nu există și, în consecință, anularea sancţiunii constând în aplicarea amenzii de ${complaint_PayTheFineSum} RON (${PayTheFine_Response}), precum şi anularea sancțiunii constând în suspendarea dreptului de a conduce,',
                      style: pw.TextStyle(font: font1)),
                  pw.SizedBox(height: 10),
                  pw.Bullet(
                      text:
                          "obligarea intimatei la suportarea tuturor cheltuielilor de judecată angajate de subsemnatul în cadrul prezentului litigiu, constând în taxă judiciară de timbru și onorariu de avocat,",
                      style: pw.TextStyle(font: font1)),
                  pw.SizedBox(height: 10),
                  pw.Row(children: [
                    pw.Text(
                      "     Pentru următoarele",
                      style: pw.TextStyle(font: font2),
                    ),
                  ]),
                  pw.SizedBox(height: 10),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          "     MOTIVE",
                          style: pw.TextStyle(font: font2, fontSize: 15),
                        ),
                      ]),
                  pw.SizedBox(height: 10),
                  pw.Row(children: [
                    pw.Flexible(
                        child: pw.Text(
                      "     ÎN FAPT ${complaint_DescriptionOfTheEventInVerbalProcess}, motiv pentru care a fost întocmit procesul verbal de contravenție seria ${complaint_LawNumberEvent} ${complaint_LawParagraphEvent} cu aplicarea sancțiunii în valoare de ${complaint_PayTheFineSum} RON.",
                      style: pw.TextStyle(font: font2),
                    )),
                  ]),
                ])
              ])),
    );

    pdf.addPage(pw.Page(
        build: (pw.Context context) => pw.ListView(children: [
              pw.Column(children: [
                pw.Row(children: [
                  pw.Flexible(
                      child: pw.Text(
                    "     Arăt că ${VerbalProcess_Response} cu semnarea acestuia deoarece fapta descrisă în procesul verbal nu corespunde realităţii.",
                    style: pw.TextStyle(font: font2),
                  )),
                ]),
                pw.Row(children: [
                  pw.Flexible(
                      child: pw.Text(
                    "     Agentul constatator a dispus aplicarea unei amenzi contravenţionale în cuantum de ${complaint_PayTheFineSum} RON, în temeiul art. ${complaint_LawNumberEvent} din Ordonanţa de urgenţă a Guvernului nr. 195/2002 privind circulaţia pe drumurile publice.",
                    style: pw.TextStyle(font: font2),
                  )),
                ]),
                pw.Row(children: [
                  pw.Flexible(
                      child: pw.Text(
                    "     În realitate, descrierea subsemnatului este: ${complaint_DescriptionOfTheEventInPersonalOpinion}.",
                    style: pw.TextStyle(font: font2),
                  )),
                ]),
                pw.SizedBox(height: 10),
                pw.Row(children: [
                  pw.Flexible(
                      child: pw.Text(
                    "MOTIVARE ÎN DREPT: ",
                    style: pw.TextStyle(font: font1),
                  )),
                ]),
                pw.SizedBox(height: 10),
                pw.Row(children: [
                  pw.Flexible(
                      child: pw.Text(
                    "     Articolul indicat cu referire la sancţiunea aplicată este cel prevăzut la art. ${complaint_LawNumberEvent}, ${complaint_LawParagraphEvent}, ${complaint_LawRuleEvent}.",
                    style: pw.TextStyle(font: font2),
                  )),
                ]),
                pw.SizedBox(height: 10),
                if (complaint_Witnesses == 'DA')
                  pw.Row(children: [
                    pw.Flexible(
                        child: pw.Text(
                      "     În probarea celor susținute, solicit încuviințarea administrării probei cu înscrisuri şi cu martorii:\n${complaint_WitnessesDataString}",
                      style: pw.TextStyle(font: font2),
                    )),
                  ]),
                pw.Row(children: [
                  pw.Flexible(
                      child: pw.Text(
                    "Teza probatie:",
                    style: pw.TextStyle(font: font2),
                  )),
                ]),
                pw.Row(children: [
                  pw.Flexible(
                      child: pw.Text(
                    "În temeiul dispozițiilor art. 223 alin. (3) Cod Procedură Civilă solicit judecarea prezentei cauze și în lipsa părților.",
                    style: pw.TextStyle(font: font2),
                  )),
                ]),
                pw.SizedBox(height: 10),
                pw.Row(children: [
                  pw.Flexible(
                      child: pw.Text(
                    "Depun prezenta plângere contravențională, în 2 (două) exemplare.",
                    style: pw.TextStyle(font: font2),
                  )),
                ]),
                pw.SizedBox(height: 10),
                pw.Row(children: [
                  pw.Flexible(
                      child: pw.Text(
                    "Pentru toate cele prezentate în prezenta Plângere, solicităm admiterea acţiunii şi să dispuneţi anularea procesului verbal de contravenţie.",
                    style: pw.TextStyle(font: font2),
                  )),
                ]),
                pw.SizedBox(height: 30),
                pw.Row(children: [
                  pw.Flexible(
                      child: pw.Center(
                          child: pw.Text(
                    "Cu stimă,\n${complaint_Name} ${complaint_Surname}\nprin Avocat MARCU Mihaela Luminiţa",
                    style: pw.TextStyle(font: font2),
                    textAlign: pw.TextAlign.center,
                  ))),
                ]),
              ])
            ])));

    String pdf_title = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
    pdf_title = "plangere_" + pdf_title + "_" + complaint_Title;
    print('Current date and time: $pdf_title');
    pdf_title = pdf_title.replaceAll(' ', '_');
    pdf_title = pdf_title.replaceAll(':', '_');
    pdf_title = pdf_title.substring(0, pdf_title.length - 1);
    pdf_title = "/storage/emulated/0/Download/" + pdf_title + ".pdf";
    print(pdf_title);

    final file = File(pdf_title);
    await file.create();
    await file.writeAsBytes(await pdf.save());
  }
}
