import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';
import '../../../controller/private_car_complete_controller.dart';

class PrivateCarCompleteIndexScreen extends StatefulWidget {
  String? title;
  TwoWheelerPremiumModel? data;
  PrivateCarCompleteIndexScreen({super.key, this.title, this.data});

  @override
  State<PrivateCarCompleteIndexScreen> createState() => _PrivateCarCompleteIndexScreenState();
}

class _PrivateCarCompleteIndexScreenState extends State<PrivateCarCompleteIndexScreen> {
  double idv = 0;
  double vehicleBasicRate = 0;
  double basicVehicle = 0;
  double disOD = 0;
  double odAfterDis = 0;
  double accessories = 0;
  double nonAccessories = 0;
  double odBeforeDedu = 0;
  double odBeforeNCB = 0;
  double netOwnDamage = 0;
  double noClaim = 0;
  double zeroDep = 0;
  double otherAddon = 0;
  double liability = 0;
  double totalA = 0;
  double totalB = 0;
  double paUnnamed = 0;
  double totalC = 0;
  double totalABC = 0;
  double GST = 0;
  double cess = 0;
  double finalTotal = 0;
  double cngExt = 0;
  double fiberGlass = 0;
  double drivingTution = 0;
  double antiTheft = 0;
  double handiCap = 0;
  double aai = 0;
  double volDedu = 0;
  double loadingOD = 0;
  double basicODPri = 0;
  double consumable = 0;
  double tyreCover = 0;
  double ncb = 0;
  double enginePro = 0;
  double returnInvoice = 0;
  double cngKit = 0;
  double geoGrapExt = 0;
  double geoExt = 0;
  double rsa = 0;
  double valAddService = 0;


  PrivateCarCompleteController two = PrivateCarCompleteController();
  @override
  void initState() {
    initFun();
    super.initState();
  }

