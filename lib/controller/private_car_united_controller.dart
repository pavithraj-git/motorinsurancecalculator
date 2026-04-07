import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivateCarUnitedController extends GetxController {
  final idvController = TextEditingController(text: "0").obs;
  final currentIDVController = TextEditingController(text: "0").obs;
  final yearManuFactureController = TextEditingController(text: "2000").obs;
  final odPremiumController = TextEditingController(text: "0").obs;
  final accessoriesController = TextEditingController(text: "0").obs;
  final paUnnameController = TextEditingController(text: "0").obs;
  final otherCessController = TextEditingController(text: "0").obs;
  final nonElectAccController = TextEditingController(text: "0").obs;
  final cngExtController = TextEditingController(text: "0").obs;
  final engineProController = TextEditingController(text: "0").obs;
  final cubicController = TextEditingController(text: "0").obs;
  final noPassengersController = TextEditingController(text: "0").obs;
  final addTowingController = TextEditingController(text: "0").obs;

  List<String> odTermList = ["1", "0", "3"];
  List<String> tpTermList = ["0", "1", "3"];
  List<String> depreciationList = ["0", "5", "10", "15", "20", "25", "30"];
  List<String> ageVehicleList = ["0 to 1 Year", "1 to 2 Year", "2 to 3 Year", "3 to 4 Year", "4 to 5 Year", "More than 5 Year"];
  List<String> zoneList = ["A", "B"];
  List<String> cngList = ["Yes", "No"];
  List<String> fiberGlassList = ["Yes", "No"];
  List<String> autoMemberList = ["Yes", "No"];
  List<String> paOwnerList = ["275", "825", "0"];
  List<String> antiTheftList = ["Yes", "No"];
  List<String> nilDepList = ["Yes", "No"];
  List<String> returnInvoiceList = ["Yes", "No"];
  List<String> consumableProList = ["Yes", "No"];
  List<String> noClaimBonusList = ["0", "20", "25", "35", "45", "50"];
  List<String> tppdList = ["Yes", "No"];
  List<String> llPayedList = ["0", "50"];
  List<String> loseKeyCoverList = ["0", "10000", "25000"];
  List<String> platinumList = ["0","1500000", "1000000", "500000"];
  List<String> tyreRimProList = ["0", "25000", "50000", "100000", "200000"];
  List<String> petCareList = ["0", "10000", "25000", "50000"];
  List<String> medicalExList = ["0", "50000", "100000"];
  List<String> engineProProList = ["No", "Standard", "Platinum"];
  List<String> courtesyCarList = ["0 Days", "3 Days", "5 Days", "7 Days"];
  List<String> personalEffectList = ["0", "5000", "10000"];

  String? odTerm = "1";
  String? tpTerm = "1";
  String? llPayed = "0";
  String? cng = "No";
  String? fiberGlass= "No";
  String? autoMember = "No";
  String? paOwner = "0";
  String? antiTheft = "No";
  String? nilDep = "No";
  String? returnInvoice = "No";
  String? consumablePro = "No";
  String? noClaimBonus = "0";
  String? tppd = "No";
  String? zone = "A";
  String? ageVehicle = "0 to 1 Year";
  String? depreciation = "0";
  String? loseKeyCover = "0";
  String? platinum = "0";
  String? tyreRimPro= "0";
  String? petCare = "0";
  String? medicalEx = "0";
  String? enginePro =  "No";
  String? courtesyCar = "0 Days";
  String? personalEffect = "0";




}