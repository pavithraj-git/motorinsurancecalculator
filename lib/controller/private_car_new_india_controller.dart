import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivateCarNewIndiaController extends GetxController {
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
  final roadTaxCoverController = TextEditingController(text: "0").obs;
  final addTowingController = TextEditingController(text: "0").obs;
  final lossContentController = TextEditingController(text: "0").obs;
  final returnInvoiceController = TextEditingController(text: "0").obs;

  List<String> odTermList = ["1"];
  List<String> tpTermList = ["0", "1", "3"];
  List<String> depreciationList = ["0", "5", "10", "15", "20", "25", "30"];
  List<String> ageVehicleList = ["Upto 5 Year", "6 to 10 Year", "Above 10 Year"];
  List<String> vehicleAgeList = ["0 Days to 1 Year", "1 Years to 2 Years", "2 Years to 3 Years", "3 Years to 4 Years","4 Years to 5 Years", "5 Years to 6 Years", "6 Years to 7 Years", "More than 7 Years"];
  List<String> zoneList = ["A", "B"];
  List<String> cngList = ["Yes", "No"];
  List<String> nilDepList = ["No", "Yes"];
  List<String> consumableProList = ["Yes", "No"];
  List<String> ncbList = ["Yes", "No"];
  List<String> engineProProList = ["No", "With Zero Dep Benefit on Parts", "Without Zero Dep Benefit on Parts"];
  List<String> keyRepCoverList = ["Yes", "No"];
  List<String> noClaimBonusList = ["0", "20", "25", "35", "45", "50"];
  List<String> tppdList = ["Yes", "No"];
  List<String> llPayedList = ["0", "50", "150"];
  List<String> paOwnerList = ["0", "275", "780"];

  String? odTerm = "1";
  String? tpTerm = "1";
  String? llPayed = "0";
  String? cng = "No";
  String? nilDep = "No";
  String? consumablePro = "No";
  String? ncb = "No";
  String? enginePro = "No";
  String? noClaimBonus = "0";
  String? tppd = "No";
  String? zone = "A";
  String? ageVehicle = "Upto 5 Year";
  String? vehicleAge = "0 Days to 1 Year";
  String? depreciation = "0";
  String? paOwner = "0";
  String? keyRepCover = "No";


  void emptyValueAssign() {
    if (idvController.value.text.isEmpty) {
      idvController.value.text = "0";
    }
    if (currentIDVController.value.text.isEmpty) {
      currentIDVController.value.text = "0";
    }
    if (yearManuFactureController.value.text.isEmpty) {
      yearManuFactureController.value.text = "2000";
    }
    if (odPremiumController.value.text.isEmpty) {
      odPremiumController.value.text = "0";
    }
    if (roadTaxCoverController.value.text.isEmpty) {
      roadTaxCoverController.value.text = "0";
    }
    if (otherCessController.value.text.isEmpty) {
      otherCessController.value.text = "0";
    }
    if (cngExtController.value.text.isEmpty) {
      cngExtController.value.text = "0";
    }
    if (cubicController.value.text.isEmpty) {
      cubicController.value.text = "0";
    }
    if (accessoriesController.value.text.isEmpty) {
      accessoriesController.value.text = "0";
    }
    if (nonElectAccController.value.text.isEmpty) {
      nonElectAccController.value.text = "0";
    }
    if (paUnnameController.value.text.isEmpty) {
      paUnnameController.value.text = "0";
    }
    if (addTowingController.value.text.isEmpty) {
      addTowingController.value.text = "0";
    }
    if (lossContentController.value.text.isEmpty) {
      lossContentController.value.text = "0";
    }
    if (returnInvoiceController.value.text.isEmpty) {
      returnInvoiceController.value.text = "0";
    }
  }

}