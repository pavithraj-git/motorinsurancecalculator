import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElectricTwoWheelerController extends GetxController {
  final idvController = TextEditingController(text: "0").obs;
  final currentIDVController = TextEditingController(text: "0").obs;
  final yearManuFactureController = TextEditingController(text: "2000").obs;
  final kilowattController = TextEditingController(text: "0").obs;
  final odPremiumController = TextEditingController(text: "0").obs;
  final accessoriesController = TextEditingController(text: "0").obs;
  final zeroDepController = TextEditingController(text: "0").obs;
  final paOwnerController = TextEditingController(text: "0").obs;
  final paUnnameController = TextEditingController(text: "0").obs;
  final otherCessController = TextEditingController(text: "0").obs;

  List<String> depreciationList = ["0", "5", "10", "15", "20", "25", "30"];
  List<String> ageVehicleList = ["Upto 5 Year", "6 to 10 Year", "Above 10 Year"];
  List<String> zoneList = ["A", "B"];
  List<String> noClaimBonusList = ["0", "20", "25", "35", "45", "50"];
  List<String> tppdList = ["Yes", "No"];
  List<String> llPayedList = ["0", "50", "250"];

  String? llPayed = "0";
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
    if (paUnnameController.value.text.isEmpty) {
      paUnnameController.value.text = "0";
    }
    if (accessoriesController.value.text.isEmpty) {
      accessoriesController.value.text = "0";
    }
    if (kilowattController.value.text.isEmpty) {
      kilowattController.value.text = "0";
    }
    if (zeroDepController.value.text.isEmpty) {
      zeroDepController.value.text = "0";
    }
  }

}