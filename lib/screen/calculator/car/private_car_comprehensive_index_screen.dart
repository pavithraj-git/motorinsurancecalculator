import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';
import '../../../controller/private_car_comprehensive_controller.dart';
import '../../../model/calculation_model.dart';
import '../../../model/two_wheeler_premium_model.dart';

class PrivateCarComprehensiveIndexScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  TwoWheelerPremiumModel? data;
  PrivateCarComprehensiveIndexScreen({super.key, this.title, this.bikeCC, this.data});

  @override
  State<PrivateCarComprehensiveIndexScreen> createState() => _PrivateCarComprehensiveIndexScreenState();
}

class _PrivateCarComprehensiveIndexScreenState extends State<PrivateCarComprehensiveIndexScreen> {

  String? vehicleAge = "0 Day";
  double? vehicleBasicRate = 0.0;
  double? vehicleValue = 0.0;
  double? basicVehicle = 0.0;
  double? accessories = 0.0;
  double? nonAccessories = 0.0;
  double? basicODDis = 0.0;
  double? cngExt = 0.0;
  double? noClaim = 0.0;
  double? totalA = 0.0;
  double? nilDep = 0.0;
  double? nilDepAddon = 0.0;
  double totalB = 0.0;
  double cngKit = 0.0;
  double basicTP = 0.0;
  double tppdRes = 0.0;
  double paOwner = 0.0;
  double llDriver = 0.0;
  double unNamedpa = 0.0;
  double totalC = 0.0;
  double totalABC = 0.0;
  double CGST = 0.0;
  double SGST = 0.0;
  double finalTotal = 0.0;
  double specialODDis = 0.0;
  double specialTPDis = 0.0;
  double specialNPDis = 0.0;
  double specialDisAmt = 0.0;
  double specialDisPrice = 0.0;

  PrivateCarComprehensiveController two = PrivateCarComprehensiveController();
  @override
  void initState() {
    initFun();
    super.initState();
  }

