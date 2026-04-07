import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivateCarOrientalController extends GetxController {
  final idvController = TextEditingController(text: "0").obs;
  final currentIDVController = TextEditingController(text: "0").obs;
  final yearManuFactureController = TextEditingController(text: "2000").obs;
  final odPremiumController = TextEditingController(text: "0").obs;
  final accessoriesController = TextEditingController(text: "0").obs;
  final paUnnameController = TextEditingController(text: "0").obs;
  final otherCessController = TextEditingController(text: "0").obs;
  final nonElectAccController = TextEditingController(text: "0").obs;
  final cngExtController = TextEditingController(text: "0").obs;
  final cubicController = TextEditingController(text: "0").obs;
  final otherAddonController = TextEditingController(text: "0").obs;
  final disNilDepontroller = TextEditingController(text: "0").obs;

  List<String> odTermList = ["1"];
  List<String> tpTermList = ["0", "1", "3"];
  List<String> depreciationList = ["0", "5", "10", "15", "20", "25", "30"];
  List<String> ageVehicleList = ["0 to 6 Month", "6 Month to 1 Year", "1 Year to 1.5 Year", "1.5 year to 2 Year", "2 Year to 3 Year", "3 Year to 4 Year", "4 Year to 5 Year", "5 Year to 6 Year", "6 Year to 7 Year", "7 Year to 10 Year", "Above 10 Year"];
  List<String> zoneList = ["A", "B"];
  List<String> fuelList = ["Diesel", "Petrol"];
  List<String> cngList = ["Yes", "No"];
  List<String> geoGrapList = ["Yes", "No"];
  List<String> nilDepList = ["No", "Yes"];
  List<String> consumableProList = ["Yes", "No"];
  List<String> ncbList = ["Yes", "No"];
  List<String> addTowingList = ["0", "10000", "15000", "20000"];
  List<String> engineProProList = ["No", "With Zero Dep Benefit on Parts", "Without Zero Dep Benefit on Parts"];
  List<String> keyRepCoverList = ["Yes", "No"];
  List<String> noClaimBonusList = ["0", "20", "25", "35", "45", "50"];
  List<String> tppdList = ["Yes", "No"];
  List<String> llPayedList = ["0", "50", "150"];
  List<String> paOwnerList = ["0", "320", "900"];
  List<String> personalEffectList = ["0", "5000", "10000"];
  List<String> returnInvoiceList = ["Yes", "No"];
  List<String> firstPurchaseList = ["Up to 600000", "600001 - 1200000", "1200001 - 2500000", "Above 2500000"];

  String? odTerm = "1";
  String? tpTerm = "1";
  String? llPayed = "0";
  String? fuel = "Diesel";
  String? cng = "No";
  String? geoGrap = "No";
  String? personalEffect = "0";
  String? returnInvoice = "No";
  String? nilDep = "No";
  String? consumablePro = "No";
  String? addTowing = "0";
  String? enginePro = "No";
  String? noClaimBonus = "0";
  String? tppd = "No";
  String? zone = "A";
  String? ageVehicle = "0 to 6 Month";
  String? depreciation = "0";
  String? paOwner = "0";
  String? keyRepCover = "No";
  String? firstPurchase = "Up to 600000";




}