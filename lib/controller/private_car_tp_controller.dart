import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PrivateCarTPController extends GetxController {
  final specialDisAmtController = TextEditingController(text: "0").obs;
  final specialNPDisController = TextEditingController(text: "0").obs;
  final regDateController = TextEditingController(text: DateFormat('dd-MM-yyyy').format(DateTime.now())).obs;
  final paOwnerController = TextEditingController(text: "0").obs;
  final unnamedPAController = TextEditingController(text: "0").obs;

  List<String> cubicCapacitorList = ["0 - 1000 CC", "1001 - 1500 CC", "1501 - Above CC"];
  List<String> fuelTypeList = ["Petrol", "Diesel", "Petrol/CNG", "Petrol/LPG"];
  List<String> zoneList = ["A", "B"];
  List<String> cngList = ["Yes", "No"];
  List<String> tppdResList = ["Yes", "No"];
  List<String> legalLibList = ["0", "1", "2", "3"];


  String? cubicCapacitor = "0 - 1000 CC";
  String? fuelType = "Petrol";
  String? cng = "No";
  String? tppdRes= "No";
  String? legalLib = "0";
  String? zone = "A";

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
    if (paOwnerController.value.text.isEmpty) {
      paOwnerController.value.text = "0";
    }
    if (unnamedPAController.value.text.isEmpty) {
      unnamedPAController.value.text = "0";
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

  double vehicleBasicRateSAOD(String? vehicleAge, String? zone, String? cc) {
    int? year = DateFormat("dd-MM-yyyy").parse(vehicleAge!).year;
    if(year > 2020 && zone == "A" && cc == "0 - 1000 CC"){
      return 3.127;
    } else if(year <= 2020 && year > 2015 && zone == "A" && cc == "0 - 1000 CC"){
      return 3.283;
    } else if(year <= 2015 && zone == "A" && cc == "0 - 1000 CC"){
      return 3.362;
    } else if (year > 2020 && zone == "B" && cc == "0 - 1000 CC"){
      return 3.039;
    } else if(year <= 2020 && year > 2015 && zone == "B" && cc == "0 - 1000 CC"){
      return 3.191;
    } else if(year <= 2015 && zone == "B" && cc == "0 - 1000 CC"){
      return 3.267;
    } else if(year > 2020 && zone == "A" && cc == "1001 - 1500 CC"){
      return 3.283;
    } else if(year <= 2020 && year > 2015 && zone == "A" && cc == "1001 - 1500 CC"){
      return 3.447;
    } else if(year <= 2015 && zone == "A" && cc == "1001 - 1500 CC"){
      return 3.529;
    } else if (year > 2020 && zone == "B" && cc == "1001 - 1500 CC"){
      return 3.191;
    } else if(year <= 2020 && year > 2015 && zone == "B" && cc == "1001 - 1500 CC"){
      return 3.351;
    } else if(year <= 2015 && zone == "B" && cc == "1001 - 1500 CC"){
      return 3.43;
    } else if(year > 2020 && zone == "A" && cc == "1501 - Above CC"){
      return 3.44;
    } else if(year <= 2020 && year > 2015 && zone == "A" && cc == "1501 - Above CC"){
      return 3.612;
    } else if(year <= 2015 && zone == "A" && cc == "1501 - Above CC"){
      return 3.698;
    } else if (year > 2020 && zone == "B" && cc == "1501 - Above CC"){
      return 3.343;
    } else if(year <= 2020 && year > 2015 && zone == "B" && cc == "1501 - Above CC"){
      return 3.51;
    } else if(year <= 2015 && zone == "B" && cc == "1501 - Above CC"){
      return 3.594;
    }
    return 0;

  }


}