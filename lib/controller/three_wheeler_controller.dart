import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreeWheelerController extends GetxController {
  final idvController = TextEditingController(text: "0").obs;
  final currentIDVController = TextEditingController(text: "0").obs;
  final yearManuFactureController = TextEditingController(text: "2000").obs;
  final odPremiumController = TextEditingController(text: "0").obs;
  final paOwnerController = TextEditingController(text: "0").obs;
  final otherCessController = TextEditingController(text: "0").obs;
  final cngExtController = TextEditingController(text: "0").obs;
  final noPassengersController = TextEditingController(text: "0").obs;
  final accessoriesController = TextEditingController(text: "0").obs;


  List<String> depreciationList = ["0", "5", "10", "15", "20", "25", "30"];
  List<String> ageVehicleList = ["Upto 5 Year", "6 to 7 Year", "Above 7 Year"];
  List<String> zoneList = ["A", "B", "C"];
  List<String> cngList = ["Yes", "No"];
  List<String> tppdList = ["Yes", "No"];
  List<String> noClaimBonusList = ["0", "20", "25", "35", "45", "50"];
  List<String> llPayedList = ["0", "50"];
  List<String> imt23List = ["Yes", "No"];

  String? llPayed = "50";
  String? cng = "No";
  String? noClaimBonus = "0";
  String? zone = "A";
  String? ageVehicle = "Upto 5 Year";
  String? depreciation = "0";
  String? imt23 = "No";
  String? tppd = "No";

void emptyValueAssign(){
  if(idvController.value.text.isEmpty){
    idvController.value.text = "0";
  }
  if(currentIDVController.value.text.isEmpty){
    currentIDVController.value.text = "0";
  }
  if(yearManuFactureController.value.text.isEmpty){
    yearManuFactureController.value.text = "2000";
  }
  if(odPremiumController.value.text.isEmpty){
    odPremiumController.value.text = "0";
  }
  if(paOwnerController.value.text.isEmpty){
    paOwnerController.value.text = "0";
  }
  if(otherCessController.value.text.isEmpty){
    otherCessController.value.text = "0";
  }
  if(cngExtController.value.text.isEmpty){
    cngExtController.value.text = "0";
  }
  if(noPassengersController.value.text.isEmpty){
    noPassengersController.value.text = "0";
  }
  if(accessoriesController.value.text.isEmpty){
    accessoriesController.value.text = "0";
  }
}


}