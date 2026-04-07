import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TrailerTPController extends GetxController {
  final specialDisAmtController = TextEditingController(text: "0").obs;
  final specialNPDisController = TextEditingController(text: "0").obs;
  final regDateController = TextEditingController(text: DateFormat('dd-MM-yyyy').format(DateTime.now())).obs;

  List<String> fuelTypeList = ["Petrol", "Diesel", "Petrol/CNG", "Petrol/LPG"];
  List<String> zoneList = ["A", "B"];
  List<String> noClaimBonusList = ["Nil","0 to 20%", "20 to 25%", "25 to 35%", "35 to 45%", "45 to 50%", "50 to 50%"];
  List<String> tppdResList = ["Yes", "No"];
  List<String> vehiclePurposeList = ["Agricultural", "Commercial"];
  List<String> noTrailerList = ["0", "1", "2"];


  String? fuelType = "Petrol";
  String? tppdRes= "No";
  String? zone = "A";
  String? vehiclePurpose = "Agricultural";
  String? noTrailer = "0";

  void emptyValueAssign() {
    if (specialDisAmtController.value.text.isEmpty) {
      specialDisAmtController.value.text = "0";
    }
    if (specialNPDisController.value.text.isEmpty) {
      specialNPDisController.value.text = "2000";
    }
    if (regDateController.value.text.isEmpty) {
      regDateController.value.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
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