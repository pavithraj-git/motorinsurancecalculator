import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';
import '../../../model/calculation_model.dart';

class CarryingPublicIndexScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  TwoWheelerPremiumModel? data;
  CarryingPublicIndexScreen({super.key, this.title, this.bikeCC, this.data});

  @override
  State<CarryingPublicIndexScreen> createState() => _CarryingPublicIndexScreenState();
}

class _CarryingPublicIndexScreenState extends State<CarryingPublicIndexScreen> {
  double idv = 0;
  double vehicleBasicRate = 0;
  double basicVehicle = 0;
  double basicODPri = 0;
  double disODPri = 0;
  double accessories = 0;
  double odBeforeDis = 0;
  double odBeforeNCB = 0;
  double noClaim = 0;
  double zeroDep = 0;
  double liability = 0;
  double totalA = 0;
  double totalB = 0;
  double totalC = 0;
  double totalABC = 0;
  double GST = 0;
  double GST5 = 0;
  double cess = 0;
  double finalTotal = 0;
  double cngExt = 0;
  double antiTheft = 0;
  double cngKit = 0;
  double netOwnDamage = 0;
  double geoGrapExt = 0;
  double geoExt = 0;
  double imt23 = 0;
  double llEmpPayed = 0;
  double tppd = 0;

  @override
  void initState() {
    initFun();
    super.initState();
  }

