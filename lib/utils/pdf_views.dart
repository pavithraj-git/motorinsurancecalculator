import 'dart:io';

import 'package:flutter/services.dart';
import 'package:motorinsurancecalculator/model/vehicle_info_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../common/share_file.dart';
import '../model/calculation_model.dart';
import '../model/two_wheeler_premium_model.dart';

class PDFViews {


  final pdf = pw.Document();
  PdfColor headerBlue = PdfColor.fromInt(0xFF1F3864);   // dark navy for company name
  PdfColor accentRed  = PdfColor.fromInt(0xFFCC0000);   // red for section labels
  PdfColor tableHeaderBg = PdfColor.fromInt(0xFFF2F2F2);
  PdfColor borderColor   = PdfColor.fromInt(0xFF000000);
  PdfColor lightGrey  = PdfColor.fromInt(0xFFD9D9D9);

  // ── Shared text styles ──────────────────────────────────────────────────────
  late final companyStyle = pw.TextStyle(
    fontSize: 20,
    fontWeight: pw.FontWeight.bold,
    color: headerBlue,
  );
  late final titleStyle = pw.TextStyle(
    fontSize: 11,
    fontWeight: pw.FontWeight.bold,
    color: accentRed,
    decoration: pw.TextDecoration.underline,
  );
  final sectionHeaderStyle = pw.TextStyle(
    fontSize: 9,
    fontWeight: pw.FontWeight.bold,
    color: PdfColors.black,
  );
  final cellStyle    = pw.TextStyle(fontSize: 8);
  final boldCell     = pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold);
  final noteStyle    = pw.TextStyle(fontSize: 7, color: PdfColors.grey700);
  late final redBoldStyle = pw.TextStyle(
    fontSize: 8,
    fontWeight: pw.FontWeight.bold,
    color: accentRed,
  );

  // ── Helper: bordered cell ───────────────────────────────────────────────────
  pw.Widget _cell(
      String text, {
        pw.TextStyle? style,
        PdfColor? bg,
        pw.Alignment align = pw.Alignment.centerLeft,
        int flex = 1,
      }) {
    return pw.Expanded(
      flex: flex,
      child: pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: borderColor, width: text == "" ? 0 : 0.4),
          color: bg,
        ),
        padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        child: pw.Align(
          alignment: align,
          child: pw.Text(text, style: style ?? cellStyle),
        ),
      ),
    );
  }

  // ── Helper: label-value row (single column layout) ──────────────────────────
  pw.Widget _labelValue(String label, String? value) {
    return pw.Row(
      children: [
        _cell(label,  style: boldCell, flex: 3),
        _cell(value ?? '-', flex: 2),
      ],
    );
  }

  // ── Helper: two-column premium row (OD side | Liability side) ───────────────
  pw.Widget _dualRow(
      String leftLabel,  String? leftVal,
      String rightLabel, String? rightVal,
      ) {
    return pw.Row(
      children: [
        _cell(leftLabel,    flex: 4),
        _cell(leftVal  ?? '-', align: pw.Alignment.centerRight, flex: 2),
        _cell(rightLabel,   flex: 4),
        _cell(rightVal ?? '-', align: pw.Alignment.centerRight, flex: 2),
      ],
    );
  }

  // ── Helper: OD-only row (right half empty) ──────────────────────────────────
  pw.Widget _odRow(String label, String? val) {
    return pw.Row(
      children: [
        _cell(label, flex: 4),
        _cell(val ?? '-', align: pw.Alignment.centerRight, flex: 2),
        _cell('',    flex: 4),
        _cell('',    flex: 2),
      ],
    );
  }

  // ── Helper: section header spanning full width ──────────────────────────────
  pw.Widget _sectionHeader(String text) {
    return pw.Container(
      width: double.infinity,
      color: tableHeaderBg,
      padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: borderColor, width: 0.4),
      ),
      child: pw.Text(text, style: sectionHeaderStyle),
    );
  }

  // ── Helper: summary key-value row ──────────────────────────────────────────
  pw.Widget _summaryRow(String label, String? value, {bool bold = false, PdfColor? valueColor}) {
    return pw.Row(
      children: [
        _cell(label, style: bold ? boldCell : cellStyle, flex: 3),
        _cell(
          value ?? '-',
          style: pw.TextStyle(
            fontSize: 8,
            fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
            color: valueColor,
          ),
          flex: 2,
        ),
      ],
    );
  }

  pw.Widget _bottomPDF(VehicleInfoModel vehicleInfo){
    return pw.Column(
      crossAxisAlignment:pw.CrossAxisAlignment.start,
      children: [
        pw.Wrap(children: [
          pw.Text('Addon Coverage: ', style: noteStyle),
          if(vehicleInfo.zeroDep ?? false == true)
            pw.Text('Zero Depreciation,', style: noteStyle),
          if(vehicleInfo?.rsa == true)
            pw.Text('RSA,', style: noteStyle),
          if(vehicleInfo.consumable == true)
            pw.Text('Consumable,', style: noteStyle),
          if(vehicleInfo.enginCover == true)
            pw.Text('Engin Cover,', style: noteStyle),
          if(vehicleInfo.ncb == true)
            pw.Text('NCB Protection,', style: noteStyle),
          if(vehicleInfo.tyreCover == true)
            pw.Text('Tyre Cover,', style: noteStyle),
          if(vehicleInfo.lossKey == true)
            pw.Text('Loss of Key,', style: noteStyle),
          if(vehicleInfo.courtesy == true)
            pw.Text('Courtesy Car,', style: noteStyle),
          if(vehicleInfo.spare == true)
            pw.Text('Spare Car,', style: noteStyle),
          if(vehicleInfo.returnInvoice == true)
            pw.Text('Return Invoice,', style: noteStyle),
          if(vehicleInfo.medical == true)
            pw.Text('Medical Cover,', style: noteStyle),
          if(vehicleInfo.dailyCash == true)
            pw.Text('Daily Cash,', style: noteStyle),
          if(vehicleInfo.roadTax == true)
            pw.Text('Road Tax Cover,', style: noteStyle),
          if(vehicleInfo.additionalTowing == true)
            pw.Text('Additional Towing,', style: noteStyle),
          if(vehicleInfo.vas == true)
            pw.Text('VAS.', style: noteStyle),
        ]),
        pw.Text('Other Coverage : ${vehicleInfo.otherCoverage}', style: noteStyle),
        pw.SizedBox(height: 8),
        pw.RichText(
          text: pw.TextSpan(children: [
            pw.TextSpan(text: 'Kindly pay cheque/DD in favor of\n', style: redBoldStyle),
            pw.TextSpan(
              text: vehicleInfo.insuranceCompany?.toUpperCase(),
              style: redBoldStyle,
            ),
          ]),
        ),

        // ── Documents Required (was Page 2) ──────────────────────────────
        pw.SizedBox(height: 16),
        pw.Divider(thickness: 0.5),
        pw.SizedBox(height: 6),
        pw.Text('Documents Required:-',
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold,
                decoration: pw.TextDecoration.underline)),
        pw.SizedBox(height: 6),
        pw.Text(
          'Note : In case of any claim, NCB will be revised and hence Quotation is Subject to Change.',
          style: noteStyle,
        ),
        pw.Text(
          'Quote Validity: This Quote is valid for 7 days from date of generation.',
          style: noteStyle,
        ),
        pw.SizedBox(height: 8),
        pw.Text('1. Previous Policy Copy', style: cellStyle),
        pw.Text('2. RC copy',              style: cellStyle),
        pw.SizedBox(height: 16),
        pw.Text('Insurance is subject matter of the solicitation.', style: noteStyle),
      ]
    );
  }



  Future<pw.PageTheme> waterMark() async{
    final image = pw.MemoryImage(
      (await rootBundle.load('assets/logo1.png')).buffer.asUint8List(),
    );
   return pw.PageTheme(
     pageFormat: PdfPageFormat.a4,
     margin: const pw.EdgeInsets.all(24),
     buildBackground: (context) => pw.Center(
       child: pw.Opacity(
         opacity: 0.15,
         child: pw.Transform.rotate(
           angle: -0.5, // optional rotation
           child: pw.Image(
             image,
             width: 300,
           ),
         ),
       ),
     ),
      // buildBackground: (pw.Context context) {
      //   return pw.FullPage(
      //     ignoreMargins: true,
      //     child: pw.Watermark(
      //       child: pw.Text('TECLA MEDIA', style: pw.TextStyle(fontSize: 100, color: PdfColors.grey300)),
      //       angle: 0.5,
      //     ),
      //   );
      // },
    );
  }
  

 void shareFunction(String? title) async{
    final outputDir = await getTemporaryDirectory();
    final file = File("${outputDir.path}/${title?.replaceAll(" ", "_")}_${DateTime.now()}.pdf");

    final output = await file.writeAsBytes(await pdf.save());
    ShareFile share = ShareFile();
    share.createAndShareFile(output);
  }


