import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';
import '../../../controller/private_car_tp_controller.dart';
import '../../../model/calculation_model.dart';
import '../../../model/two_wheeler_premium_model.dart';

class PrivateCarTPIndexScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  TwoWheelerPremiumModel? data;
  PrivateCarTPIndexScreen({super.key, this.title, this.bikeCC, this.data});

  @override
  State<PrivateCarTPIndexScreen> createState() => _PrivateCarTPIndexScreenState();
}

class _PrivateCarTPIndexScreenState extends State<PrivateCarTPIndexScreen> {


  String? vehicleAge = "0 Day";
  double cngKit = 0.0;
  double basicTP = 0.0;
  double tppdRes = 0.0;
  double paOwner = 0.0;
  double llDriver = 0.0;
  double unNamedpa = 0.0;
  double totalA = 0.0;
  double CGST = 0.0;
  double SGST = 0.0;
  double finalTotal = 0.0;
  double specialNPDis = 0.0;
  double specialDisAmt = 0.0;
  double specialDisPrice = 0.0;

  PrivateCarTPController two = PrivateCarTPController();
  @override
  void initState() {
    initFun();
    super.initState();
  }

  initFun(){
    setState(() {
      vehicleAge = two.getRemaining(DateFormat("dd-MM-yyyy").parse(widget.data!.regDate!))!;
      if(widget.data?.cngKits == "Yes"){
        cngKit = 60;
      }

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
      totalA = basicTP + paOwner + llDriver + unNamedpa + cngKit - tppdRes;

      CGST = totalA * 9 / 100;
      SGST = totalA * 9 / 100;
      finalTotal = totalA + CGST + SGST;

      specialNPDis = totalA * double.parse(widget.data!.specialNPDis.toString()) / 100;
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
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text("A - Third Party Coverage", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Basic TP", basicTP.toStringAsFixed(2)),
                          rowColumn("TPPD Restriction", tppdRes.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit TP", cngKit.toStringAsFixed(2)),
                          rowColumn("PA Owner", paOwner.toStringAsFixed(2)),
                          rowColumn("LL Driver", llDriver.toStringAsFixed(2)),
                          rowColumn("Unnamed PA", unNamedpa.toStringAsFixed(2)),
                          rowColumn("Total TP Premium (A)", totalA.toStringAsFixed(2)),
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
                          rowColumn("Net Premium [A]", totalA.toStringAsFixed(2)),
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
                          CalculationModel clt =  CalculationModel(
                          vehicleAge: vehicleAge,
                          cngKit: cngKit,
                          liability: basicTP,
                          tppd: tppdRes,
                          paOwner: paOwner,
                          llDriver: llDriver,
                          paUnnamed: unNamedpa,
                          totalA: totalA,
                          CGST: CGST,
                          SGST: SGST,
                          finalTotal: finalTotal,
                          specialNPDis: specialNPDis,
                          specialDisAmt: specialDisAmt,
                          specialDisPrice: specialDisPrice
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