  initFun(){
    setState(() {
      liability = two.carCompleteLiabilityTP(widget.data?.tpTerm, widget.data?.cubieCapacity);
      idv = double.parse(widget.data!.currentIDV.toString());
      double od = double.parse(widget.data?.odTerm ?? "0");
      double tp = double.parse(widget.data?.tpTerm ?? "0");
      vehicleBasicRate = two.carBasicRate(widget.data?.ageVehicle, widget.data?.zone, widget.data?.cubieCapacity);
      basicVehicle = (vehicleBasicRate * double.parse(widget.data!.currentIDV.toString()) / 100) * od;
      disOD = basicVehicle * double.parse(widget.data!.odPremiumDis.toString()) / 100;
      loadingOD = basicVehicle * double.parse(widget.data!.loadingDisPre.toString()) / 100;
      odAfterDis = basicVehicle + loadingOD - disOD;
      accessories = double.parse(widget.data!.electricalAcc.toString()) * 4 / 100 * od;
      nonAccessories = vehicleBasicRate * double.parse(widget.data!.nonElectAcce.toString()) / 100 * od;
      if(widget.data?.cngKits == "Yes") {
        cngExt = (double.parse(widget.data!.cngEx.toString()) * 4 / 100) * od;
        if(cngExt == 0){
          cngExt = basicVehicle * 5 / 100;
        }
        cngKit = tp * 60;
      }
      basicODPri = odAfterDis + accessories + nonAccessories + cngExt;
      if(widget.data?.fiberGlass == "Yes"){
        fiberGlass = 50 * od;
      }
      if(widget.data?.drivingTutions == "Yes"){
        drivingTution = basicODPri * 60 / 100;
      }
      geoGrapExt = double.parse(widget.data!.geoGrap.toString());
      if(geoGrapExt == 400){
        geoExt = 100;
      }
      odBeforeDedu = basicODPri + fiberGlass + drivingTution + geoGrapExt;

      if(widget.data?.antiTheft == "Yes"){
        antiTheft = basicODPri * 2.5/ 100;
        if(antiTheft >= 500) antiTheft = 500;
      }

      if(widget.data?.handicap == "Yes"){
        handiCap = basicODPri / 2;
      }

      if(widget.data?.aai == "Yes"){
        aai = basicODPri * 5 / 100;
      }

      if(widget.data?.volDeduct == "2500"){
        volDedu = (basicODPri * 20 / 100) * od;
        if(volDedu > 750) volDedu = 750;
      } else if(widget.data?.volDeduct == "5000"){
        volDedu = (basicODPri * 25 / 100) * od;
        if(volDedu > 1500) volDedu = 1500;
      } else if(widget.data?.volDeduct == "7500"){
        volDedu = (basicODPri * 30 / 100) * od;
        if(volDedu > 2000) volDedu = 2000;
      } else if(widget.data?.volDeduct == "15000"){
        volDedu = (basicODPri * 35 / 100) * od;
        if(volDedu > 2500) volDedu = 2500;
      } else {
        volDedu = 0;
      }

      odBeforeNCB = odBeforeDedu - volDedu - aai - handiCap - antiTheft;
      noClaim = odBeforeNCB * double.parse(widget.data!.noClaimBonus.toString()) / 100;
      netOwnDamage = odBeforeNCB - noClaim;
      totalA = netOwnDamage;
      zeroDep = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.zeroDepreciation.toString()) / 100 * od;
      rsa = double.parse(widget.data?.rsa.toString() ?? "0") * od;
      consumable = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.consumables.toString()) / 100 * od;
      tyreCover = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.tyreCover.toString()) / 100 * od;
      ncb = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.ncb.toString()) / 100 * od;
      enginePro = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.enginePro.toString()) / 100 * od;
      valAddService = double.parse(widget.data?.valAddService ?? "0") * od;
      returnInvoice = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.returnInvoice.toString()) / 100 * od;
      otherAddon = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.addonCharge.toString()) / 100 * od;

      totalB = zeroDep +
          rsa + tyreCover + ncb + enginePro + returnInvoice +
          valAddService + otherAddon + consumable;

      paUnnamed = tp * double.parse(widget.data!.paUnnamedPassenger.toString());

      totalC = paUnnamed + double.parse(liability.toString()) + double.parse(widget.data!.paOwnerDriver.toString())
          + double.parse(widget.data!.llPaidDriver.toString()) + cngKit + geoExt;
      totalABC = totalA + totalB + totalC;
      GST = totalABC * 18 / 100;
      cess = totalABC * double.parse(widget.data!.otherCess.toString()) / 100;
      finalTotal = totalABC + GST + cess;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text("Basic Details", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("OD Term (in year)", widget.data?.odTerm.toString()),
                          rowColumn("TP Term (in year)", widget.data?.tpTerm),
                          rowColumn("Age of Vehicle", widget.data?.ageVehicle),
                          rowColumn("IDV", idv.toStringAsFixed(2)),
                          rowColumn("Year of Manufacture", widget.data?.yearOfManufacture),
                          rowColumn("Zone", widget.data?.zone),
                          rowColumn("Cubic Capacity", widget.data?.cubieCapacity),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text("A - Own Damage Premium", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Vehicle Basic Rate", vehicleBasicRate.toString()),
                          rowColumn("Basic for Vehicle", basicVehicle.toStringAsFixed(2)),
                          rowColumn("Discount on OD Premium", disOD.toStringAsFixed(2)),
                          rowColumn("Loading on OD Premium", loadingOD.toStringAsFixed(2)),
                          rowColumn("Basic OD Premium after Discount/Loading", odAfterDis.toStringAsFixed(2)),
                          rowColumn("Electrical/Electronic Accessories", accessories.toStringAsFixed(2)),
                          rowColumn("Non Electrical Accessories", nonAccessories.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit (Externally Fitted)", cngExt.toStringAsFixed(2)),
                          rowColumn("Basic OD Premium", basicODPri.toStringAsFixed(2)),
                          rowColumn("Geographical Ext", geoGrapExt.toStringAsFixed(2)),
                          rowColumn("Fiber Glass Tank", fiberGlass.toStringAsFixed(2)),
                          rowColumn("Driving Tutions", drivingTution.toStringAsFixed(2)),
                          rowColumn("Basic OD Before Deductions", odBeforeDedu.toStringAsFixed(2)),
                          rowColumn("Anti Theft", antiTheft.toStringAsFixed(2)),
                          rowColumn("Handicap", handiCap.toStringAsFixed(2)),
                          rowColumn("AAI", aai.toStringAsFixed(2)),
                          rowColumn("Voluntary Deductible", volDedu.toStringAsFixed(2)),
                          rowColumn("Basic OD Before NCB", odBeforeNCB.toStringAsFixed(2)),
                          rowColumn("No Claim Bonus", noClaim.toStringAsFixed(2)),
                          rowColumn("Net Own Damage Premium (A)", netOwnDamage.toStringAsFixed(2)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text("B - Addon Coverage", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Zero Depreciation", zeroDep.toStringAsFixed(2)),
                          rowColumn("RSA/Additional for Addons", rsa.toStringAsFixed(2)),
                          rowColumn("Consumables", consumable.toStringAsFixed(2)),
                          rowColumn("Tyre Cover", tyreCover.toStringAsFixed(2)),
                          rowColumn("NCB Protections", ncb.toStringAsFixed(2)),
                          rowColumn("Engine Protection", enginePro.toStringAsFixed(2)),
                          rowColumn("Return to Invoice", returnInvoice.toStringAsFixed(2)),
                          rowColumn("Other Addon Coverage", otherAddon.toStringAsFixed(2)),
                          rowColumn("Value Added Service", valAddService.toStringAsFixed(2)),
                          rowColumn("Total Addon Premium (B)", totalB.toStringAsFixed(2)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text("C - Liability Premium", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Liability Premium (TP)", liability.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit", cngKit.toStringAsFixed(2)),
                          rowColumn("Geographical Extn", geoExt.toStringAsFixed(2)),
                          rowColumn("PA to Owner Drive", widget.data?.paOwnerDriver),
                          rowColumn("LL to Paid Driver", widget.data?.llPaidDriver),
                          rowColumn("PA to Unnamed Passenger", paUnnamed.toStringAsFixed(2)),
                          rowColumn("Total Liability Premium (C)", totalC.toStringAsFixed(2)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text("D - Total Premium", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Total Package Premium [A + B + C]", totalABC.toStringAsFixed(2)),
                          rowColumn("GST (18%)", GST.toStringAsFixed(2)),
                          rowColumn("Other CESS", cess.toStringAsFixed(2)),
                          rowColumn("Final Premium", finalTotal.round().toString()),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.darkRedColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleInfoScreen()));
                        }, child: Text("Next", style: TextStyle(color: ColorConstant.whiteColor),)),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget rowColumn(String? title, String? value){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text("$title", style: TextStyle(fontWeight: FontWeight.bold,))),
            Text(": $value")
          ],
        ),
        Divider()
      ],
    );
  }
}
