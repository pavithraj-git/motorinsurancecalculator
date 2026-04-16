class CalculationModel {
  double? idv;
  double? vehicleBasicRate;
  double? basicVehicle;
  double? disOD;
  double? odAfterDis;
  double? accessories;
  double? totalPremium;
  double? netOwnDamage;
  double? noClaim;
  double? zeroDep;
  double? liability;
  double? totalA;
  double? totalB;
  double? totalAB;
  double? GST;
  double? cess;
  double? finalTotal;

  double? cngExt;
  double? imt23;
  double? odBeforeDis;
  double? disOnODPre;
  double? odBeforeNCB;
  double? tppd;
  double? passCov;
  double? cngKit;
  double? basicODPri;

  double? loadingOD;
  double? nonElecAcc;
  double? basODPrime;
  double? otherAddon;
  double? paUnnamed;
  double? totalC;
  double? totalABC;

  double? fiberGlass;
  double? drivingTution;
  double? geoGrapExt;
  double? geoExt;
  double? odBeforeDedu;
  double? antiTheft;
  double? handiCap;
  double? aai;
  double? volDedu;
  double? rsa;
  double? consumable;
  double? tyreCover;
  double? ncb;
  double? enginePro;
  double? valAddService;
  double? returnInvoice;

  double? llEmpPayed;
  double? GST5;

  double? llPassenger;

  double? overCranes;

  String? vehicleAge;
  double? vehicleValue;
  double? basicODDis;
  double? nilDep;
  double? nilDepAddon;
  double? CGST;
  double? SGST;
  double? specialNPDis;
  double? specialDisAmt;
  double? specialDisPrice;

  double? paOwner;
  double? llDriver;
  double? specialODDis;
  double? specialTPDis;

  double? trailerValue;
  double? trailerOD;

  CalculationModel({
    this.idv,
    this.vehicleBasicRate,
    this.basicVehicle,
    this.disOD,
    this.odAfterDis,
    this.accessories,
    this.totalPremium,
    this.netOwnDamage,
    this.noClaim,
    this.zeroDep,
    this.liability,
    this.totalA,
    this.totalB,
    this.totalAB,
    this.GST,
    this.cess,
    this.finalTotal,
    this.cngExt,
    this.imt23,
    this.odBeforeDis,
    this.disOnODPre,
    this.odBeforeNCB,
    this.tppd,
    this.passCov,
    this.cngKit,
    this.basicODPri,
    this.loadingOD,
    this.nonElecAcc,
    this.basODPrime,
    this.otherAddon,
    this.paUnnamed,
    this.totalC,
    this.totalABC,
    this.fiberGlass,
    this.drivingTution,
    this.geoGrapExt,
    this.geoExt,
    this.odBeforeDedu,
    this.antiTheft,
    this.handiCap,
    this.aai,
    this.volDedu,
    this.rsa,
    this.consumable,
    this.tyreCover,
    this.ncb,
    this.enginePro,
    this.valAddService,
    this.returnInvoice,
    this.llEmpPayed,
    this.GST5,
    this.llPassenger,
    this.overCranes,
    this.vehicleAge,
    this.vehicleValue,
    this.basicODDis,
    this.nilDep,
    this.nilDepAddon,
    this.CGST,
    this.SGST,
    this.specialNPDis,
    this.specialDisAmt,
    this.specialDisPrice,
    this.paOwner,
    this.llDriver,
    this.specialODDis,
    this.specialTPDis,
    this.trailerValue,
    this.trailerOD,
  });

  CalculationModel.fromJson(Map<String, dynamic> map){
    idv = map["idv"];
    vehicleBasicRate = map["vehicleBasicRate"];
    basicVehicle = map["basicVehicle"];
    disOD = map["disOD"];
    odAfterDis = map["odAfterDis"];
    accessories = map["accessories"];
    totalPremium = map["totalPremium"];
    netOwnDamage = map["netOwnDamage"];
    noClaim = map["noClaim"];
    zeroDep = map["zeroDep"];
    liability = map["liability"];
    totalA = map["totalA"];
    totalB = map["totalB"];
    totalAB = map["totalAB"];
    GST = map["GST"];
    cess = map["cess"];
    finalTotal = map["finalTotal"];
    cngExt = map["cngExt"];
    imt23 = map["imt23"];
    odBeforeDis = map["odBeforeDis"];
    disOnODPre = map["disOnODPre"];
    odBeforeNCB = map["odBeforeNCB"];
    tppd = map["tppd"];
    passCov = map["passCov"];
    cngKit = map["cngKit"];
    basicODPri = map["basicODPri"];
    loadingOD = map["loadingOD"];
    nonElecAcc = map["nonElecAcc"];
    basODPrime = map["basODPrime"];
    otherAddon = map["otherAddon"];
    paUnnamed = map["paUnnamed"];
    totalC = map["totalC"];
    totalABC = map["totalABC"];
    fiberGlass = map["fiberGlass"];
    drivingTution = map["drivingTution"];
    geoGrapExt = map["geoGrapExt"];
    geoExt = map["geoExt"];
    odBeforeDedu = map["odBeforeDedu"];
    antiTheft = map["antiTheft"];
    handiCap = map["handiCap"];
    aai = map["aai"];
    volDedu = map["volDedu"];
    rsa = map["rsa"];
    consumable = map["consumable"];
    tyreCover = map["tyreCover"];
    ncb = map["ncb"];
    enginePro = map["enginePro"];
    valAddService = map["valAddService"];
    returnInvoice = map["returnInvoice"];
    llEmpPayed = map["llEmpPayed"];
    GST5 = map["GST5"];
    llPassenger = map["llPassenger"];
    overCranes = map["overCranes"];
    vehicleAge = map["vehicleAge"];
    vehicleValue = map["vehicleValue"];
    basicODDis = map["basicODDis"];
    nilDep = map["nilDep"];
    nilDepAddon = map["nilDepAddon"];
    CGST = map["CGST"];
    SGST = map["SGST"];
    specialNPDis = map["specialNPDis"];
    specialDisAmt = map["specialDisAmt"];
    specialDisPrice = map["specialDisPrice"];
    paOwner = map["paOwner"];
    llDriver = map["llDriver"];
    specialODDis = map["specialODDis"];
    specialTPDis = map["specialTPDis"];
    trailerValue = map["trailerValue"];
    trailerOD = map["trailerOD"];
  }
  
}