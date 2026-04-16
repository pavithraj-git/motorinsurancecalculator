import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/model/calculation_model.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';
import '../../../controller/two_wheeler_controller.dart';


class TwoWheelerPremiumIndexScreen extends StatefulWidget {
  String? title;
  TwoWheelerPremiumModel? data;
  TwoWheelerPremiumIndexScreen({super.key, this.title, this.data});

  @override
  State<TwoWheelerPremiumIndexScreen> createState() => _TwoWheelerPremiumIndexScreenState();
}

class _TwoWheelerPremiumIndexScreenState extends State<TwoWheelerPremiumIndexScreen> {
  double idv = 0;
  double vehicleBasicRate = 0;
  double basicVehicle = 0;
  double disOD = 0;
  double odAfterDis = 0;
  double accessories = 0;
  double totalPremium = 0;
  double netOwnDamage = 0;
  double noClaim = 0;
  double zeroDep = 0;
  double liability = 0;
  // double tppd = 0;
  double totalA = 0;
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
      if(widget.title == "Two Wheeler Premium"){
        liability = two.liabilityTP(widget.data?.cubieCapacity);
      } else {
        liability = two.fiveLiabilityTP(widget.data?.cubieCapacity);
      }
      idv = double.parse(widget.data!.currentIDV.toString());
      vehicleBasicRate = two.vehicleBasicRate(widget.data?.ageVehicle, widget.data?.zone, widget.data?.cubieCapacity);
      basicVehicle = vehicleBasicRate * double.parse(widget.data!.currentIDV.toString()) / 100;
      disOD = basicVehicle * double.parse(widget.data!.odPremiumDis.toString()) / 100;
      odAfterDis = basicVehicle - disOD;
      accessories = double.parse(widget.data!.accessoriesValue.toString()) * 4 / 100;
      totalPremium = odAfterDis + accessories;
      noClaim = totalPremium * double.parse(widget.data!.noClaimBonus.toString()) / 100;
      netOwnDamage = totalPremium - noClaim;
      zeroDep = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.zeroDepreciation.toString()) / 100;
      // if(widget.data?.tppd == 'Yes'){
      //   tppd = liability * 5 / 100;
      // }
      totalA = netOwnDamage + zeroDep;
      totalB = (double.parse(liability.toString()) +
          double.parse(widget.data!.paOwnerDriver.toString())+
          double.parse(widget.data!.paUnnamedPassenger.toString())+
          double.parse(widget.data!.llPaidDriver.toString()));
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
                          rowColumn("Discount on OD Premium", disOD.toStringAsFixed(2)),
                          rowColumn("Basic OD Premium after discount", odAfterDis.toStringAsFixed(2)),
                          rowColumn("Accessories Value", accessories.toStringAsFixed(2)),
                          rowColumn("Total Basic Premium", totalPremium.toStringAsFixed(2)),
                          rowColumn("No Claim Bonus", noClaim.toStringAsFixed(2)),
                          rowColumn("Net Own Damage Premium", netOwnDamage.toStringAsFixed(2)),
                          rowColumn("Zero Dep Premium", zeroDep.toStringAsFixed(2)),
                          rowColumn("Total-[A]", totalA.toStringAsFixed(2)),
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
                          // rowColumn("Restricted TP PD", tppd.toString()),
                          rowColumn("PA to Owner Drive", widget.data?.paOwnerDriver),
                          rowColumn("LL to Paid Driver", widget.data?.llPaidDriver),
                          rowColumn("PA to Unnamed Passenger", widget.data?.paUnnamedPassenger),
                          rowColumn("Total-[B]", totalB.toStringAsFixed(2)),
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
                              noClaim: noClaim,
                              zeroDep: zeroDep,
                            finalTotal: finalTotal.round().toDouble(),
                            liability: liability,
                            netOwnDamage: netOwnDamage,
                            totalAB: totalAB,
                            GST: GST,
                            cess: cess,
                            totalA: totalA,
                            totalB: totalB,
                            basicVehicle: basicVehicle,
                            disOD: disOD,
                            accessories: accessories,
                            totalPremium: totalPremium,
                            vehicleBasicRate: vehicleBasicRate,
                            idv: idv,
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
