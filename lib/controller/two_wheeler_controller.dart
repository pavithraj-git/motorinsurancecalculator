import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TwoWheelerController extends GetxController {
  final idvController = TextEditingController(text: "0").obs;
  final currentIDVController = TextEditingController(text: "0").obs;
  final yearManuFactureController = TextEditingController(text: "2000").obs;
  final cubicController = TextEditingController(text: "0").obs;
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
  // List<String> tppdList = ["Yes", "No"];
  List<String> llPayedList = ["0", "50", "250"];
  List<String> insuranceCompanyList = [
    "ACKO GENERAL INSURANCE",
    "BAJAJ GENERAL INSURANCE LTD",
    "CHOLAMANDALAM MS GENERAL INSURANCE",
    "GENERAL CENTRAL INSURANCE CO. LTD",
    "GO DIGIT GENERAL INSURANCE LTD",
    "HDFC ERGO GENERAL INSURANCE CO. LTD",
    "ICICI LOMBARD GENERAL INSURANCE CO. LTD",
    "IFFCO TOKIO GENERAL INSURANCE CO. LTD",
    "INDUSIND GENERAL INSURANCE CO. LTD",
    "LIBERTY GENERAL INSURANCE LTD",
    "MAGMA GENERAL INSURANCE LTD",
    "NATIONAL INSURANCE CO. LTD",
    "NAVI GENERAL INSURANCE LTD",
    "RAHEJA QBE GENERAL INSURANCE CO. LTD",
    "ROYAL SUNDARAM GENERAL INSURANCE CO. LTD",
    "SBI GENERAL INSURANCE CO. LTD",
    "SHRIRAM GENERAL INSURANCE CO. LTD",
    "TATA AIG GENERAL INSURANCE CO. LTD",
    "THE NEW INDIA ASSURANCE CO. LTD",
    "THE ORIENTAL INSURANCE CO. LTD",
    "UNITED INDIA INSURANCE CO. LTD",
    "UNIVERSAL SOMPO GENERAL INSURANCE CO. LTD",
    "ZUNO GENERAL INSURANCE",
    "ZURICH KOTAK GENERAL INSURANCE CO. LTD"
  ];

  String? llPayed = "0";
  String? noClaimBonus = "0";
  // String? tppd = "No";
  String? zone = "A";
  String? ageVehicle = "Upto 5 Year";
  String? depreciation = "0";
  String? insuranceCompany = "ACKO GENERAL INSURANCE";


  final fullNameController = TextEditingController().obs;
  final vehicleMakeController = TextEditingController().obs;
  final vehicleModelController = TextEditingController().obs;
  final registrationNoController = TextEditingController().obs;
  final seatingCapacityController = TextEditingController().obs;
  final otherCoverController = TextEditingController().obs;
  final startDateController = TextEditingController().obs;
  final endDateController = TextEditingController().obs;

  RxBool zeroDep = false.obs;
  RxBool rsa = false.obs;
  RxBool consumable = false.obs;
  RxBool enginCover = false.obs;
  RxBool ncb = false.obs;
  RxBool tyreCover = false.obs;
  RxBool lossKey = false.obs;
  RxBool courtesy = false.obs;
  RxBool spare = false.obs;
  RxBool returnInvoice = false.obs;
  RxBool medical = false.obs;
  RxBool dailyCash = false.obs;
  RxBool roadTax = false.obs;
  RxBool additionalTowing = false.obs;
  RxBool vas = false.obs;

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
    if(paUnnameController.value.text.isEmpty){
      paUnnameController.value.text = "0";
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
  }
 double vehicleBasicRate(String? vehicleAge, String? zone, String? cc) {
    if(vehicleAge == "Upto 5 Year" && zone == "A" && int.parse(cc ?? "0") <= 150){
      return 1.708;
    } else if(vehicleAge == "Upto 5 Year" && zone == "A" && int.parse(cc ?? "0") >= 151 && int.parse(cc ?? "0") <= 350){
      return 1.793;
    } else if(vehicleAge == "Upto 5 Year" && zone == "A" && int.parse(cc ?? "0") > 350){
      return 1.879;
    } else if(vehicleAge == "Upto 5 Year" && zone == "B" && int.parse(cc ?? "0") <= 150){
      return 1.676;
    } else if(vehicleAge == "Upto 5 Year" && zone == "B" && int.parse(cc ?? "0") >= 151 && int.parse(cc ?? "0") <= 350){
      return 1.760;
    } else if(vehicleAge == "Upto 5 Year" && zone == "B" && int.parse(cc ?? "0") > 350){
      return 1.844;
    } else if(vehicleAge == "6 to 10 Year" && zone == "A" && int.parse(cc ?? "0") <= 150){
      return 1.793;
    } else if(vehicleAge == "6 to 10 Year" && zone == "A" && int.parse(cc ?? "0") >= 151 && int.parse(cc ?? "0") <= 350){
      return 1.883;
    } else if(vehicleAge == "6 to 10 Year" && zone == "A" && int.parse(cc ?? "0") > 350){
      return 1.973;
    } else if(vehicleAge == "6 to 10 Year" && zone == "B" && int.parse(cc ?? "0") <= 150){
      return 1.760;
    } else if(vehicleAge == "6 to 10 Year" && zone == "B" && int.parse(cc ?? "0") >= 151 && int.parse(cc ?? "0") <= 350){
      return 1.848;
    } else if(vehicleAge == "6 to 10 Year" && zone == "B" && int.parse(cc ?? "0") > 350){
      return 1.936;
    } else if(vehicleAge == "Above 10 Year" && zone == "A" && int.parse(cc ?? "0") <= 150){
      return 1.836;
    } else if(vehicleAge == "Above 10 Year" && zone == "A" && int.parse(cc ?? "0") >= 151 && int.parse(cc ?? "0") <= 350){
      return 1.928;
    } else if(vehicleAge == "Above 10 Year" && zone == "A" && int.parse(cc ?? "0") > 350){
      return 2.020;
    } else if(vehicleAge == "Above 10 Year" && zone == "B" && int.parse(cc ?? "0") <= 150){
      return 1.802;
    } else if(vehicleAge == "Above 10 Year" && zone == "B" && int.parse(cc ?? "0") >= 151 && int.parse(cc ?? "0") <= 350){
      return 1.892;
    } else if(vehicleAge == "Above 10 Year" && zone == "B" && int.parse(cc ?? "0") > 350){
      return 1.982;
    }
    return 0;

}

 double liabilityTP(String? cc){
    if(int.parse(cc ?? "0") <= 75){
      return 538;
    } else if(int.parse(cc ?? "0") > 75 && int.parse(cc ?? "0") <= 150){
      return 714;
    } else if(int.parse(cc ?? "0") > 150 && int.parse(cc ?? "0") <= 350){
      return 1366;
    } else if(int.parse(cc ?? "0") > 350){
      return 2804;
    }
    return 0;
 }

  double fiveLiabilityTP(String? cc){
    if(int.parse(cc ?? "0") <= 75){
      return 2901;
    } else if(int.parse(cc ?? "0") > 75 && int.parse(cc ?? "0") <= 150){
      return 3851;
    } else if(int.parse(cc ?? "0") > 150 && int.parse(cc ?? "0") <= 350){
      return 7365;
    } else if(int.parse(cc ?? "0") > 350){
      return 15117;
    }
    return 0;
  }

  double passengerLiabilityTP(String? cc){
    if(int.parse(cc ?? "0") <= 75){
      return 861;
    } else if(int.parse(cc ?? "0") > 75 && int.parse(cc ?? "0") <= 150){
      return 861;
    } else if(int.parse(cc ?? "0") > 150 && int.parse(cc ?? "0") <= 350){
      return 861;
    } else if(int.parse(cc ?? "0") > 350){
      return 2254;
    }
    return 0;
  }

  double electricLiabilityTP(String? cc){
    if(int.parse(cc ?? "0") <= 75){
      return 2383;
    } else if(int.parse(cc ?? "0") > 75 && int.parse(cc ?? "0") <= 150){
      return 2383;
    } else if(int.parse(cc ?? "0") > 150 && int.parse(cc ?? "0") <= 350){
      return 2383;
    } else if(int.parse(cc ?? "0") > 350){
      return 2383;
    }
    return 0;
  }

  double fiveElectricLiabilityTP(String? cc){
    if(int.parse(cc ?? "0") <= 75){
      return 12849;
    } else if(int.parse(cc ?? "0") > 75 && int.parse(cc ?? "0") <= 150){
      return 12849;
    } else if(int.parse(cc ?? "0") > 150 && int.parse(cc ?? "0") <= 350){
      return 12849;
    } else if(int.parse(cc ?? "0") > 350){
      return 12849;
    }
    return 0;
  }


  double fiveElectricVehicleBasicRate(String? vehicleAge, String? zone, String? cc) {
    if(vehicleAge == "Upto 5 Year" && zone == "A"){
      return 1.879;
    } else if(vehicleAge == "Upto 5 Year" && zone == "B"){
      return 1.844;
    } else if(vehicleAge == "6 to 10 Year" && zone == "A"){
      return 1.973;
    }  else if(vehicleAge == "6 to 10 Year" && zone == "B"){
      return 1.936;
    } else if(vehicleAge == "Above 10 Year" && zone == "A"){
      return 2.020;
    } else if(vehicleAge == "Above 10 Year" && zone == "B"){
      return 1.982;
    }
    return 0;

  }
}