import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElectricCarCompleteController extends GetxController {
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

  List<String> odTermList = ["0", "1", "3"];
  List<String> tpTermList = ["0", "1", "3"];
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
  List<String> volDeductList = ["0", "2500", "5000", "7500", "15000"];
  List<String> noClaimBonusList = ["0", "20", "25", "35", "45", "50"];
  List<String> tppdList = ["Yes", "No"];
  List<String> llPayedList = ["0", "50", "150"];

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
    if (paOwnerController.value.text.isEmpty) {
      paOwnerController.value.text = "0";
    }
    if (otherCessController.value.text.isEmpty) {
      otherCessController.value.text = "0";
    }
    if (cngExtController.value.text.isEmpty) {
      cngExtController.value.text = "0";
    }
    if (kilowattController.value.text.isEmpty) {
      kilowattController.value.text = "0";
    }
    if (accessoriesController.value.text.isEmpty) {
      accessoriesController.value.text = "0";
    }
    if (loadingDisPreController.value.text.isEmpty) {
      loadingDisPreController.value.text = "0";
    }
    if (nonElectAccController.value.text.isEmpty) {
      nonElectAccController.value.text = "0";
    }
    if (zeroDepController.value.text.isEmpty) {
      zeroDepController.value.text = "0";
    }
    if (rsaController.value.text.isEmpty) {
      rsaController.value.text = "0";
    }
    if (addonChargeController.value.text.isEmpty) {
      addonChargeController.value.text = "0";
    }
    if (valAddServiceController.value.text.isEmpty) {
      valAddServiceController.value.text = "0";
    }
    if (paUnnameController.value.text.isEmpty) {
      paUnnameController.value.text = "0";
    }
    if (consumablesController.value.text.isEmpty) {
      consumablesController.value.text = "0";
    }
    if (TyreCoverController.value.text.isEmpty) {
      TyreCoverController.value.text = "0";
    }
    if (ncbController.value.text.isEmpty) {
      ncbController.value.text = "0";
    }
    if (engineProController.value.text.isEmpty) {
      engineProController.value.text = "0";
    }
    if (returnInvoiceController.value.text.isEmpty) {
      returnInvoiceController.value.text = "0";
    }
  }



}