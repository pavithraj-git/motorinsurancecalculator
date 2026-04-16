import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';
import '../../../controller/two_wheeler_controller.dart';
import '../../../model/calculation_model.dart';

class TwoWheelerPassengerIndexScreen extends StatefulWidget {
  String? title;
  TwoWheelerPremiumModel? data;
  TwoWheelerPassengerIndexScreen({super.key, this.title, this.data});

  @override
  State<TwoWheelerPassengerIndexScreen> createState() => _TwoWheelerPassengerIndexScreenState();
}

class _TwoWheelerPassengerIndexScreenState extends State<TwoWheelerPassengerIndexScreen> {
  double idv = 0;
  double vehicleBasicRate = 0;
  double basicVehicle = 0;
  double accessories = 0;
  double cngExt = 0;
  double basicODPri = 0;
  double imt23 = 0;
  double odBeforeDis = 0;
  double disOnODPre = 0;
  double odBeforeNCB = 0;
  double netOwnDamage = 0;
  double noClaim = 0;
  double liability = 0;
  double tppd = 0;
  double totalA = 0;
  double passCov = 0;
  double cngKit = 0;
  double totalB = 0;
  double totalAB = 0;
  double GST = 0;
  double cess = 0;
  double finalTotal = 0;

  final TwoWheelerController two = TwoWheelerController();

  @override
  void initState() {
    initFun();
    super.initState();
  }

  initFun(){
    setState(() {
      liability = two.passengerLiabilityTP(widget.data?.cubieCapacity);
      idv = double.parse(widget.data!.currentIDV.toString());
      vehicleBasicRate = two.vehicleBasicRate(widget.data?.ageVehicle, widget.data?.zone, widget.data?.cubieCapacity);
      basicVehicle = vehicleBasicRate * idv / 100;
      accessories = double.parse(widget.data!.accessoriesValue.toString()) * 4 / 100;
      if(widget.data?.cngKits == "Yes") {
        cngExt = double.parse(widget.data!.cngEx.toString()) * 4 / 100;
        if(cngExt == 0){
          cngExt = basicVehicle * 5 / 100;
        }
        cngKit = 60;
      }
      basicODPri = basicVehicle + accessories + cngExt;
      if(widget.data?.imt23 == "Yes") {
        imt23 = basicODPri * 15 / 100;
      }
      odBeforeDis = basicODPri + imt23;
      disOnODPre = odBeforeDis * double.parse(widget.data!.odPremiumDis.toString()) / 100;
      odBeforeNCB = odBeforeDis - disOnODPre;
      noClaim = odBeforeNCB * double.parse(widget.data!.noClaimBonus.toString()) / 100;
      netOwnDamage = odBeforeNCB - noClaim;
      if(widget.data?.tppd == 'Yes'){
        tppd = 50;
      }
      totalA = netOwnDamage;
      passCov = 580 * double.parse(widget.data!.noPassenger.toString());
      totalB = (double.parse(liability.toString()) +
          double.parse(widget.data!.paOwnerDriver.toString())+
          passCov + cngKit +
          double.parse(widget.data!.llPaidDriver.toString()) - tppd);
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
                          rowColumn("Year of Manufacture", widget.data?.yearOfManufacture),
                          rowColumn("Zone", widget.data?.zone),
                          rowColumn("Cubic Capacity", widget.data?.cubieCapacity),
                          rowColumn("No of Passenger", widget.data?.noPassenger),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text("A - Own Damage Premium Package", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Vehicle Basic Rate", vehicleBasicRate.toString()),
                          rowColumn("Basic for Vehicle", basicVehicle.toStringAsFixed(2)),
                          rowColumn("Accessories Value", accessories.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit (Externally Fitted)", cngExt.toStringAsFixed(2)),
                          rowColumn("Basic OD Premium", basicODPri.toStringAsFixed(2)),
                          rowColumn("IMT 23", imt23.toStringAsFixed(2)),
                          rowColumn("Basic OD before discount", odBeforeDis.toStringAsFixed(2)),
                          rowColumn("Discount on OD Premium", disOnODPre.toStringAsFixed(2)),
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
                          rowColumn("Liability Premium (TP)", liability.toString()),
                          rowColumn("Passenger Coverage", passCov.toString()),
                          rowColumn("CNG/LPG Kit", cngKit.toString()),
                          rowColumn("PA to Owner Drive", widget.data?.paOwnerDriver),
                          rowColumn("LL to Paid Driver", widget.data?.llPaidDriver),
                          rowColumn("Restricted TP PD", tppd.toString()),
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
                          imt23: imt23,
                          odBeforeDis: odBeforeDis,
                          disOnODPre:disOnODPre,
                          odBeforeNCB: odBeforeNCB,
                          noClaim: noClaim,
                          netOwnDamage: netOwnDamage,
                          tppd: tppd,
                          totalA: totalA,
                          passCov: passCov,
                          totalB: totalB,
                          totalAB: totalAB,
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
