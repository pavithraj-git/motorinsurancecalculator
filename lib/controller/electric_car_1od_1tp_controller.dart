import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElectricCar1OD1TPController extends GetxController {
  final idvController = TextEditingController(text: "0").obs;
  final currentIDVController = TextEditingController(text: "0").obs;
  final yearManuFactureController = TextEditingController(text: "2000").obs;
  final odPremiumController = TextEditingController(text: "0").obs;
  final loadingDisPreController = TextEditingController(text: "0").obs;
  final accessoriesController = TextEditingController(text: "0").obs;
  final zeroDepController = TextEditingController(text: "0").obs;
  final rsaController = TextEditingController(text: "0").obs;
  final addonChargeController = TextEditingController(text: "0").obs;
  final valAddServiceController = TextEditingController(text: "0").obs;
  final paOwnerController = TextEditingController(text: "0").obs;
  final paUnnameController = TextEditingController(text: "0").obs;
  final otherCessController = TextEditingController(text: "0").obs;
  final nonElectAccController = TextEditingController(text: "0").obs;
  final cngExtController = TextEditingController(text: "0").obs;
  final consumablesController = TextEditingController(text: "0").obs;
  final TyreCoverController = TextEditingController(text: "0").obs;
  final ncbController = TextEditingController(text: "0").obs;
  final engineProController = TextEditingController(text: "0").obs;
  final returnInvoiceController = TextEditingController(text: "0").obs;
  final kilowattController = TextEditingController(text: "0").obs;

  List<String> odTermList = ["1"];
  List<String> tpTermList = ["1"];
  List<String> depreciationList = ["0", "5", "10", "15", "20", "25", "30"];
  List<String> ageVehicleList = ["Upto 5 Year", "6 to 10 Year", "Above 10 Year"];
  List<String> zoneList = ["A", "B"];
  List<String> cngList = ["Yes", "No"];
  List<String> geoGrapList = ["0", "400"];
  List<String> fiberGlassList = ["Yes", "No"];
  List<String> drivingTutionsList = ["Yes", "No"];
  List<String> antiTheftList = ["Yes", "No"];
  List<String> handiCapList = ["Yes", "No"];
  List<String> aaiList = ["Yes", "No"];
  List<String> volDeductList = ["0", "500", "750", "1000", "1500", "3000"];
  List<String> noClaimBonusList = ["0", "20", "25", "35", "45", "50"];
  List<String> tppdList = ["Yes", "No"];
  List<String> llPayedList = ["0", "50"];

  String? odTerm = "1";
  String? tpTerm = "1";
  String? geoGrap = "0";
  String? llPayed = "0";
  String? cng = "No";
  String? fiberGlass= "No";
  String? drivingTutions = "No";
  String? antiTheft = "No";
  String? handiCap = "No";
  String? aai = "No";
  String? volDeduct = "0";
  String? noClaimBonus = "0";
  String? tppd = "No";
  String? zone = "A";
  String? ageVehicle = "Upto 5 Year";
  String? depreciation = "0";




}