import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TrailerComprehensiveController extends GetxController {
  final odPremiumController = TextEditingController(text: "0").obs;
  final trailer1Controller = TextEditingController(text: "0").obs;
  final trailer2Controller = TextEditingController(text: "0").obs;
  final specialDisAmtController = TextEditingController(text: "0").obs;
  final specialNPDisController = TextEditingController(text: "0").obs;
  final regDateController = TextEditingController(text: DateFormat('dd-MM-yyyy').format(DateTime.now())).obs;
  final specialODDisController = TextEditingController(text: "0").obs;
  final specialTPDisController = TextEditingController(text: "0").obs;

  List<String> fuelTypeList = ["Petrol", "Diesel", "Petrol/CNG", "Petrol/LPG"];
  List<String> zoneList = ["A", "B"];
  List<String> noClaimBonusList = ["Nil","0 to 20%", "20 to 25%", "25 to 35%", "35 to 45%", "45 to 50%", "50 to 50%"];
  List<String> claimPrePoList = ["Yes", "No"];
  List<String> nameTraList = ["Yes", "No"];
  List<String> tppdResList = ["Yes", "No"];
  List<String> vehiclePurposeList = ["Agricultural", "Commercial"];
  List<String> noTrailerList = ["0", "1", "2"];
  List<String> imt23List = ["Yes", "No"];


  String? fuelType = "Petrol";
  String? noClaimBonus = "Nil";
  bool noClaimBonusEnable = true;
  String? claimPrePo = "No";
  String? nameTra = "No";
  String? tppdRes= "No";
  String? zone = "A";
  String? vehiclePurpose = "Agricultural";
  String? noTrailer = "0";
  String? imt23 = "No";

  void emptyValueAssign() {
    if (specialDisAmtController.value.text.isEmpty) {
      specialDisAmtController.value.text = "0";
    }
    if (specialNPDisController.value.text.isEmpty) {
      specialNPDisController.value.text = "2000";
    }
    if (odPremiumController.value.text.isEmpty) {
      odPremiumController.value.text = "0";
    }
    if (regDateController.value.text.isEmpty) {
      regDateController.value.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    }
    if (specialODDisController.value.text.isEmpty) {
      specialODDisController.value.text = "0";
    }
    if (specialTPDisController.value.text.isEmpty) {
      specialTPDisController.value.text = "0";
    }
    if (trailer1Controller.value.text.isEmpty) {
      trailer1Controller.value.text = "0";
    }
    if (trailer2Controller.value.text.isEmpty) {
      trailer2Controller.value.text = "0";
    }
  }

  String? getRemaining(DateTime inputDate) {
    DateTime now = DateTime.now();

    // If input date is in past, swap (optional)
    if (inputDate.isBefore(now)) {
      DateTime temp = now;
      now = inputDate;
      inputDate = temp;
    }

    int years = inputDate.year - now.year;
    int months = inputDate.month - now.month;
    int days = inputDate.day - now.day;

    // Adjust days
    if (days < 0) {
      months--;
      DateTime prevMonth = DateTime(inputDate.year, inputDate.month, 0);
      days += prevMonth.day;
    }

    // Adjust months
    if (months < 0) {
      years--;
      months += 12;
    }

    if (years > 0) {
      return "$years Year${years > 1 ? 's' : ''}";
    } else if (months > 0) {
      return "$months Month${months > 1 ? 's' : ''}";
    } else {
      return "$days Day${days > 1 ? 's' : ''}";
    }
  }



}