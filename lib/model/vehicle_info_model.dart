class VehicleInfoModel {
  String? insuranceCompany;
  String? name;
  String? make;
  String? model;
  String? regNo;
  String? seatingCapacity;
  String? otherCoverage;
  String? startDate;
  String? endDate;

  bool? zeroDep;
  bool? rsa;
  bool? consumable;
  bool? enginCover;
  bool? ncb;
  bool? tyreCover;
  bool? lossKey;
  bool? courtesy;
  bool? spare;
  bool? returnInvoice;
  bool? medical;
  bool? dailyCash;
  bool? roadTax;
  bool? additionalTowing;
  bool? vas;

  VehicleInfoModel({
   this.insuranceCompany,
    this.name,
    this.make,
    this.model,
    this.regNo,
    this.seatingCapacity,
    this.otherCoverage,
    this.startDate,
    this.endDate,

    this.zeroDep,
    this.rsa,
    this.consumable,
    this.enginCover,
    this.ncb,
    this.tyreCover,
    this.lossKey,
    this.courtesy,
    this.spare,
    this.returnInvoice,
    this.medical,
    this.dailyCash,
    this.roadTax,
    this.additionalTowing,
    this.vas,
  });

  VehicleInfoModel.fromJson(Map<String, dynamic> map){
    insuranceCompany = map["insuranceCompany"];
    name = map["name"];
    make = map["make"];
    model = map["model"];
    regNo = map["regNo"];
    seatingCapacity = map["seatingCapacity"];
    otherCoverage = map["otherCoverage"];
    startDate = map["startDate"];
    endDate = map["endDate"];

    zeroDep = map["zeroDep"];
    rsa = map["rsa"];
    consumable = map["consumable"];
    enginCover = map["enginCover"];
    ncb = map["ncb"];
    tyreCover = map["tyreCover"];
    lossKey = map["lossKey"];
    courtesy = map["courtesy"];
    spare = map["spare"];
    returnInvoice = map["returnInvoice"];
    medical = map["medical"];
    dailyCash = map["dailyCash"];
    roadTax = map["roadTax"];
    additionalTowing = map["additionalTowing"];
    vas = map["vas"];
  }
}