class TrailerModel {
  String? fuelType;
  String? cc;
  String? zone;
  String? vehiclePurpose;
  String? regDate;
  String? noTrailer;
  String? imt23;
  String? noClaimBonus;
  String? ODDis;
  String? claimPrePo;
  String? nameTra;
  String? tppdRes;
  String? specialODDis;
  String? specialTPDis;
  String? specialNPDis;
  String? specialDis;
  String? trailer1;
  String? trailer2;

  TrailerModel({
    this.fuelType,
    this.cc,
    this.zone,
    this.vehiclePurpose,
    this.regDate,
    this.noTrailer,
    this.imt23,
    this.noClaimBonus,
    this.ODDis,
    this.claimPrePo,
    this.nameTra,
    this.tppdRes,
    this.specialODDis,
    this.specialTPDis,
    this.specialNPDis,
    this.specialDis,
    this.trailer1,
    this.trailer2,
  });

  TrailerModel.fromJson(Map<String, dynamic> map){
    fuelType = map["fuelType"];
    cc = map["cc"];
    zone = map["zone"];
    vehiclePurpose = map["vehiclePurpose"];
    regDate = map["regDate"];
    noTrailer = map["noTrailer"];
    imt23 = map["imt23"];
    noClaimBonus = map["noClaimBonus"];
    ODDis = map["ODDis"];
    claimPrePo = map["claimPrePo"];
    nameTra = map["nameTra"];
    tppdRes = map["tppdRes"];
    specialODDis = map["specialODDis"];
    specialTPDis = map["specialTPDis"];
    specialNPDis = map["specialNPDis"];
    specialDis = map["specialDis"];
    trailer1 = map["trailer1"];
    trailer2 = map["trailer2"];
  }
}