  initFun(){
    setState(() {
      liability = double.parse(widget.bikeCC.toString());
      idv = double.parse(widget.data!.currentIDV.toString());
      if(widget.title == "Goods Carrying Vehicle - Public" || widget.title == "Electric Goods Carrying Vehicle - Public") {
        if (widget.data?.ageVehicle == "Upto 5 Year" &&
            widget.data?.zone == "A") {
          vehicleBasicRate = 1.751;
        } else if (widget.data?.ageVehicle == "Upto 5 Year" &&
            widget.data?.zone == "B") {
          vehicleBasicRate = 1.743;
        } else if (widget.data?.ageVehicle == "Upto 5 Year" &&
            widget.data?.zone == "C") {
          vehicleBasicRate = 1.726;
        } else if (widget.data?.ageVehicle == "6 to 7 Year" &&
            widget.data?.zone == "A") {
          vehicleBasicRate = 1.795;
        } else if (widget.data?.ageVehicle == "6 to 7 Year" &&
            widget.data?.zone == "B") {
          vehicleBasicRate = 1.787;
        } else if (widget.data?.ageVehicle == "6 to 7 Year" &&
            widget.data?.zone == "C") {
          vehicleBasicRate = 1.77;
        } else if (widget.data?.ageVehicle == "Above 7 Year" &&
            widget.data?.zone == "A") {
          vehicleBasicRate = 1.839;
        } else if (widget.data?.ageVehicle == "Above 7 Year" &&
            widget.data?.zone == "B") {
          vehicleBasicRate = 1.83;
        } else {
          vehicleBasicRate = 1.812;
        }
      } else {
        if (widget.data?.ageVehicle == "Upto 5 Year" &&
            widget.data?.zone == "A") {
          vehicleBasicRate = 1.226;
        } else if (widget.data?.ageVehicle == "Upto 5 Year" &&
            widget.data?.zone == "B") {
          vehicleBasicRate = 1.22;
        } else if (widget.data?.ageVehicle == "Upto 5 Year" &&
            widget.data?.zone == "C") {
          vehicleBasicRate = 1.208;
        } else if (widget.data?.ageVehicle == "6 to 7 Year" &&
            widget.data?.zone == "A") {
          vehicleBasicRate = 1.257;
        } else if (widget.data?.ageVehicle == "6 to 7 Year" &&
            widget.data?.zone == "B") {
          vehicleBasicRate = 1.251;
        } else if (widget.data?.ageVehicle == "6 to 7 Year" &&
            widget.data?.zone == "C") {
          vehicleBasicRate = 1.239;
        } else if (widget.data?.ageVehicle == "Above 7 Year" &&
            widget.data?.zone == "A") {
          vehicleBasicRate = 1.287;
        } else if (widget.data?.ageVehicle == "Above 7 Year" &&
            widget.data?.zone == "B") {
          vehicleBasicRate = 1.281;
        } else {
          vehicleBasicRate = 1.268;
        }
      }
      basicVehicle = vehicleBasicRate * double.parse(widget.data!.currentIDV.toString()) / 100;
      accessories = double.parse(widget.data!.electricalAcc.toString()) * 4 / 100;
      if(widget.data?.cngKits == "Yes") {
        cngExt = double.parse(widget.data!.cngEx.toString()) * 4 / 100;
        if(cngExt == 0){
          cngExt = basicVehicle * 5 / 100;
        }
        cngKit = 60;
      }
      basicODPri = basicVehicle + accessories + cngExt;
      geoGrapExt = double.parse(widget.data!.geoGrap.toString());
      if(geoGrapExt == 400){
        geoExt = 100;
      }
      if(widget.data?.imt23 == "Yes") {
        imt23 = basicODPri * 15 / 100;
        if(geoGrapExt == 400) imt23 = imt23 + 60;
      }
      if(widget.data?.antiTheft == "Yes"){
        antiTheft = basicODPri * 2.5/ 100;
        if(antiTheft >= 500) antiTheft = 500;
      }
      odBeforeDis = basicVehicle + accessories + cngExt + geoGrapExt + imt23 - antiTheft;
      disODPri = odBeforeDis * double.parse(widget.data!.odPremiumDis.toString()) / 100;
      odBeforeNCB = odBeforeDis - disODPri;


      noClaim = odBeforeNCB * double.parse(widget.data!.noClaimBonus.toString()) / 100;
      netOwnDamage = odBeforeNCB - noClaim;
      totalA = netOwnDamage;
      zeroDep = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.zeroDepreciation.toString()) / 100;


      totalB = zeroDep +
          double.parse(widget.data!.rsa.toString());
      llEmpPayed = double.parse(widget.data!.llEmpPayed.toString());
      if(widget.data?.tppd == 'Yes'){
        tppd = 200;
      }
      totalC = (llEmpPayed + double.parse(liability.toString()) + double.parse(widget.data!.paOwnerDriver.toString())
          + double.parse(widget.data!.llPaidDriver.toString()) + cngKit + geoExt) - tppd;
      totalABC = totalA + totalB + totalC;
      GST5 = (double.parse(liability.toString()) - tppd) * 5 / 100;
      GST = (totalA + totalB + double.parse(widget.data!.llPaidDriver.toString()) + cngKit + geoExt
      + double.parse(widget.data!.paOwnerDriver.toString()) + llEmpPayed) * 18 / 100;
      cess = totalABC * double.parse(widget.data!.otherCess.toString()) / 100;
      finalTotal = totalABC + GST + GST5  + cess;
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
                          rowColumn("IDV", idv.toStringAsFixed(2)),
                          rowColumn("Age of Vehicle", widget.data?.ageVehicle),
                          rowColumn("Year of Manufacture", widget.data?.yearOfManufacture),
                          rowColumn("Zone", widget.data?.zone),
                          rowColumn("Gross Vehicle Weight", widget.data?.grassWeight),
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
                          rowColumn("Electrical/Electronic Accessories", accessories.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit (Externally Fitted)", cngExt.toStringAsFixed(2)),
                          rowColumn("Basic OD Premium", basicODPri.toStringAsFixed(2)),
                          rowColumn("Geographical Ext", geoGrapExt.toStringAsFixed(2)),
                          rowColumn("IMT 23", imt23.toStringAsFixed(2)),
                          rowColumn("Anti Theft", antiTheft.toStringAsFixed(2)),
                          rowColumn("Basic OD Before Discount", odBeforeDis.toStringAsFixed(2)),
                          rowColumn("Discount on OD Premium", disODPri.toStringAsFixed(2)),
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
                          rowColumn("RSA/Additional for Addons", widget.data?.rsa.toString()),
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
                          rowColumn("Restricted TP PD", tppd.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit", cngKit.toStringAsFixed(2)),
                          rowColumn("Geographical Ext", geoExt.toStringAsFixed(2)),
                          rowColumn("PA to Owner Drive", widget.data?.paOwnerDriver),
                          rowColumn("LL to Paid Driver", widget.data?.llPaidDriver),
                          rowColumn("LL to Employee other than Paid Driver", llEmpPayed.toStringAsFixed(2)),
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
                          rowColumn("GST (5%) on Basic TP Liability", GST5.toStringAsFixed(2)),
                          rowColumn("GST (18%) on Rest Others", GST.toStringAsFixed(2)),
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
                          CalculationModel clt = CalculationModel(
                          liability: liability,
                          idv: idv,
                          vehicleBasicRate: vehicleBasicRate,
                          basicVehicle: basicVehicle,
                          accessories: accessories,
                          cngExt: cngExt,
                          cngKit: cngKit,
                          basicODPri: basicODPri,
                          geoGrapExt: geoGrapExt,
                          geoExt: geoExt,
                          imt23: imt23,
                          antiTheft: antiTheft,
                          odBeforeDis: odBeforeDis,
                          disOD: disODPri,
                          odBeforeNCB: odBeforeNCB,
                          noClaim: noClaim,
                          netOwnDamage: netOwnDamage,
                          totalA: totalA,
                          zeroDep: zeroDep,
                          totalB: totalB,
                          llEmpPayed: llEmpPayed,
                          tppd: tppd,
                          totalC: totalC,
                          totalABC: totalABC,
                          GST5: GST5,
                          GST: GST,
                          cess: cess,
                          finalTotal: finalTotal
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleInfoScreen(title: widget.title, calculation: clt, value: widget.data)));
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