Future<void>  twoWheelerPremiumPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
  final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Liability Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow('Vehicle Basic Rate',           calculation?.vehicleBasicRate?.toString(),
              'Basic Liability Premium (TP)', calculation?.liability?.toString()),
          _dualRow('Basic for vehicle',            calculation?.basicVehicle?.toStringAsFixed(2),
              'PA Owner Driver',              data?.paOwnerDriver),
          _dualRow('Discount on OD Premium',       calculation?.disOD?.toStringAsFixed(2),
              'PA to Unnamed Passenger',      data?.paUnnamedPassenger),
          _dualRow('Basic OD Premium after Discount', calculation?.odAfterDis?.toStringAsFixed(2),
              'LL to Paid Driver',            data?.llPaidDriver),
          _odRow('Electrical / Electronic Accessories', calculation?.accessories?.toStringAsFixed(2)),
          _odRow('PA to Owner Driver',             data?.paOwnerDriver),
          _odRow('Basic OD Premium',               calculation?.basicVehicle?.toStringAsFixed(2)),
          _odRow('Discount on OD Premium',         calculation?.disOD?.toStringAsFixed(2)),
          _odRow('PA to Unnamed Passenger',        data?.paUnnamedPassenger),
          _odRow('Basic OD Before NCB',            calculation?.totalPremium?.toStringAsFixed(2)),
          _odRow('No Claim Bonus',                 calculation?.noClaim?.toStringAsFixed(2)),
          _odRow('Basic OD after NCB',             calculation?.netOwnDamage?.toStringAsFixed(2)),
          _odRow('Nil Depreciation',               calculation?.zeroDep?.toStringAsFixed(2)),

          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (B)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalAB?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

Future<void>  twoWheelerPassengerPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
  final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Liability Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow('Vehicle Basic Rate',           calculation?.vehicleBasicRate?.toString(),
              'Liability Premium (TP)', calculation?.liability?.toString()),
          _dualRow('Basic for vehicle',            calculation?.basicVehicle?.toStringAsFixed(2),
              'Passenger Coverage', calculation?.passCov?.toStringAsFixed(2)),
          _dualRow("Accessories Value", calculation?.accessories?.toStringAsFixed(2),
              "CNG/LPG Kit", calculation?.cngKit.toString()),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2),
              "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("Basic OD Premium", calculation?.basicODPri?.toStringAsFixed(2),
              "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("IMT 23", calculation?.imt23?.toStringAsFixed(2),
              "Restricted TP PD", calculation?.tppd.toString()),
          _odRow("Basic OD before discount", calculation?.odBeforeDis?.toStringAsFixed(2)),
          _odRow("Discount on OD Premium", calculation?.disOnODPre?.toStringAsFixed(2)),
          _odRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2)),
          _odRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2)),

          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (B)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalAB?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

Future<void>  electricTwoWheelerPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
  final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Kilowatt', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.kilowatt ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Liability Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow('Vehicle Basic Rate',           calculation?.vehicleBasicRate?.toString(),
            "Liability Premium (TP)", calculation?.liability.toString()),
          _dualRow('Basic for vehicle',            calculation?.basicVehicle?.toStringAsFixed(2),
            "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("Discount on OD Premium", calculation?.disOD?.toStringAsFixed(2),
              "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("Basic OD Premium after discount", calculation?.odAfterDis?.toStringAsFixed(2),
              "PA to Unnamed Passenger", data?.paUnnamedPassenger),
          _odRow("Basic OD before discount", calculation?.odBeforeDis?.toStringAsFixed(2)),
          _odRow("Accessories Value", calculation?.accessories?.toStringAsFixed(2)),
          _odRow("Total Basic Premium", calculation?.totalPremium?.toStringAsFixed(2)),
          _odRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2)),
          _odRow("Net Own Damage Premium", calculation?.netOwnDamage?.toStringAsFixed(2)),
          _odRow("Zero Dep Premium", calculation?.zeroDep?.toStringAsFixed(2)),
          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (B)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalAB?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

