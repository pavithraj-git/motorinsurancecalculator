import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';
import '../../../model/calculation_model.dart';

class TaxiIndexScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  TwoWheelerPremiumModel? data;
  TaxiIndexScreen({super.key, this.title, this.bikeCC, this.data});

  @override
  State<TaxiIndexScreen> createState() => _TaxiIndexScreenState();
}

class _TaxiIndexScreenState extends State<TaxiIndexScreen> {
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
  double cess = 0;
  double finalTotal = 0;
  double cngExt = 0;
  double antiTheft = 0;
  double cngKit = 0;
  double netOwnDamage = 0;
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
        vehicleBasicRate = 3.284;
      } else if(widget.data?.ageVehicle == "Upto 5 Year" && widget.data?.zone == "B"){
        vehicleBasicRate = 3.191;
      }else if(widget.data?.ageVehicle == "6 to 7 Year" && widget.data?.zone == "A"){
        vehicleBasicRate = 3.366;
      } else if(widget.data?.ageVehicle == "6 to 7 Year" && widget.data?.zone == "B"){
        vehicleBasicRate = 3.271;
      } else if(widget.data?.ageVehicle == "Above 7 Year" && widget.data?.zone == "A"){
        vehicleBasicRate = 3.448;
      } else{
        vehicleBasicRate = 3.351;
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
      if(widget.data?.antiTheft == "Yes"){
        antiTheft = basicODPri * 2.5/ 100;
        if(antiTheft >= 500) antiTheft = 500;
      }
      odBeforeDis = basicVehicle + accessories + cngExt - antiTheft;
      disODPri = odBeforeDis * double.parse(widget.data!.odPremiumDis.toString()) / 100;
      odBeforeNCB = odBeforeDis - disODPri;


      noClaim = odBeforeNCB * double.parse(widget.data!.noClaimBonus.toString()) / 100;
      netOwnDamage = odBeforeNCB - noClaim;
      totalA = netOwnDamage;
      zeroDep = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.zeroDepreciation.toString()) / 100;
      passengerCov = 1162 * double.parse(widget.data!.noPassenger.toString());

      totalB = zeroDep +
          double.parse(widget.data!.rsa.toString());

      totalC = (double.parse(liability.toString()) + double.parse(widget.data!.paOwnerDriver.toString())
          + double.parse(widget.data!.llPaidDriver.toString()) + cngKit + passengerCov);
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
                          rowColumn("cubic Capacity", widget.data?.cubieCapacity),
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
                          rowColumn("Passenger Coverage", passengerCov.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit", cngKit.toStringAsFixed(2)),
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
                          cngExt: cngExt,
                          cngKit: cngKit,
                          basicODPri: basicODPri,
                          antiTheft: antiTheft,
                          odBeforeDis: odBeforeDis,
                          disOD: disODPri,
                          odBeforeNCB: odBeforeNCB,
                          noClaim: noClaim,
                          netOwnDamage: netOwnDamage,
                          totalA: totalA,
                          zeroDep: zeroDep,
                          passCov: passengerCov,
                          totalB: totalB,
                          totalC: totalC,
                          totalABC: totalABC,
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
