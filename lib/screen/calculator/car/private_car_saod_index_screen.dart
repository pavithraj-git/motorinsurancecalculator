import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorinsurancecalculator/controller/private_car_saod_controller.dart';
import 'package:motorinsurancecalculator/model/private_car_saod_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';

class PrivateCarSAODIndexScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  PrivateCarSAODModel? data;
  PrivateCarSAODIndexScreen({super.key, this.title, this.bikeCC, this.data});

  @override
  State<PrivateCarSAODIndexScreen> createState() => _PrivateCarSAODIndexScreenState();
}

class _PrivateCarSAODIndexScreenState extends State<PrivateCarSAODIndexScreen> {

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
  double totalAB = 0.0;
  double CGST = 0.0;
  double SGST = 0.0;
  double finalTotal = 0.0;
  double specialNPDis = 0.0;
  double specialDisAmt = 0.0;
  double specialDisPrice = 0.0;

  PrivateCarSAODController two = PrivateCarSAODController();
  @override
  void initState() {
    initFun();
    super.initState();
  }

  initFun(){
    setState(() {
      vehicleAge = two.getRemaining(DateFormat("dd-MM-yyyy").parse(widget.data!.regDate!))!;
      vehicleBasicRate = two.vehicleBasicRateSAOD(widget.data?.regDate, widget.data?.zone, widget.data?.cc);
      accessories = double.parse(widget.data!.eleAccess.toString()) * 4 / 100;
      nonAccessories = double.parse(widget.data!.nonEleAccess.toString()) * vehicleBasicRate! / 100;
      vehicleValue = (double.parse(widget.data!.vehicleValue.toString()) + double.parse(widget.data!.eleAccess.toString()) + double.parse(widget.data!.nonEleAccess.toString()));
      basicVehicle = (double.parse(widget.data!.vehicleValue.toString()) + double.parse(widget.data!.nonEleAccess.toString())) * vehicleBasicRate! / 100;
      if(widget.data?.cngKit == "INBUILT"){
        cngExt = basicVehicle! * 5 / 100;
      } else if(widget.data?.cngKit == "EXTERNAL"){
        cngExt = double.parse(widget.data!.cngKitValue.toString()) * 4 / 100;
      }
      basicODDis = ((basicVehicle! + cngExt!) * double.parse(widget.data!.ODDis.toString()) / 100);
      if(widget.data?.noClaimBonus == "0 to 20%") {
        noClaim = (basicVehicle! + cngExt! + accessories! + nonAccessories!) * 10 / 100;
      } else if(widget.data?.noClaimBonus == "20 to 25%") {
        noClaim = (basicVehicle! + cngExt! + accessories! + nonAccessories!) * 12.5 / 100;
      } else if(widget.data?.noClaimBonus == "25 to 35%") {
        noClaim = (basicVehicle! + cngExt! + accessories! + nonAccessories!) * 17.5 / 100;
      } else if(widget.data?.noClaimBonus == "35 to 45%") {
        noClaim = (basicVehicle! + cngExt! + accessories! + nonAccessories!) * 22.5 / 100;
      } else if(widget.data?.noClaimBonus == "45 to 50%") {
        noClaim = (basicVehicle! + cngExt! + accessories! + nonAccessories!) * 25 / 100;
      } else if(widget.data?.noClaimBonus == "50 to 50%") {
        noClaim = (basicVehicle! + cngExt! + accessories! + nonAccessories!) * 25 / 100;
      }
      totalA = basicVehicle! - basicODDis! + cngExt! + accessories! - noClaim!;

      nilDep = double.parse(widget.data!.nilDep.toString()) * vehicleValue! / 100;
      nilDepAddon = double.parse(widget.data!.addon.toString());
      totalB = nilDep! + nilDepAddon!;

      totalAB = totalA! + totalB;
      CGST = totalAB * 9 / 100;
      SGST = totalAB * 9 / 100;
      finalTotal = totalAB + CGST + SGST;

      specialNPDis = totalAB * double.parse(widget.data!.specialNPDis.toString()) / 100;
      specialDisAmt = double.parse(widget.data!.specialDis.toString());
      specialDisPrice = finalTotal - specialNPDis - specialDisAmt;

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
                          rowColumn("CNG/LPG Kit (${widget.data?.cngKit})", cngExt?.toStringAsFixed(2)),
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
                          rowColumn("Nil Dep Premium (B)", totalB?.toStringAsFixed(2)),
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
                          rowColumn("Net Premium [A + B]", totalAB.toStringAsFixed(2)),
                          rowColumn("CGST", CGST.toStringAsFixed(2)),
                          rowColumn("SGST", SGST.toStringAsFixed(2)),
                          rowColumn("Total Premium", finalTotal.round().toString()),
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
