import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';
import '../../../model/calculation_model.dart';

class MISCIndexScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  TwoWheelerPremiumModel? data;
  MISCIndexScreen({super.key, this.title, this.bikeCC, this.data});

  @override
  State<MISCIndexScreen> createState() => _MISCIndexScreenState();
}

class _MISCIndexScreenState extends State<MISCIndexScreen> {
  double idv = 0;
  double vehicleBasicRate = 0;
  double basicVehicle = 0;
  double disODPri = 0;
  double odAfterDis = 0;
  double odBeforeNCB = 0;
  double noClaim = 0;
  double liability = 0;
  double totalA = 0;
  double totalB = 0;
  double totalAB = 0;
  double GST = 0;
  double cess = 0;
  double finalTotal = 0;
  double netOwnDamage = 0;
  double imt23 = 0;
  double geoGrapExt = 0;
  double geoExt = 0;
  double overCranes = 0;

  @override
  void initState() {
    initFun();
    super.initState();
  }

  initFun(){
    setState(() {
      liability = double.parse(widget.bikeCC.toString());
      idv = double.parse(widget.data!.currentIDV.toString());
      if(widget.data?.vehicleType == "Agriculture Tractors upto 6 HP"){
        liability = 1645;
      }
      if(widget.data?.ageVehicle == "Upto 5 Year" && widget.data?.zone == "A"){
        vehicleBasicRate = 1.208;
      } else if(widget.data?.ageVehicle == "Upto 5 Year" && widget.data?.zone == "B"){
        vehicleBasicRate = 1.202;
      } else if(widget.data?.ageVehicle == "Upto 5 Year" && widget.data?.zone == "C"){
        vehicleBasicRate = 1.19;
      } else if(widget.data?.ageVehicle == "6 to 7 Year" && widget.data?.zone == "A"){
        vehicleBasicRate = 1.238;
      } else if(widget.data?.ageVehicle == "6 to 7 Year" && widget.data?.zone == "B"){
        vehicleBasicRate = 1.232;
      } else if(widget.data?.ageVehicle == "6 to 7 Year" && widget.data?.zone == "C"){
        vehicleBasicRate = 1.22;
      } else if(widget.data?.ageVehicle == "Above 7 Year" && widget.data?.zone == "A"){
        vehicleBasicRate = 1.268;
      } else if(widget.data?.ageVehicle == "Above 7 Year" && widget.data?.zone == "B"){
        vehicleBasicRate = 1.262;
      } else{
        vehicleBasicRate = 1.25;
      }
      basicVehicle = vehicleBasicRate * double.parse(widget.data!.currentIDV.toString()) / 100;
      disODPri = (basicVehicle * double.parse(widget.data!.odPremiumDis.toString()) / 100);
      odAfterDis = basicVehicle - disODPri;
      geoGrapExt = double.parse(widget.data!.geoGrap.toString());
      if(geoGrapExt == 400){
        geoExt = 100;
      }
      if(widget.data?.overCranes == "Yes") {
        overCranes = odAfterDis / 10;
      }
      if(widget.data?.imt23 == "Yes") {
        imt23 = odAfterDis * 15 / 100;
        // if(geoGrapExt == 400) imt23 = imt23 + 60;
      }
      odBeforeNCB = (odAfterDis + geoGrapExt + overCranes + imt23);

      noClaim = odBeforeNCB * double.parse(widget.data!.noClaimBonus.toString()) / 100;
      netOwnDamage = odBeforeNCB - noClaim;
      totalA = netOwnDamage;
      totalB = (double.parse(liability.toString()) + double.parse(widget.data!.paOwnerDriver.toString())
          + double.parse(widget.data!.llPaidDriver.toString()) + geoExt
          + double.parse(widget.data!.llEmpPayed.toString()));
      totalAB = totalA + totalB;
      GST = totalAB * 18 / 100;
      cess = totalAB * double.parse(widget.data!.otherCess.toString()) / 100;
      finalTotal = totalAB + GST + cess;
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
                          rowColumn("Vehicle Type", widget.data?.vehicleType),
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
                          rowColumn("Discount on OD Premium", disODPri.toStringAsFixed(2)),
                          rowColumn("Basic OD After Discount", odAfterDis.toStringAsFixed(2)),
                          rowColumn("Geographical Ext", geoGrapExt.toStringAsFixed(2)),
                          rowColumn("Overturning for Cranes", overCranes.toStringAsFixed(2)),
                          rowColumn("IMT 23", imt23.toStringAsFixed(2)),
                          rowColumn("Total Own Damage Premium", odBeforeNCB.toStringAsFixed(2)),
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
                          Text("B - Liability Premium", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Liability Premium (TP)", liability.toString()),
                          rowColumn("Geographical Ext", geoExt.toStringAsFixed(2)),
                          rowColumn("PA to Owner Drive", widget.data?.paOwnerDriver),
                          rowColumn("LL to Paid Driver", widget.data?.llPaidDriver),
                          rowColumn("LL Employee other than Paid Driver", widget.data?.llEmpPayed),
                          rowColumn("Total Liability Premium (B)", totalB.toStringAsFixed(2)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text("C - Total Premium", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Total Premium before Service Tax [A + B]", totalAB.toStringAsFixed(2)),
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
                          CalculationModel clt =  CalculationModel(
                          liability: liability,
                          idv: idv,
                          vehicleBasicRate: vehicleBasicRate,
                          basicVehicle: basicVehicle,
                          disOnODPre: disODPri,
                          odAfterDis: odAfterDis,
                          geoGrapExt: geoGrapExt,
                          geoExt: geoExt,
                          overCranes: overCranes,
                          imt23: imt23,
                          odBeforeNCB: odBeforeNCB,
                          noClaim: noClaim,
                          netOwnDamage: netOwnDamage,
                          totalA: totalA,
                          totalB: totalB,
                          totalABC: totalAB,
                          GST: GST,
                          cess: cess,
                          finalTotal: finalTotal,
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