Future<void>  privateCar1ODPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
  final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Addon Coverage', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(),
              "Zero Depreciation", calculation?.zeroDep?.toStringAsFixed(2)),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2),
              "RSA/Additional for Addons", data?.rsa.toString()),
          _dualRow("Discount on OD Premium", calculation?.disOD?.toStringAsFixed(2),
              "Other Addon Coverage", calculation?.otherAddon?.toStringAsFixed(2)),
          _dualRow("Loading on OD Premium", calculation?.loadingOD?.toStringAsFixed(2),
              "Value Added Service", data?.valAddService),

          pw.Row(
            children: [
              _cell("Basic OD Premium after Discount/Loading", flex: 4),
              _cell(calculation?.odAfterDis?.toStringAsFixed(2) ?? '0.00',
                   align: pw.Alignment.centerRight,
                  flex: 2),
              _cell("Total Addon Premium (B)",
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.Row(children:[
            _cell("Electrical/Electronic Accessories",
                flex: 4),
            _cell(calculation!.accessories!.toStringAsFixed(2).toString(),
                align: pw.Alignment.centerRight, flex: 2),
            _cell('(C) Liability Premium', style: boldCell,
                bg: tableHeaderBg, flex: 4),
            _cell('Rupees', style: boldCell,
                align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
          ]),
          _dualRow("Non Electrical Accessories", calculation?.nonElecAcc?.toStringAsFixed(2),
              "Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2),
              "CNG/LPG Kit", calculation?.cngKit.toString()),
          _dualRow("Basic OD Premium", calculation?.basODPrime?.toStringAsFixed(2),
              "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2),
              "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("Net Own Damage Premium (A)", calculation?.totalA?.toStringAsFixed(2),
              "PA to Unnamed Passenger", calculation?.paUnnamed?.toStringAsFixed(2)),


          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (C)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalC?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B+C)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

Future<void>  privateCar3ODPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
  final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Addon Coverage', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(),
              "Zero Depreciation", calculation?.zeroDep?.toStringAsFixed(2)),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2),
              "RSA/Additional for Addons", data?.rsa.toString()),
          _dualRow("Discount on OD Premium", calculation?.disOD?.toStringAsFixed(2),
              "Other Addon Coverage", calculation?.otherAddon?.toStringAsFixed(2)),
          _dualRow("Loading on OD Premium", calculation?.loadingOD?.toStringAsFixed(2),
              "Value Added Service", data?.valAddService),
          pw.Row(
            children: [
              _cell("Basic OD Premium after Discount/Loading", flex: 4),
              _cell(calculation?.odAfterDis?.toStringAsFixed(2) ?? '0.00',
                  align: pw.Alignment.centerRight,
                  flex: 2),
              _cell("Total Addon Premium (B)",
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.Row(children:[
            _cell("Electrical/Electronic Accessories",
                flex: 4),
            _cell(calculation!.accessories!.toStringAsFixed(2).toString(),
                align: pw.Alignment.centerRight, flex: 2),
            _cell('(C) Liability Premium', style: boldCell,
                bg: tableHeaderBg, flex: 4),
            _cell('Rupees', style: boldCell,
                align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
          ]),
          _dualRow("Non Electrical Accessories", calculation?.nonElecAcc?.toStringAsFixed(2),
              "Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2),
              "CNG/LPG Kit", calculation?.cngKit.toString()),
          _dualRow("Basic OD Premium", calculation?.basODPrime?.toStringAsFixed(2),
              "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2),
              "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("Net Own Damage Premium (A)", calculation?.totalA?.toStringAsFixed(2),
              "PA to Unnamed Passenger", calculation?.paUnnamed?.toStringAsFixed(2)),


          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (C)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalC?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B+C)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

Future<void>  privateCarCompletePDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
  final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Addon Coverage', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Zero Depreciation", calculation?.zeroDep?.toStringAsFixed(2)),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2), "RSA/Additional for Addons", calculation?.rsa?.toStringAsFixed(2)),
          _dualRow("Discount on OD Premium", calculation?.disOD?.toStringAsFixed(2), "Consumables", calculation?.consumable?.toStringAsFixed(2)),
          _dualRow("Loading on OD Premium", calculation?.loadingOD?.toStringAsFixed(2), "Tyre Cover", calculation?.tyreCover?.toStringAsFixed(2)),
          _dualRow("Basic OD Premium after Discount/Loading", calculation?.odAfterDis?.toStringAsFixed(2), "NCB Protections", calculation?.ncb?.toStringAsFixed(2)),
          _dualRow("Electrical/Electronic Accessories", calculation?.accessories?.toStringAsFixed(2), "Engine Protection", calculation?.enginePro?.toStringAsFixed(2)),
          _dualRow("Non Electrical Accessories", calculation?.nonElecAcc?.toStringAsFixed(2), "Return to Invoice", calculation?.returnInvoice?.toStringAsFixed(2)),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2), "Other Addon Coverage", calculation?.otherAddon?.toStringAsFixed(2)),
          _dualRow("Basic OD Premium", calculation?.basicODPri?.toStringAsFixed(2), "Value Added Service", calculation?.valAddService?.toStringAsFixed(2)),
          pw.Row(
            children: [
              _cell("Geographical Ext", flex: 4),
              _cell(calculation?.geoGrapExt?.toStringAsFixed(2) ?? '0.00',
                  align: pw.Alignment.centerRight,
                  flex: 2),
              _cell("Total Addon Premium (B)",
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("Fiber Glass Tank", calculation?.fiberGlass?.toStringAsFixed(2), "", ""),
          pw.Row(children:[
            _cell("Driving Tutions",
                flex: 4),
            _cell(calculation!.drivingTution!.toStringAsFixed(2).toString(),
                align: pw.Alignment.centerRight, flex: 2),
            _cell('(C) Liability Premium', style: boldCell,
                bg: tableHeaderBg, flex: 4),
            _cell('Rupees', style: boldCell,
                align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
          ]),
          _dualRow("Basic OD Before Deductions", calculation?.odBeforeDedu?.toStringAsFixed(2), "Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("Anti Theft", calculation?.antiTheft?.toStringAsFixed(2), "CNG/LPG Kit", calculation?.cngKit?.toStringAsFixed(2)),
          _dualRow("Handicap", calculation?.handiCap?.toStringAsFixed(2), "Geographical Extn", calculation?.geoExt?.toStringAsFixed(2)),
          _dualRow("AAI", calculation?.aai?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("Voluntary Deductible", calculation?.volDedu?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2), "PA to Unnamed Passenger", calculation?.paUnnamed?.toStringAsFixed(2)),
          _dualRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2),"",""),

          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (C)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalC?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B+C)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
  ),
  pw.SizedBox(height: 8),

  // ── Addon / Payment ───────────────────────────────────────────────
  _bottomPDF(vehicleInfo),
  ],
  ),
  );

  shareFunction(title);

}

