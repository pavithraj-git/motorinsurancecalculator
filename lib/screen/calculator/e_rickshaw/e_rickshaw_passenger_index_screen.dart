import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';
import '../../../model/calculation_model.dart';

class ERickshawPessengerIndexScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  TwoWheelerPremiumModel? data;
  ERickshawPessengerIndexScreen({super.key, this.title, this.bikeCC, this.data});

  @override
  State<ERickshawPessengerIndexScreen> createState() => _ERickshawPessengerIndexScreenState();
}

class _ERickshawPessengerIndexScreenState extends State<ERickshawPessengerIndexScreen> {
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
  double totalC = 0;
  double totalABC = 0;
  double GST = 0;
  double cess = 0;
  double finalTotal = 0;
  double netOwnDamage = 0;
  double imt23 = 0;
  double tppd = 0;
  double accessories = 0;
  double loadingOD = 0;
  double passengerCov = 0;

  @override
  void initState() {
    initFun();
    super.initState();
  }

  initFun(){
    setState(() {
      liability = double.parse(widget.bikeCC.toString());
      idv = double.parse(widget.data!.currentIDV.toString());
      if(widget.data?.ageVehicle == "Upto 5 Year" && widget.data?.zone == "A"){
        vehicleBasicRate = 1.278;
      } else if(widget.data?.ageVehicle == "Upto 5 Year" && widget.data?.zone == "B"){
        vehicleBasicRate = 1.272;
      } else if(widget.data?.ageVehicle == "Upto 5 Year" && widget.data?.zone == "C"){
        vehicleBasicRate = 1.26;
      } else if(widget.data?.ageVehicle == "6 to 7 Year" && widget.data?.zone == "A"){
        vehicleBasicRate = 1.31;
      } else if(widget.data?.ageVehicle == "6 to 7 Year" && widget.data?.zone == "B"){
        vehicleBasicRate = 1.304;
      } else if(widget.data?.ageVehicle == "6 to 7 Year" && widget.data?.zone == "C"){
        vehicleBasicRate = 1.292;
      } else if(widget.data?.ageVehicle == "Above 7 Year" && widget.data?.zone == "A"){
        vehicleBasicRate = 1.342;
      } else if(widget.data?.ageVehicle == "Above 7 Year" && widget.data?.zone == "B"){
        vehicleBasicRate = 1.336;
      } else{
        vehicleBasicRate = 1.323;
      }
      basicVehicle = vehicleBasicRate * double.parse(widget.data!.currentIDV.toString()) / 100;
      accessories = double.parse(widget.data!.electricalAcc.toString()) * 4 / 100;
      basicODPri = basicVehicle + accessories;
      if(widget.data?.imt23 == "Yes") {
        imt23 = basicODPri * 15 / 100;
      }
      odBeforeDis = basicVehicle + imt23 + accessories;
      disODPri = (odBeforeDis * double.parse(widget.data!.odPremiumDis.toString()) / 100);
      loadingOD = odBeforeDis * double.parse(widget.data!.loadingDisPre.toString()) / 100;
      odBeforeNCB = (basicVehicle + imt23 + accessories + loadingOD - disODPri);


      noClaim = odBeforeNCB * double.parse(widget.data!.noClaimBonus.toString()) / 100;
      netOwnDamage = odBeforeNCB - noClaim;
      totalA = netOwnDamage;
      totalB = double.parse(widget.data!.valAddService.toString());
      passengerCov = 737 * double.parse(widget.data!.noPassenger.toString());
      if(widget.data?.tppd == 'Yes'){
        tppd = 200;
      }
      totalC = (double.parse(liability.toString()) + double.parse(widget.data!.paOwnerDriver.toString())
          + double.parse(widget.data!.llPaidDriver.toString()) + passengerCov) - tppd;
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
                          rowColumn("IDV", idv.toStringAsFixed(2)),
                          rowColumn("Age of Vehicle", widget.data?.ageVehicle),
                          rowColumn("Year of Manufacture", widget.data?.yearOfManufacture),
                          rowColumn("Zone", widget.data?.zone),
                          rowColumn("No of Passengers", widget.data?.noPassenger),
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
                          rowColumn("Basic OD Premium", basicODPri.toStringAsFixed(2)),
                          rowColumn("IMT 23", imt23.toStringAsFixed(2)),
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
                          Text("B - Addon Coverage", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Value Added Service", widget.data?.valAddService),
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
                          rowColumn("Passenger Coverage", passengerCov.toStringAsFixed(2)),
                          rowColumn("Restricted TPPD", tppd.toStringAsFixed(2)),
                          rowColumn("PA to Owner Drive", widget.data?.paOwnerDriver),
                          rowColumn("LL to Paid Driver", widget.data?.llPaidDriver),
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
                          CalculationModel clt = CalculationModel(
                              liability: liability,
                              idv: idv,
                              vehicleBasicRate: vehicleBasicRate,
                              basicVehicle: basicVehicle,
                              accessories: accessories,
                              basicODPri: basicODPri,
                              imt23: imt23,
                              odBeforeDis: odBeforeDis,
                              disOnODPre: disODPri,
                              loadingOD: loadingOD,
                              odBeforeNCB: odBeforeNCB,
                              noClaim: noClaim,
                              netOwnDamage: netOwnDamage,
                              totalA: totalA,
                              totalB: totalB,
                              passCov: passengerCov,
                              tppd: tppd,
                              totalC: totalC,
                              totalABC: totalABC,
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
