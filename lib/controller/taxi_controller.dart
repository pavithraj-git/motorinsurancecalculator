import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaxiController extends GetxController {
  final idvController = TextEditingController(text: "0").obs;
  final currentIDVController = TextEditingController(text: "0").obs;
  final yearManuFactureController = TextEditingController(text: "2000").obs;
  final noPassengersController = TextEditingController(text: "0").obs;
  final cubicController = TextEditingController(text: "0").obs;
  final odPremiumController = TextEditingController(text: "0").obs;
  final accessoriesController = TextEditingController(text: "0").obs;
  final zeroDepController = TextEditingController(text: "0").obs;
  final rsaController = TextEditingController(text: "0").obs;
  final paOwnerController = TextEditingController(text: "0").obs;
  final otherCessController = TextEditingController(text: "0").obs;
  final cngExtController = TextEditingController(text: "0").obs;

  //
  final kilowattController = TextEditingController(text: "0").obs;

  List<String> depreciationList = ["0", "5", "10", "15", "20", "25", "30"];
  List<String> ageVehicleList = ["Upto 5 Year", "6 to 7 Year", "Above 7 Year"];
  List<String> zoneList = ["A", "B"];
  List<String> cngList = ["Yes", "No"];
  List<String> antiTheftList = ["Yes", "No"];
  List<String> noClaimBonusList = ["0", "20", "25", "35", "45", "50"];
  List<String> llPayedList = ["0", "50"];

  String? llPayed = "50";
  String? cng = "No";
  String? antiTheft = "No";
  String? noClaimBonus = "0";
  String? zone = "A";
  String? ageVehicle = "Upto 5 Year";
  String? depreciation = "0";


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
    if(cubicController.value.text.isEmpty){
      cubicController.value.text = "0";
    }
    if(zeroDepController.value.text.isEmpty){
      zeroDepController.value.text = "0";
    }
    if(rsaController.value.text.isEmpty){
      rsaController.value.text = "0";
    }
    if(kilowattController.value.text.isEmpty){
      kilowattController.value.text = "0";
    }
  }


}