  initFun(){
    setState(() {
      vehicleAge = two.getRemaining(DateFormat("dd-MM-yyyy").parse(widget.data!.regDate!))!;
      vehicleBasicRate = two.vehicleBasicRateSAOD(widget.data?.regDate, widget.data?.zone, widget.data?.cc);
      accessories = double.parse(widget.data!.electricalAcc.toString()) * 4 / 100;
      nonAccessories = double.parse(widget.data!.nonElectAcce.toString()) * vehicleBasicRate! / 100;
      vehicleValue = (double.parse(widget.data!.vehicleValue.toString()) + double.parse(widget.data!.electricalAcc.toString()) + double.parse(widget.data!.nonElectAcce.toString()));
      basicVehicle = (double.parse(widget.data!.vehicleValue.toString()) + double.parse(widget.data!.nonElectAcce.toString())) * vehicleBasicRate! / 100;
      if(widget.data?.cngKits == "INBUILT"){
        cngExt = basicVehicle! * 5 / 100;
        cngKit = 60;
      } else if(widget.data?.cngKits == "EXTERNAL"){
        cngExt = double.parse(widget.data!.cngKitValue.toString()) * 4 / 100;
        cngKit = 60;
      }
      basicODDis = ((basicVehicle! + cngExt!) * double.parse(widget.data!.ODDis.toString()) / 100);
      double basicODDisBase = (basicVehicle! * double.parse(widget.data!.ODDis.toString()) / 100);
      if(widget.data?.noClaimBonus == "0 to 20%") {
        noClaim = (basicVehicle! - basicODDisBase + accessories!) * 20 / 100;
      } else if(widget.data?.noClaimBonus == "20 to 25%") {
        noClaim = (basicVehicle! - basicODDisBase + accessories!) * 25 / 100;
      } else if(widget.data?.noClaimBonus == "25 to 35%") {
        noClaim = (basicVehicle! - basicODDisBase + accessories!) * 35 / 100;
      } else if(widget.data?.noClaimBonus == "35 to 45%") {
        noClaim = (basicVehicle! - basicODDisBase + accessories!) * 45 / 100;
      } else if(widget.data?.noClaimBonus == "45 to 50%") {
        noClaim = (basicVehicle! - basicODDisBase + accessories!) * 50 / 100;
      } else if(widget.data?.noClaimBonus == "50 to 50%") {
        noClaim = (basicVehicle! - basicODDisBase + accessories!) * 50 / 100;
      }
      totalA = basicVehicle! - basicODDis! + cngExt! + accessories! - noClaim!;

      nilDep = double.parse(widget.data!.nilDep.toString()) * vehicleValue! / 100;
      nilDepAddon = double.parse(widget.data!.addonCharge.toString());
      totalB = nilDep! + nilDepAddon!;

      if(widget.data?.cc == "0 - 1000 CC") {
        basicTP = 2094;
      } else if(widget.data?.cc == "1001 - 1500 CC") {
        basicTP = 3416;
      } else if(widget.data?.cc == "1501 - Above CC") {
        basicTP = 7897;
      }
      if(widget.data?.tppd == "Yes") {
        tppdRes = 100;
      }
      paOwner = double.parse(widget.data!.paOwnerDriver.toString());
      llDriver = 50 * double.parse(widget.data!.legalLib.toString());
      unNamedpa = double.parse(widget.data!.paUnnamedPassenger.toString());
      totalC = basicTP + paOwner + llDriver + unNamedpa + cngKit - tppdRes;

      totalABC = totalA! + totalB + totalC;
      CGST = totalABC * 9 / 100;
      SGST = totalABC * 9 / 100;
      finalTotal = totalABC + CGST + SGST;

      specialODDis = (totalA! + totalB) * double.parse(widget.data!.specialODDis.toString()) / 100;
      specialTPDis = totalC * double.parse(widget.data!.specialTPDis.toString()) / 100;
      specialNPDis = totalABC * double.parse(widget.data!.specialNPDis.toString()) / 100;
      specialDisAmt = double.parse(widget.data!.specialDis.toString());
      specialDisPrice = finalTotal - specialNPDis - specialDisAmt - specialODDis - specialTPDis;

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
                          Text("Vehicle Info", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Fuel Type", widget.data?.fuelType.toString()),
                          rowColumn("Cubic Capacity", widget.data?.cc),
                          rowColumn("Vehicle Age", vehicleAge),
                          rowColumn("Zone Type", widget.data?.zone),
                          rowColumn("Vehicle Value", vehicleValue.toString()),
                          rowColumn("Any Claim in Previous Policy", widget.data?.claimPrePo.toString()),
                          rowColumn("Name Transfer", widget.data?.nameTra.toString()),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text("A - Own Damage Coverages", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Basic OD Rate", vehicleBasicRate.toString()),
                          rowColumn("Basic OD Premium", basicVehicle?.toStringAsFixed(2)),
                          rowColumn("Basic OD Discount (${widget.data?.ODDis}%)", basicODDis?.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit (${widget.data?.cngKits})", cngExt?.toStringAsFixed(2)),
                          rowColumn("Electrical/Electronic Accessories", accessories?.toStringAsFixed(2)),
                          rowColumn("Non Electrical Accessories", nonAccessories?.toStringAsFixed(2)),
                          rowColumn("No Claim Bonus (${widget.data?.noClaimBonus})", noClaim?.toStringAsFixed(2)),
                          rowColumn("Total Own Damage Premium (A)", totalA?.toStringAsFixed(2)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text("B - Addon On Coverage", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Nil Depreciation", nilDep?.toStringAsFixed(2)),
                          rowColumn("Nil Dep Addon", nilDepAddon?.toStringAsFixed(2)),
                          rowColumn("Nil Dep Premium (B)", totalB.toStringAsFixed(2)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text("C - Third Party Coverage", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Basic TP", basicTP.toStringAsFixed(2)),
                          rowColumn("TPPD Restriction", tppdRes.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit TP", cngKit.toStringAsFixed(2)),
                          rowColumn("PA Owner", paOwner.toStringAsFixed(2)),
                          rowColumn("LL Driver", llDriver.toStringAsFixed(2)),
                          rowColumn("Unnamed PA", unNamedpa.toStringAsFixed(2)),
                          rowColumn("Total TP Premium (C)", totalC.toStringAsFixed(2)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text("Total Premium Coverages", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Net Premium [A + B + C]", totalABC.toStringAsFixed(2)),
                          rowColumn("CGST", CGST.toStringAsFixed(2)),
                          rowColumn("SGST", SGST.toStringAsFixed(2)),
                          rowColumn("Total Premium", finalTotal.round().toString()),
                          rowColumn("Special OD Discount", specialODDis.toStringAsFixed(2).toString()),
                          rowColumn("Special TP Discount", specialTPDis.toStringAsFixed(2).toString()),
                          rowColumn("Special NP Discount", specialNPDis.toStringAsFixed(2).toString()),
                          rowColumn("Special Discount Amount", specialDisAmt.toStringAsFixed(2).toString()),
                          rowColumn("Special Price", specialDisPrice.round().toString()),
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
                          vehicleAge: vehicleAge,
                          vehicleBasicRate: vehicleBasicRate,
                          accessories: accessories,
                          nonElecAcc: nonAccessories,
                          vehicleValue: vehicleValue,
                          basicVehicle: basicVehicle,
                          cngExt: cngExt,
                          cngKit: cngKit,
                          basicODDis: basicODDis,
                          noClaim: noClaim,
                          totalA: totalA,
                          nilDep: nilDep,
                          nilDepAddon: nilDepAddon,
                          totalB: totalB,
                          liability: basicTP,
                          tppd: tppdRes,
                          paUnnamed: unNamedpa,
                          paOwner: paOwner,
                          llDriver: llDriver,
                          totalC: totalC,
                          totalABC: totalABC,
                          CGST: CGST,
                          SGST: SGST,
                          finalTotal: finalTotal,
                          specialODDis: specialODDis,
                          specialTPDis: specialTPDis,
                          specialNPDis: specialNPDis,
                          specialDisAmt: specialDisAmt,
                          specialDisPrice: specialDisPrice,
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
