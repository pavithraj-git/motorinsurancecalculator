class PrivateCarSAODModel {
  String? fuelType;
  String? cc;
  String? zone;
  String? regDate;
  String? vehicleValue;
  String? eleAccess;
  String? nonEleAccess;
  String? cngKit;
  String? cngKitValue;
  String? noClaimBonus;
  String? ODDis;
  String? claimPrePo;
  String? nameTra;
  String? nilDep;
  String? addon;
  String? tppdRes;
  String? paOwner;
  String? legalLib;
  String? unnamedPA;
  String? specialODDis;
  String? specialTPDis;
  String? specialNPDis;
  String? specialDis;

  PrivateCarSAODModel({
    this.fuelType,
    this.cc,
    this.zone,
    this.regDate,
    this.vehicleValue,
    this.eleAccess,
    this.nonEleAccess,
    this.cngKit,
    this.cngKitValue,
    this.noClaimBonus,
    this.ODDis,
    this.claimPrePo,
    this.nameTra,
    this.nilDep,
    this.addon,
    this.tppdRes,
    this.paOwner,
    this.legalLib,
    this.unnamedPA,
    this.specialODDis,
    this.specialTPDis,
    this.specialNPDis,
    this.specialDis,
  });

  PrivateCarSAODModel.fromJson(Map<String, dynamic> map){
    fuelType = map["fuelType"];
    cc = map["cc"];
    zone = map["zone"];
    regDate = map["regDate"];
    vehicleValue = map["vehicleValue"];
    eleAccess = map["eleAccess"];
    nonEleAccess = map["nonEleAccess"];
    cngKit = map["cngKit"];
    cngKitValue = map["cngKitValue"];
    noClaimBonus = map["noClaimBonus"];
    ODDis = map["ODDis"];
    claimPrePo = map["claimPrePo"];
    nameTra = map["nameTra"];
    nilDep = map["nilDep"];
    addon = map["addon"];
    tppdRes = map["tppdRes"];
    paOwner = map["paOwner"];
    legalLib = map["legalLib"];
    unnamedPA = map["unnamedPA"];
    specialODDis = map["specialODDis"];
    specialTPDis = map["specialTPDis"];
    specialNPDis = map["specialNPDis"];
    specialDis = map["specialDis"];
  }
}