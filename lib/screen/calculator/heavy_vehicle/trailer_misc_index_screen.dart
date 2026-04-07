import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';

class TrailerMISCIndexScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  TwoWheelerPremiumModel? data;
  TrailerMISCIndexScreen({super.key, this.title, this.bikeCC, this.data});

  @override
  State<TrailerMISCIndexScreen> createState() => _TrailerMISCIndexScreenState();
}

class _TrailerMISCIndexScreenState extends State<TrailerMISCIndexScreen> {
  double idv = 0;
  double vehicleBasicRate = 0;
  double basicVehicle = 0;
  double basicODPri = 0;
  double disODPri = 0;
  double odBeforeDis = 0;
  double odBeforeNCB = 0;
  double noClaim = 0;
  double liability = 0;
  double totalA = 0;
  double totalB = 0;
  double totalAB = 0;
  double GST5 = 0;
  double GST = 0;
  double cess = 0;
  double finalTotal = 0;
  double netOwnDamage = 0;
  double imt23 = 0;
  double tppd = 0;
  double loadingOD = 0;
  double cngExt = 0;
  double cngKit = 0;

  @override
  void initState() {
    initFun();
    super.initState();
  }

  initFun(){
    setState(() {
      liability = double.parse(widget.bikeCC.toString());
      idv = double.parse(widget.data!.currentIDV.toString());
      vehicleBasicRate = 1.05;
      basicVehicle = vehicleBasicRate * double.parse(widget.data!.currentIDV.toString()) / 100;
      if(widget.data?.cngKits == "Yes") {
        cngExt = double.parse(widget.data!.cngEx.toString()) * 4 / 100;
        cngKit = 60;
      }
      basicODPri = basicVehicle + cngExt;
      if(widget.data?.imt23 == "Yes") {
        imt23 = basicVehicle * 15 / 100;
      }
      odBeforeDis = basicVehicle + cngExt + imt23;
      disODPri = (basicVehicle * double.parse(widget.data!.odPremiumDis.toString()) / 100);
      loadingOD = basicVehicle * double.parse(widget.data!.loadingDisPre.toString()) / 100;
      odBeforeNCB = (basicVehicle + cngExt + imt23);


      noClaim = odBeforeNCB * double.parse(widget.data!.noClaimBonus.toString()) / 100;
      netOwnDamage = odBeforeNCB - double.parse(widget.data!.noClaimBonus.toString());
      totalA = netOwnDamage;
      if(widget.data?.tppd == 'Yes'){
        tppd = 200;
      }
      totalB = (double.parse(liability.toString()) + double.parse(widget.data!.paOwnerDriver.toString())
          + double.parse(widget.data!.llPaidDriver.toString()) + double.parse(widget.data!.llEmpPayed.toString())) - tppd;
      totalAB = totalA + totalB;
      GST5 = double.parse(liability.toString()) * 5 / 100;
      GST = totalAB * 18 / 100;
      cess = totalAB * double.parse(widget.data!.otherCess.toString()) / 100;
      finalTotal = totalAB + GST5 + GST + cess;
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
                          rowColumn("Trailers IDV (Attached Trailer)", widget.data?.noTrailers),
                          rowColumn("No of Trailers (Attached)", widget.data?.noTrailers),
                          rowColumn("Trailer Towed by", widget.data?.vehicleType),
                          rowColumn("Age of Vehicle", widget.data?.ageVehicle),
                          rowColumn("Year of Manufacture", widget.data?.yearOfManufacture),
                          rowColumn("Zone", widget.data?.zone),
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
                          rowColumn("Trailer OD", basicVehicle.toStringAsFixed(2)),
                          rowColumn("Basic OD Premium", basicVehicle.toStringAsFixed(2)),
                          rowColumn("Overturning for Cranes", basicVehicle.toStringAsFixed(2)),
                          rowColumn("IMT 23", imt23.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit (Externally Fitted)", cngExt.toStringAsFixed(2)),
                          rowColumn("Basic OD Before Discount", odBeforeDis.toStringAsFixed(2)),
                          rowColumn("Discount on OD Premium", disODPri.toStringAsFixed(2)),
                          rowColumn("Loading on OD Premium", loadingOD.toStringAsFixed(2)),
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
                          Text("B - Liability Premium", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Liability Premium (TP)", liability.toStringAsFixed(2)),
                          rowColumn("Restricted TPPD", tppd.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit", cngKit.toStringAsFixed(2)),
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
                          rowColumn("Total Package Premium [A + B]", totalAB.toStringAsFixed(2)),
                          rowColumn("GST (5%) on Basic TP Liability", GST.toStringAsFixed(2)),
                          rowColumn("GST (18%) on Rest Others", GST.toStringAsFixed(2)),
                          rowColumn("Other CESS", cess.toStringAsFixed(2)),
                          rowColumn("Final Premium", finalTotal.toStringAsFixed(2)),
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