Future<void>  electricCarCompletePDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
  final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Kilowatt', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.kilowatt ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Addon Coverage', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Zero Depreciation", calculation?.zeroDep?.toStringAsFixed(2)),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2), "RSA/Additional for Addons", calculation?.rsa?.toStringAsFixed(2)),
          _dualRow("Discount on OD Premium", calculation?.disOD?.toStringAsFixed(2), "Consumables", calculation?.consumable?.toStringAsFixed(2)),
          _dualRow("Loading on OD Premium", calculation?.loadingOD?.toStringAsFixed(2), "Tyre Cover", calculation?.tyreCover?.toStringAsFixed(2)),
          _dualRow("Basic OD Premium after Discount/Loading", calculation?.odAfterDis?.toStringAsFixed(2), "NCB Protections", calculation?.ncb?.toStringAsFixed(2)),
          _dualRow("Electrical/Electronic Accessories", calculation?.accessories?.toStringAsFixed(2), "Engine Protection", calculation?.enginePro?.toStringAsFixed(2)),
          _dualRow("Non Electrical Accessories", calculation?.nonElecAcc?.toStringAsFixed(2), "Return to Invoice", calculation?.returnInvoice?.toStringAsFixed(2)),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2), "Other Addon Coverage", calculation?.otherAddon?.toStringAsFixed(2)),
          _dualRow("Basic OD Premium", calculation?.basicODPri?.toStringAsFixed(2), "Value Added Service", calculation?.valAddService?.toStringAsFixed(2)),
          pw.Row(
            children: [
              _cell("Geographical Ext", flex: 4),
              _cell(calculation?.geoGrapExt?.toStringAsFixed(2) ?? '0.00',
                  align: pw.Alignment.centerRight,
                  flex: 2),
              _cell("Total Addon Premium (B)",
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("Fiber Glass Tank", calculation?.fiberGlass?.toStringAsFixed(2), "", ""),
          pw.Row(children:[
            _cell("Driving Tutions",
                flex: 4),
            _cell(calculation!.drivingTution!.toStringAsFixed(2).toString(),
                align: pw.Alignment.centerRight, flex: 2),
            _cell('(C) Liability Premium', style: boldCell,
                bg: tableHeaderBg, flex: 4),
            _cell('Rupees', style: boldCell,
                align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
          ]),
          _dualRow("Basic OD Before Deductions", calculation?.odBeforeDedu?.toStringAsFixed(2), "Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("Anti Theft", calculation?.antiTheft?.toStringAsFixed(2), "CNG/LPG Kit", calculation?.cngKit?.toStringAsFixed(2)),
          _dualRow("Handicap", calculation?.handiCap?.toStringAsFixed(2), "Geographical Extn", calculation?.geoExt?.toStringAsFixed(2)),
          _dualRow("AAI", calculation?.aai?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("Voluntary Deductible", calculation?.volDedu?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2), "PA to Unnamed Passenger", calculation?.paUnnamed?.toStringAsFixed(2)),
          _dualRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2),"",""),

          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (C)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalC?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B+C)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

Future<void>  carryingPublicPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
  final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Addon Coverage', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Zero Depreciation", calculation?.zeroDep?.toStringAsFixed(2)),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2), "RSA/Additional for Addons", data?.rsa.toString()),
          pw.Row(
            children: [
              _cell("Electrical/Electronic Accessories", flex: 4),
              _cell(calculation?.accessories?.toStringAsFixed(2)?? '0.00',
                  align: pw.Alignment.centerRight,
                  flex: 2),
              _cell("Total Addon Premium (B)",
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2), "", ""),
          pw.Row(children:[
            _cell("Basic OD Premium",
                flex: 4),
            _cell(calculation!.basicODPri!.toStringAsFixed(2).toString(),
                align: pw.Alignment.centerRight, flex: 2),
            _cell('(C) Liability Premium', style: boldCell,
                bg: tableHeaderBg, flex: 4),
            _cell('Rupees', style: boldCell,
                align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
          ]),
          _dualRow("Geographical Ext", calculation?.geoGrapExt?.toStringAsFixed(2), "Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("IMT 23", calculation?.imt23?.toStringAsFixed(2), "Restricted TP PD", calculation?.tppd?.toStringAsFixed(2)),
          _dualRow("Anti Theft", calculation?.antiTheft?.toStringAsFixed(2), "CNG/LPG Kit", calculation?.cngKit?.toStringAsFixed(2)),
          _dualRow("Basic OD Before Discount", calculation?.odBeforeDis?.toStringAsFixed(2), "Geographical Ext", calculation?.geoExt?.toStringAsFixed(2)),
          _dualRow("Discount on OD Premium", calculation?.disOD?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2), "LL to Employee other than Paid Driver", calculation?.llEmpPayed?.toStringAsFixed(2)),

          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (C)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalC?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B+C)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 5%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST5?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  taxiPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Addon Coverage', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Zero Depreciation", calculation?.zeroDep?.toStringAsFixed(2)),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2), "RSA/Additional for Addons", data?.rsa.toString()),
          pw.Row(
            children: [
              _cell("Electrical/Electronic Accessories", flex: 4),
              _cell(calculation?.accessories?.toStringAsFixed(2)?? '0.00',
                  align: pw.Alignment.centerRight,
                  flex: 2),
              _cell("Total Addon Premium (B)",
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2), "", ""),
          pw.Row(children:[
            _cell("Basic OD Premium",
                flex: 4),
            _cell(calculation!.basicODPri!.toStringAsFixed(2).toString(),
                align: pw.Alignment.centerRight, flex: 2),
            _cell('(C) Liability Premium', style: boldCell,
                bg: tableHeaderBg, flex: 4),
            _cell('Rupees', style: boldCell,
                align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
          ]),
          _dualRow("Anti Theft", calculation?.antiTheft?.toStringAsFixed(2), "Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("Basic OD Before Discount", calculation?.odBeforeDis?.toStringAsFixed(2), "Passenger Coverage", calculation?.passCov?.toStringAsFixed(2)),
          _dualRow("Discount on OD Premium", calculation?.disOD?.toStringAsFixed(2), "CNG/LPG Kit", calculation?.cngKit?.toStringAsFixed(2)),
          _dualRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),

          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (C)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalC?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B+C)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  electricTaxiPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Kilowatt', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.kilowatt ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Addon Coverage', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Zero Depreciation", calculation?.zeroDep?.toStringAsFixed(2)),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2), "RSA/Additional for Addons", data?.rsa.toString()),
          pw.Row(
            children: [
              _cell("Electrical/Electronic Accessories", flex: 4),
              _cell(calculation?.accessories?.toStringAsFixed(2)?? '0.00',
                  align: pw.Alignment.centerRight,
                  flex: 2),
              _cell("Total Addon Premium (B)",
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2), "", ""),
          pw.Row(children:[
            _cell("Basic OD Premium",
                flex: 4),
            _cell(calculation!.basicODPri!.toStringAsFixed(2).toString(),
                align: pw.Alignment.centerRight, flex: 2),
            _cell('(C) Liability Premium', style: boldCell,
                bg: tableHeaderBg, flex: 4),
            _cell('Rupees', style: boldCell,
                align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
          ]),
          _dualRow("Anti Theft", calculation?.antiTheft?.toStringAsFixed(2), "Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("Basic OD Before Discount", calculation?.odBeforeDis?.toStringAsFixed(2), "Passenger Coverage", calculation?.passCov?.toStringAsFixed(2)),
          _dualRow("Discount on OD Premium", calculation?.disOD?.toStringAsFixed(2), "CNG/LPG Kit", calculation?.cngKit?.toStringAsFixed(2)),
          _dualRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),

          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (C)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalC?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B+C)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  busPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Addon Coverage', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),

          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Zero Depreciation", calculation?.zeroDep?.toStringAsFixed(2)),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2), "RSA/Additional for Addons", data?.rsa.toString()),
          pw.Row(
            children: [
              _cell("Electrical/Electronic Accessories", flex: 4),
              _cell(calculation?.accessories?.toStringAsFixed(2)?? '0.00',
                  align: pw.Alignment.centerRight,
                  flex: 2),
              _cell("Total Addon Premium (B)",
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2), "", ""),
          pw.Row(children:[
            _cell("Basic OD Premium",
                flex: 4),
            _cell(calculation!.basicODPri!.toStringAsFixed(2).toString(),
                align: pw.Alignment.centerRight, flex: 2),
            _cell('(C) Liability Premium', style: boldCell,
                bg: tableHeaderBg, flex: 4),
            _cell('Rupees', style: boldCell,
                align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
          ]),
          _dualRow("Geographical Extn",calculation?. geoGrapExt?.toStringAsFixed(2), "Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("IMT 23", calculation?.imt23?.toStringAsFixed(2), "Passenger Coverage", calculation?.passCov?.toStringAsFixed(2)),
          _dualRow("Anti Theft", calculation?.antiTheft?.toStringAsFixed(2), "Geographical Extn", calculation?.geoExt?.toStringAsFixed(2)),
          _dualRow("Basic OD Before Discount", calculation?.odBeforeDis?.toStringAsFixed(2), "CNG/LPG Kit", calculation?.cngKit?.toStringAsFixed(2)),
          _dualRow("Discount on OD Premium", calculation?.disOnODPre?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2), "LL to Employee other than Paid Driver", calculation?.llEmpPayed?.toStringAsFixed(2)),


          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (C)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalC?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B+C)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  electricBusPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Kilowatt', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.kilowatt ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Addon Coverage', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),

          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Zero Depreciation", calculation?.zeroDep?.toStringAsFixed(2)),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2), "RSA/Additional for Addons", data?.rsa.toString()),
          pw.Row(
            children: [
              _cell("Electrical/Electronic Accessories", flex: 4),
              _cell(calculation?.accessories?.toStringAsFixed(2)?? '0.00',
                  align: pw.Alignment.centerRight,
                  flex: 2),
              _cell("Total Addon Premium (B)",
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2), "", ""),
          pw.Row(children:[
            _cell("Basic OD Premium",
                flex: 4),
            _cell(calculation!.basicODPri!.toStringAsFixed(2).toString(),
                align: pw.Alignment.centerRight, flex: 2),
            _cell('(C) Liability Premium', style: boldCell,
                bg: tableHeaderBg, flex: 4),
            _cell('Rupees', style: boldCell,
                align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
          ]),
          _dualRow("Geographical Extn",calculation?. geoGrapExt?.toStringAsFixed(2), "Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("IMT 23", calculation?.imt23?.toStringAsFixed(2), "Passenger Coverage", calculation?.passCov?.toStringAsFixed(2)),
          _dualRow("Anti Theft", calculation?.antiTheft?.toStringAsFixed(2), "Geographical Extn", calculation?.geoExt?.toStringAsFixed(2)),
          _dualRow("Basic OD Before Discount", calculation?.odBeforeDis?.toStringAsFixed(2), "CNG/LPG Kit", calculation?.cngKit?.toStringAsFixed(2)),
          _dualRow("Discount on OD Premium", calculation?.disOnODPre?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2), "LL to Employee other than Paid Driver", calculation?.llEmpPayed?.toStringAsFixed(2)),


          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (C)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalC?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B+C)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  schoolBusPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Addon Coverage', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),

          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Zero Depreciation", calculation?.zeroDep?.toStringAsFixed(2)),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2), "RSA/Additional for Addons", data?.rsa.toString()),
          pw.Row(
            children: [
              _cell("Electrical/Electronic Accessories", flex: 4),
              _cell(calculation?.accessories?.toStringAsFixed(2)?? '0.00',
                  align: pw.Alignment.centerRight,
                  flex: 2),
              _cell("Total Addon Premium (B)",
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2), "", ""),
          pw.Row(children:[
            _cell("Basic OD Premium",
                flex: 4),
            _cell(calculation!.basicODPri!.toStringAsFixed(2).toString(),
                align: pw.Alignment.centerRight, flex: 2),
            _cell('(C) Liability Premium', style: boldCell,
                bg: tableHeaderBg, flex: 4),
            _cell('Rupees', style: boldCell,
                align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
          ]),
          _dualRow("Geographical Extn",calculation?. geoGrapExt?.toStringAsFixed(2), "Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("IMT 23", calculation?.imt23?.toStringAsFixed(2), "Passenger Coverage", calculation?.passCov?.toStringAsFixed(2)),
          _dualRow("Anti Theft", calculation?.antiTheft?.toStringAsFixed(2), "Geographical Extn", calculation?.geoExt?.toStringAsFixed(2)),
          _dualRow("Basic OD Before Discount", calculation?.odBeforeDis?.toStringAsFixed(2), "CNG/LPG Kit", calculation?.cngKit?.toStringAsFixed(2)),
          _dualRow("Discount on OD Premium", calculation?.disOnODPre?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2), "LL to Employee other than Paid Driver", calculation?.llEmpPayed?.toStringAsFixed(2)),


          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (C)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalC?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B+C)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  electricSchoolBusPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Kilowatt', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.kilowatt ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Addon Coverage', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),

          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Zero Depreciation", calculation?.zeroDep?.toStringAsFixed(2)),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2), "RSA/Additional for Addons", data?.rsa.toString()),
          pw.Row(
            children: [
              _cell("Electrical/Electronic Accessories", flex: 4),
              _cell(calculation?.accessories?.toStringAsFixed(2)?? '0.00',
                  align: pw.Alignment.centerRight,
                  flex: 2),
              _cell("Total Addon Premium (B)",
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2), "", ""),
          pw.Row(children:[
            _cell("Basic OD Premium",
                flex: 4),
            _cell(calculation!.basicODPri!.toStringAsFixed(2).toString(),
                align: pw.Alignment.centerRight, flex: 2),
            _cell('(C) Liability Premium', style: boldCell,
                bg: tableHeaderBg, flex: 4),
            _cell('Rupees', style: boldCell,
                align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
          ]),
          _dualRow("Geographical Extn",calculation?. geoGrapExt?.toStringAsFixed(2), "Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("IMT 23", calculation?.imt23?.toStringAsFixed(2), "Passenger Coverage", calculation?.passCov?.toStringAsFixed(2)),
          _dualRow("Anti Theft", calculation?.antiTheft?.toStringAsFixed(2), "Geographical Extn", calculation?.geoExt?.toStringAsFixed(2)),
          _dualRow("Basic OD Before Discount", calculation?.odBeforeDis?.toStringAsFixed(2), "CNG/LPG Kit", calculation?.cngKit?.toStringAsFixed(2)),
          _dualRow("Discount on OD Premium", calculation?.disOnODPre?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2), "LL to Employee other than Paid Driver", calculation?.llEmpPayed?.toStringAsFixed(2)),


          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (C)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalC?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B+C)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  threeWheelerGoodsPublicPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Liability Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),


          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2), "Restricted TPPD", calculation?.tppd?.toStringAsFixed(2)),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2), "CNG/LPG Kit", calculation?.cngKit?.toStringAsFixed(2)),
          _dualRow("Basic OD Premium", calculation?.basicODPri?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("IMT 23", calculation?.imt23?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _odRow("Basic OD Before Discount", calculation?.odBeforeDis?.toStringAsFixed(2)),
          _odRow("Discount on OD Premium", calculation?.disOnODPre?.toStringAsFixed(2)),
          _odRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2)),
          _odRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2)),


          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (B)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 5%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST5?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  threeWheelerPCVPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Liability Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),

          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Liability Premium (TP)", calculation?.liability.toString()),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2), "Passenger Coverage", calculation?.passCov?.toStringAsFixed(2)),
          _dualRow("Electrical/Electronic Accessories", calculation?.accessories?.toStringAsFixed(2), "CNG/LPG Kit", calculation?.cngKit?.toStringAsFixed(2)),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("Basic OD Premium", calculation?.basicODPri?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("IMT 23", calculation?.imt23?.toStringAsFixed(2), "Restricted TP PD", calculation?.tppd?.toStringAsFixed(2)),
          _odRow("Basic OD Before Discount", calculation?.odBeforeDis?.toStringAsFixed(2)),
          _odRow("Discount on OD Premium", calculation?.disOnODPre?.toStringAsFixed(2)),
          _odRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2)),
          _odRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2)),


          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (B)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  threeWheelerPCVMorePDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Liability Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),

          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Liability Premium (TP)", calculation?.liability.toString()),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2), "Passenger Coverage", calculation?.passCov?.toStringAsFixed(2)),
          _dualRow("Electrical/Electronic Accessories", calculation?.accessories?.toStringAsFixed(2), "CNG/LPG Kit", calculation?.cngKit?.toStringAsFixed(2)),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("Basic OD Premium", calculation?.basicODPri?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("IMT 23", calculation?.imt23?.toStringAsFixed(2), "Restricted TP PD", calculation?.tppd?.toStringAsFixed(2)),
          _odRow("Basic OD Before Discount", calculation?.odBeforeDis?.toStringAsFixed(2)),
          _odRow("Discount on OD Premium", calculation?.disOnODPre?.toStringAsFixed(2)),
          _odRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2)),
          _odRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2)),


          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (B)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  eRickshawGoodsPrivatePDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Kilowatt', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.kilowatt ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Addon Coverage', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),

          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Value Added Service", data?.valAddService),
          pw.Row(
            children: [
              _cell("Basic for Vehicle", flex: 4),
              _cell(calculation?.basicVehicle?.toStringAsFixed(2)?? '0.00',
                  align: pw.Alignment.centerRight,
                  flex: 2),
              _cell("Total Addon Premium (B)",
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("Electrical/Electronic Accessories", calculation?.accessories?.toStringAsFixed(2), "", ""),
          pw.Row(children:[
            _cell("Basic OD Premium",
                flex: 4),
            _cell(calculation!.basicODPri!.toStringAsFixed(2).toString(),
                align: pw.Alignment.centerRight, flex: 2),
            _cell('(C) Liability Premium', style: boldCell,
                bg: tableHeaderBg, flex: 4),
            _cell('Rupees', style: boldCell,
                align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
          ]),
          _dualRow("IMT 23", calculation?.imt23?.toStringAsFixed(2),"Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2) ),
          _dualRow("Basic OD Before Discount", calculation?.odBeforeDis?.toStringAsFixed(2), "Restricted TPPD", calculation?.tppd?.toStringAsFixed(2)),
          _dualRow("Discount on OD Premium", calculation?.disOnODPre?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("Loading on OD Premium", calculation?.loadingOD?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _odRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2)),
          _odRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2)),

          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (C)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalC?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B+C)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  eRickshawGoodsPublicPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Kilowatt', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.kilowatt ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Addon Coverage', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),

          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Value Added Service", data?.valAddService),
          pw.Row(
            children: [
              _cell("Basic for Vehicle", flex: 4),
              _cell(calculation?.basicVehicle?.toStringAsFixed(2)?? '0.00',
                  align: pw.Alignment.centerRight,
                  flex: 2),
              _cell("Total Addon Premium (B)",
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("Electrical/Electronic Accessories", calculation?.accessories?.toStringAsFixed(2), "", ""),
          pw.Row(children:[
            _cell("Basic OD Premium",
                flex: 4),
            _cell(calculation!.basicODPri!.toStringAsFixed(2).toString(),
                align: pw.Alignment.centerRight, flex: 2),
            _cell('(C) Liability Premium', style: boldCell,
                bg: tableHeaderBg, flex: 4),
            _cell('Rupees', style: boldCell,
                align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
          ]),
          _dualRow("IMT 23", calculation?.imt23?.toStringAsFixed(2),"Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2) ),
          _dualRow("Basic OD Before Discount", calculation?.odBeforeDis?.toStringAsFixed(2), "Restricted TPPD", calculation?.tppd?.toStringAsFixed(2)),
          _dualRow("Discount on OD Premium", calculation?.disOnODPre?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("Loading on OD Premium", calculation?.loadingOD?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _odRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2)),
          _odRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2)),

          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (C)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalC?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B+C)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  eRickshawPassengerPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Kilowatt', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.kilowatt ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Addon Coverage', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),

          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Value Added Service", data?.valAddService),
          pw.Row(
            children: [
              _cell("Basic for Vehicle", flex: 4),
              _cell(calculation?.basicVehicle?.toStringAsFixed(2)?? '0.00',
                  align: pw.Alignment.centerRight,
                  flex: 2),
              _cell("Total Addon Premium (B)",
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("Electrical/Electronic Accessories", calculation?.accessories?.toStringAsFixed(2), "", ""),
          pw.Row(children:[
            _cell("Basic OD Premium",
                flex: 4),
            _cell(calculation!.basicODPri!.toStringAsFixed(2).toString(),
                align: pw.Alignment.centerRight, flex: 2),
            _cell('(C) Liability Premium', style: boldCell,
                bg: tableHeaderBg, flex: 4),
            _cell('Rupees', style: boldCell,
                align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
          ]),
          _dualRow("IMT 23", calculation?.imt23?.toStringAsFixed(2),"Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2) ),
          _dualRow("Basic OD Before Discount", calculation?.odBeforeDis?.toStringAsFixed(2), "Passenger Coverage", calculation?.passCov?.toStringAsFixed(2)),
          _dualRow("Loading on OD Premium", calculation?.loadingOD?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _odRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2)),

          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (C)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalC?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B+C)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  ambulancePDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Liability Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),



          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2), "Restricted TPPD", calculation?.tppd?.toStringAsFixed(2)),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2), "CNG/LPG Kit", calculation?.cngKit?.toStringAsFixed(2)),
          _dualRow("Basic OD Premium", calculation?.basicODPri?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("IMT 23", calculation?.imt23?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("Basic OD Before Discount", calculation?.odBeforeDis?.toStringAsFixed(2), "LL Employee other than Paid Driver", data?.llEmpPayed),
          _dualRow("Discount on OD Premium", calculation?.disOnODPre?.toStringAsFixed(2), "LL to Passengers", calculation?.llPassenger?.toStringAsFixed(2)),
          _odRow("Loading on OD Premium", calculation?.loadingOD?.toStringAsFixed(2)),
          _odRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2)),
          _odRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2)),


          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (B)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  hearsesPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Liability Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),


          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2), "Restricted TPPD", calculation?.tppd?.toStringAsFixed(2)),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2), "CNG/LPG Kit", calculation?.cngKit?.toStringAsFixed(2)),
          _dualRow("Basic OD Premium", calculation?.basicODPri?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("IMT 23", calculation?.imt23?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("Basic OD Before Discount", calculation?.odBeforeDis?.toStringAsFixed(2), "LL Employee other than Paid Driver", data?.llEmpPayed),
          _dualRow("Discount on OD Premium", calculation?.disOnODPre?.toStringAsFixed(2), "LL to Passengers", calculation?.llPassenger?.toStringAsFixed(2)),
          _odRow("Loading on OD Premium", calculation?.loadingOD?.toStringAsFixed(2)),
          _odRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2)),
          _odRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2)),


          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (B)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  tractorPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Liability Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),


          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Liability Premium (TP)", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2), "Restricted TPPD", calculation?.tppd?.toStringAsFixed(2)),
          _dualRow("CNG/LPG Kit (Externally Fitted)", calculation?.cngExt?.toStringAsFixed(2), "CNG/LPG Kit", calculation?.cngKit?.toStringAsFixed(2)),
          _dualRow("Basic OD Premium", calculation?.basicODPri?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("IMT 23", calculation?.imt23?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("Basic OD Before Discount", calculation?.odBeforeDis?.toStringAsFixed(2), "LL Employee other than Paid Driver", data?.llEmpPayed),
          _dualRow("Discount on OD Premium", calculation?.disOnODPre?.toStringAsFixed(2), "LL to Passengers", calculation?.llPassenger?.toStringAsFixed(2)),
          _odRow("Loading on OD Premium", calculation?.loadingOD?.toStringAsFixed(2)),
          _odRow("Basic OD Before NCB", calculation?.odBeforeNCB?.toStringAsFixed(2)),
          _odRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2)),


          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (B)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 5%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST5?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  miscPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Liability Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),


          _dualRow("Vehicle Basic Rate", calculation?.vehicleBasicRate.toString(), "Liability Premium (TP)", calculation?.liability.toString()),
          _dualRow("Basic for Vehicle", calculation?.basicVehicle?.toStringAsFixed(2), "Geographical Ext", calculation?.geoExt?.toStringAsFixed(2)),
          _dualRow("Discount on OD Premium", calculation?.disOnODPre?.toStringAsFixed(2), "PA to Owner Drive", data?.paOwnerDriver),
          _dualRow("Basic OD After Discount", calculation?.odAfterDis?.toStringAsFixed(2), "LL to Paid Driver", data?.llPaidDriver),
          _dualRow("Geographical Ext", calculation?.geoGrapExt?.toStringAsFixed(2), "LL Employee other than Paid Driver", data?.llEmpPayed),
          _odRow("Overturning for Cranes", calculation?.overCranes?.toStringAsFixed(2)),
          _odRow("IMT 23", calculation?.imt23?.toStringAsFixed(2)),
          _odRow("Total Own Damage Premium", calculation?.odBeforeNCB?.toStringAsFixed(2)),
          _odRow("No Claim Bonus", calculation?.noClaim?.toStringAsFixed(2)),

          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (B)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Premium before GST (A+B)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('GST @ 18%', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.GST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Other Cess', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.cess?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void> privateCarComprehensivePDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Liability Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),


          _dualRow("Basic OD Rate", calculation?.vehicleBasicRate.toString(), "Nil Depreciation", calculation?.nilDep?.toStringAsFixed(2)),
          _dualRow("Basic OD Premium", calculation?.basicVehicle?.toStringAsFixed(2), "Nil Dep Addon", calculation?.nilDepAddon?.toStringAsFixed(2)),
          pw.Row(
            children: [
              _cell("Basic OD Discount", flex: 4),
              _cell(calculation?.basicODDis?.toStringAsFixed(2)?? '0.00',
                  align: pw.Alignment.centerRight,
                  flex: 2),
              _cell("Nil Dep Premium (B)",
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          _dualRow("CNG/LPG Kit", calculation?.cngExt?.toStringAsFixed(2), "", ""),
          pw.Row(children:[
            _cell("Electrical/Electronic Accessories",
                flex: 4),
            _cell(calculation!.accessories!.toStringAsFixed(2).toString(),
                align: pw.Alignment.centerRight, flex: 2),
            _cell("(C) Third Party Coverage", style: boldCell,
                bg: tableHeaderBg, flex: 4),
            _cell('Rupees', style: boldCell,
                align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
          ]),
          _dualRow("Basic OD Discount", calculation?.basicODDis?.toStringAsFixed(2), "Nil Dep Premium (B)", calculation?.totalB?.toStringAsFixed(2)),
          _dualRow("CNG/LPG Kit", calculation?.cngExt?.toStringAsFixed(2), "", ""),
          _dualRow("Electrical/Electronic Accessories", calculation?.accessories?.toStringAsFixed(2), "(C) Third Party Coverage", "Rupees"),
          _dualRow("Non Electrical Accessories", calculation?.nonElecAcc?.toStringAsFixed(2), "Basic TP", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("No Claim Bonus (${data?.noClaimBonus})", calculation?.noClaim?.toStringAsFixed(2), "TPPD Restriction", calculation?.tppd?.toStringAsFixed(2)),
          _dualRow("", "", "CNG/LPG Kit TP", calculation?.cngKit?.toStringAsFixed(2)),
          _dualRow("", "", "PA Owner", calculation?.paOwner?.toStringAsFixed(2)),
          _dualRow("", "", "LL Driver", calculation?.llDriver?.toStringAsFixed(2)),
          _dualRow("","", "Unnamed PA", calculation?.paUnnamed?.toStringAsFixed(2)),

          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (C)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalC?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Net Premium (A+B+C)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('CGST', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.CGST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('SGST', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.SGST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special OD Discount", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialODDis?.toStringAsFixed(2).toString() ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special TP Discount", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialTPDis?.toStringAsFixed(2).toString() ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special NP Discount", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialNPDis?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special Discount Amount", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialDisAmt?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special Price", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialDisPrice?.round().toString() ?? '0.00', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void>  privateCarSAODPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Liability Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),


          _dualRow("Basic OD Rate", calculation?.vehicleBasicRate.toString(), "Nil Depreciation", calculation?.nilDep?.toStringAsFixed(2)),
          _dualRow("Basic OD Premium", calculation?.basicVehicle?.toStringAsFixed(2), "Nil Dep Addon", calculation?.nilDepAddon?.toStringAsFixed(2)),
          _odRow("Basic OD Discount", calculation?.basicODDis?.toStringAsFixed(2)),
          _odRow("CNG/LPG Kit", calculation?.cngExt?.toStringAsFixed(2)),
          _odRow("Electrical/Electronic Accessories", calculation?.accessories?.toStringAsFixed(2)),
          _odRow("Non Electrical Accessories", calculation?.nonElecAcc?.toStringAsFixed(2)),
          _odRow("No Claim Bonus (${data?.noClaimBonus})", calculation?.noClaim?.toStringAsFixed(2)),

          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (B)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Net Premium (A+B)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('CGST', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.CGST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('SGST', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.SGST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special NP Discount", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialNPDis?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special Discount Amount", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialDisAmt?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special Price", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialDisPrice?.round().toString() ?? '0.00', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void> privateCarTPPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),


          _odRow("Basic TP", calculation?.liability?.toStringAsFixed(2)),
          _odRow("TPPD Restriction", calculation?.tppd?.toStringAsFixed(2)),
          _odRow("CNG/LPG Kit TP", calculation?.cngKit?.toStringAsFixed(2)),
          _odRow("PA Owner", calculation?.paOwner?.toStringAsFixed(2)),
          _odRow("LL Driver", calculation?.llDriver?.toStringAsFixed(2)),
          _odRow("Unnamed PA", calculation?.paUnnamed?.toStringAsFixed(2)),

          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Net Premium (A)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('CGST', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.CGST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('SGST', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.SGST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),

              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special NP Discount", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialNPDis?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special Discount Amount", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialDisAmt?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special Price", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialDisPrice?.round().toString() ?? '0.00', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void> trailerComprehensivePDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Own Damage Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
              _cell('(B) Liability Premium', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),


          _dualRow("Basic OD Rate", calculation?.vehicleBasicRate.toString(), "Basic TP", calculation?.liability?.toStringAsFixed(2)),
          _dualRow("Trailer OD", calculation?.trailerOD?.toStringAsFixed(2), "TPPD Restriction", calculation?.tppd?.toStringAsFixed(2)),
          _odRow("Basic OD Discount", calculation?.basicODDis?.toStringAsFixed(2)),
          _odRow("IMT 23", calculation?.imt23?.toStringAsFixed(2)),
          _odRow("No Claim Bonus (${data?.noClaimBonus})", calculation?.noClaim?.toStringAsFixed(2)),

          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
              _cell('Total Liability Premium (B)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalB?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Net Premium (A+B)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              if(data?.vehiclePurpose == "Agricultural")
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('CGST', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.CGST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              if(data?.vehiclePurpose == "Agricultural")
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('SGST', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.SGST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              if(data?.vehiclePurpose == "Commercial")
                pw.TableRow(children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text("GST @ 5", style: boldCell)),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(calculation?.CGST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
                ]),
              if(data?.vehiclePurpose == "Commercial")
                pw.TableRow(children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text("GST @ 18", style: boldCell)),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(calculation?.SGST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
                ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special OD Discount", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialODDis?.toStringAsFixed(2).toString() ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special TP Discount", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialTPDis?.toStringAsFixed(2).toString() ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special NP Discount", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialNPDis?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special Discount Amount", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialDisAmt?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special Price", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialDisPrice?.round().toString() ?? '0.00', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

  Future<void> trailerTPPDF(String title,VehicleInfoModel? vehicleInfo, TwoWheelerPremiumModel? data, CalculationModel? calculation) async {
    final theme = await waterMark();
    pdf.addPage(
      pw.MultiPage(pageTheme: theme,
        build: (pw.Context ctx) => [

          // ── Company Name ──────────────────────────────────────────────────
          pw.Text(
            vehicleInfo!.insuranceCompany.toString(),
            style: companyStyle,
          ),
          pw.Divider(thickness: 1.5, color: headerBlue),
          pw.SizedBox(height: 4),

          // ── Doc title & period ────────────────────────────────────────────
          pw.Center(child: pw.Text(title, style: titleStyle)),
          pw.SizedBox(height: 8),

          // ── Vehicle Info Table ────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(3),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Vehicle Make', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.make ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Model', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.model ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Registration No.', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(vehicleInfo.regNo ?? '', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Passengers', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.noPassenger ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('IDV of the Vehicle', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.idv ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Year of Manufacture', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.yearOfManufacture ?? '', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Cubic Capacity', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.cubieCapacity ?? '0', style: cellStyle)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Zone', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(data?.zone ?? 'A', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Premium Table Header ──────────────────────────────────────────
          pw.Row(
            children: [
              _cell('(A) Third Party Coverage', style: boldCell,
                  bg: tableHeaderBg, flex: 4),
              _cell('Rupees', style: boldCell,
                  align: pw.Alignment.centerRight, bg: tableHeaderBg, flex: 2),
            ],
          ),


          _odRow("Basic TP", calculation?.liability?.toStringAsFixed(2)),
          _odRow("TPPD Restriction", calculation?.tppd?.toStringAsFixed(2)),

          // ── Net OD | Total Liability ──────────────────────────────────────
          pw.Row(
            children: [
              _cell('Net Own Damage Premium (A)',
                  style: boldCell, bg: tableHeaderBg, flex: 4),
              _cell(calculation?.totalA?.toStringAsFixed(2) ?? '0.00',
                  style: boldCell, align: pw.Alignment.centerRight,
                  bg: tableHeaderBg, flex: 2),
            ],
          ),
          pw.SizedBox(height: 6),

          // ── Summary Box ───────────────────────────────────────────────────
          pw.Table(
            border: pw.TableBorder.all(color: borderColor, width: 0.4),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text('Net Premium (A)', style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.totalABC?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              if(data?.vehiclePurpose == "Agricultural")
                pw.TableRow(children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('CGST', style: boldCell)),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(calculation?.CGST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
                ]),
              if(data?.vehiclePurpose == "Agricultural")
                pw.TableRow(children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('SGST', style: boldCell)),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(calculation?.SGST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
                ]),
              if(data?.vehiclePurpose == "Commercial")
                pw.TableRow(children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text("GST @ 5", style: boldCell)),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(calculation?.CGST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
                ]),
              if(data?.vehiclePurpose == "Commercial")
                pw.TableRow(children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text("GST @ 18", style: boldCell)),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(calculation?.SGST?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
                ]),
              pw.TableRow(
                decoration: pw.BoxDecoration(color: tableHeaderBg),
                children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text('Final Premium',
                          style: pw.TextStyle(fontSize: 9,
                              fontWeight: pw.FontWeight.bold, color: accentRed))),
                  pw.Padding(padding: const pw.EdgeInsets.all(3),
                      child: pw.Text(
                        calculation?.finalTotal?.round().toString() ?? '0',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                      )),
                ],
              ),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special OD Discount", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialODDis?.toStringAsFixed(2).toString() ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special TP Discount", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialTPDis?.toStringAsFixed(2).toString() ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special NP Discount", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialNPDis?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special Discount Amount", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialDisAmt?.toStringAsFixed(2) ?? '0.00', style: cellStyle)),
              ]),
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text("Special Price", style: boldCell)),
                pw.Padding(padding: const pw.EdgeInsets.all(3),
                    child: pw.Text(calculation?.specialDisPrice?.round().toString() ?? '0.00', style: cellStyle)),
              ]),
            ],
          ),
          pw.SizedBox(height: 8),

          // ── Addon / Payment ───────────────────────────────────────────────
          _bottomPDF(vehicleInfo),
        ],
      ),
    );

    shareFunction(title);

  }

}
