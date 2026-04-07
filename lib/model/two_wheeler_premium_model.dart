class TwoWheelerPremiumModel {
  String? idv;
  String? depreciation;
  String? currentIDV;
  String? ageVehicle;
  String? yearOfManufacture;
  String? zone;
  String? cubieCapacity;
  String? odPremiumDis;
  String? accessoriesValue;
  String? noClaimBonus;
  String? zeroDepreciation;
  String? paOwnerDriver;
  String? llPaidDriver;
  String? paUnnamedPassenger;
  String? tppd;
  String? otherCess;
  //electric,
  String? kilowatt;
  //electric od5

  String? odTerm;
  String? tpTerm;
  String? loadingDisPre;
  String? electricalAcc;
  String? sideCar;
  String? antiTheft;
  String? handicap;
  String? aai;
  String? volDeduct;
  String? rsa;
  String? addonCharge;
  String? valAddService;

  //passenger carrying
  String? noPassenger;
  String? imt23;
  String? cngKits;
  String? cngEx;

  String? nonElectAcce;

  //car
  String? geoGrap;
  String? fiberGlass;
  String? drivingTutions;
  String? consumables;
  String? tyreCover;
  String? ncb;
  String? enginePro;
  String? returnInvoice;

  //carry
  String? grassWeight;
  String? llEmpPayed;

  //
  String? llPassenger;

  //
  String? vehicleType;
  String? overCranes;
  String? noTrailers;
  String? state;
  String? nilDep;
  String? lockKeyPro;
  String? lockKeyAmount;
  String? vehicleAge;
  String? roadTax;
  String? addTowingCover;
  String? lossContent;
  String? keyRepCover;
  String? fuel;
  String? personalEff;
  String? disNilDep;
  String? firstPurchase;
  String? autoMobile;
  String? lossKey;
  String? petCareCov;
  String? platinum;
  String? medialExp;
  String? courtesyCar;

  TwoWheelerPremiumModel({
    this.idv,
    this.depreciation,
    this.currentIDV,
    this.ageVehicle,
    this.yearOfManufacture,
    this.zone,
    this.cubieCapacity,
    this.odPremiumDis,
    this.accessoriesValue,
    this.noClaimBonus,
    this.zeroDepreciation,
    this.paOwnerDriver,
    this.llPaidDriver,
    this.paUnnamedPassenger,
    this.tppd,
    this.otherCess,

    //electric,
    this.kilowatt,

    //electric od5
    this.odTerm,
    this.tpTerm,
    this.loadingDisPre,
    this.electricalAcc,
    this.sideCar,
    this.antiTheft,
    this.handicap,
    this.aai,
    this.volDeduct,
    this.rsa,
    this.addonCharge,
    this.valAddService,

    //passenger carrying
    this.noPassenger,
    this.imt23,
    this.cngKits,
    this.cngEx,

    this.nonElectAcce,

    //car
    this.geoGrap,
    this.fiberGlass,
    this.drivingTutions,
    this.consumables,
    this.tyreCover,
    this.ncb,
    this.enginePro,
    this.returnInvoice,

    //carry
    this.grassWeight,
    this.llEmpPayed,
    //
    this.llPassenger,
    //
    this.overCranes,
    this.vehicleType,
    this.noTrailers,
    this.state,
    this.nilDep,
    this.lockKeyPro,
    this.lockKeyAmount,
    this.vehicleAge,
    this.roadTax,
    this.addTowingCover,
    this.lossContent,
    this.keyRepCover,

    this.fuel,
    this.personalEff,
    this.disNilDep,
    this.firstPurchase,
    this.autoMobile,
    this.lossKey,
    this.petCareCov,
    this.platinum,
    this.medialExp,
    this.courtesyCar
});

  TwoWheelerPremiumModel.fromJson(Map<String, dynamic> map) {
    idv = map["idv"];
    depreciation = map["depreciation"];
    currentIDV = map["currentIDV"];
    ageVehicle = map["ageVehicle"];
    yearOfManufacture = map["yearOfManufacture"];
    zone = map["zone"];
    cubieCapacity = map["cubieCapacity"];
    odPremiumDis = map["odPremiumDis"];
    accessoriesValue = map["accessoriesValue"];
    noClaimBonus = map["noClaimBonus"];
    zeroDepreciation = map["zeroDepreciation"];
    paOwnerDriver = map["paOwnerDriver"];
    llPaidDriver = map["llPaidDriver"];
    paUnnamedPassenger = map["paUnnamedPassenger"];
    tppd = map["tppd"];
    otherCess =  map["otherCess"];
    //electric
    kilowatt = map["kilowatt"];

    //electric od5
    odTerm = map["odTerm"];
    tpTerm = map["tpTerm"];
    loadingDisPre = map["loadingDisPre"];
    electricalAcc = map["electricalAcc"];
    sideCar = map["sideCar"];
    antiTheft = map["antiTheft"];
    handicap = map["handicap"];
    aai = map["aai"];
    volDeduct = map["volDeduct"];
    rsa = map["rsa"];
    addonCharge = map["addonCharge"];
    valAddService = map["valAddService"];

    //passenger carrying
    noPassenger = map["noPassenger"];
    imt23 = map["imt23"];
    cngKits = map["cngKits"];
    cngEx = map["cngEx"];

    //car
    nonElectAcce = map["nonElectAcce"];

    geoGrap = map["geoGrap"];
    fiberGlass = map["fiberGlass"];
    drivingTutions = map["drivingTutions"];
    consumables = map["consumables"];
    tyreCover = map["tyreCover"];
    ncb = map["ncb"];
    enginePro = map["enginePro"];
    returnInvoice = map["returnInvoice"];

    //carry
    grassWeight = map["grassWeight"];
    llEmpPayed = map["llEmpPayed"];

    //
    llPassenger = map["llPassenger"];
    //
    overCranes = map["overCranes"];
    vehicleType = map["vehicleType"];
    noTrailers = map["noTrailers"];
    state = map["state"];
    nilDep = map["nilDep"];
    lockKeyPro = map["lockKeyPro"];
    lockKeyAmount = map["lockKeyAmount"];
    vehicleAge = map["vehicleAge"];
    roadTax = map["roadTax"];
    addTowingCover = map["addTowingCover"];
    lossContent = map["lossContent"];
    keyRepCover = map["keyRepCover"];
    fuel = map["fuel"];
    personalEff = map["personalEff"];
    disNilDep = map["disNilDep"];
    firstPurchase = map["firstPurchase"];
    autoMobile = map["autoMobile"];
    lossKey = map["lossKey"];
    petCareCov = map["petCareCov"];
    platinum = map["platinum"];
    medialExp = map["medialExp"];
    courtesyCar = map["courtesyCar"];
  }
}