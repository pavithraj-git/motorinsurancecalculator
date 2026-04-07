import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';
import '../../../controller/trailer_comprehensive_controller.dart';
import '../../../model/trailer_model.dart';

class TrailerComprehensiveIndexScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  TrailerModel? data;
  TrailerComprehensiveIndexScreen({super.key, this.title, this.bikeCC, this.data});

  @override
  State<TrailerComprehensiveIndexScreen> createState() => _TrailerComprehensiveIndexScreenState();
}

class _TrailerComprehensiveIndexScreenState extends State<TrailerComprehensiveIndexScreen> {

  String? vehicleAge = "0 Day";
  double? trailerValue = 0.0;
  double? vehicleBasicRate = 0.0;
  double? basicVehicle = 0.0;
  double? trailerOD = 0.0;
  double? basicODDis = 0.0;
  double? imt25 = 0.0;
  double? noClaim = 0.0;
  double? totalA = 0.0;
  double totalB = 0.0;
  double basicTP = 0.0;
  double tppdRes = 0.0;
  double totalABC = 0.0;
  double GST5 = 0.0;
  double GST18 = 0.0;
  double CGST = 0.0;
  double SGST = 0.0;
  double finalTotal = 0.0;
  double specialODDis = 0.0;
  double specialTPDis = 0.0;
  double specialNPDis = 0.0;
  double specialDisAmt = 0.0;
  double specialDisPrice = 0.0;

  TrailerComprehensiveController two = TrailerComprehensiveController();
  @override
  void initState() {
    initFun();
    super.initState();
  }

  initFun(){
    setState(() {
      vehicleAge = two.getRemaining(DateFormat("dd-MM-yyyy").parse(widget.data!.regDate!))!;
      trailerValue = double.parse(widget.data!.trailer1.toString()) + double.parse(widget.data!.trailer2.toString());
      if(widget.data?.vehiclePurpose == "Agricultural"){
        vehicleBasicRate = 0.87;
        basicTP = 910 * double.parse(widget.data!.noTrailer.toString());
      } else if(widget.data?.vehiclePurpose == "Commercial"){
        vehicleBasicRate = 1.05;
        basicTP = 2485 * double.parse(widget.data!.noTrailer.toString());
      }
      trailerOD = trailerValue! * vehicleBasicRate! / 100;
      if(widget.data?.imt23 == "Yes"){
        imt25 = trailerOD! * 15 / 100;
      }
      basicODDis = ((trailerOD! + imt25!) * double.parse(widget.data!.ODDis.toString()) / 100);
      if(widget.data?.noClaimBonus == "0 to 20%") {
        noClaim = (trailerOD! - basicODDis! + imt25!) * 20 / 100;
      } else if(widget.data?.noClaimBonus == "20 to 25%") {
        noClaim = (trailerOD! - basicODDis! + imt25!) * 25 / 100;
      } else if(widget.data?.noClaimBonus == "25 to 35%") {
        noClaim = (trailerOD! - basicODDis! + imt25!) * 35 / 100;
      } else if(widget.data?.noClaimBonus == "35 to 45%") {
        noClaim = (trailerOD! - basicODDis! + imt25!) * 45 / 100;
      } else if(widget.data?.noClaimBonus == "45 to 50%") {
        noClaim = (trailerOD! - basicODDis! + imt25!) * 50 / 100;
      } else if(widget.data?.noClaimBonus == "50 to 50%") {
        noClaim = (trailerOD! - basicODDis! + imt25!) * 50 / 100;
      }
      totalA = trailerOD! + imt25! - basicODDis! - noClaim!;

      if(widget.data?.tppdRes == "Yes") {
        tppdRes = 200;
      }
      totalB = basicTP - tppdRes;

      totalABC = totalA! + totalB;
      if(widget.data?.vehiclePurpose == "Agricultural"){
        CGST = totalABC * 9 / 100;
        SGST = totalABC * 9 / 100;
        finalTotal = totalABC + CGST + SGST;
      } else {
        GST5 = totalABC * 5 / 100;
        GST18 = totalA! * 18 / 100;
        finalTotal = totalABC + GST5 + GST18;
      }

      specialODDis = totalA! * double.parse(widget.data!.specialODDis.toString()) / 100;
      specialTPDis = totalABC * double.parse(widget.data!.specialTPDis.toString()) / 100;
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
                          rowColumn("Vehicle Age", vehicleAge),
                          rowColumn("Zone Type", widget.data?.zone),
                          // rowColumn("Vehicle Value", vehicleValue.toString()),
                          rowColumn("Any Claim in Previous Policy", widget.data?.claimPrePo.toString()),
                          rowColumn("Name Transfer", widget.data?.nameTra.toString()),
                          rowColumn("No Of Trailer", widget.data?.noTrailer.toString()),
                          rowColumn("Trailer Value", trailerValue?.toStringAsFixed(2)),
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
                          rowColumn("Trailer OD", trailerOD?.toStringAsFixed(2)),
                          rowColumn("Basic OD Discount (${widget.data?.ODDis}%)", basicODDis?.toStringAsFixed(2)),
                          rowColumn("IMT 23", imt25?.toStringAsFixed(2)),
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
                          Text("B - Third Party Coverage", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Basic TP", basicTP.toStringAsFixed(2)),
                          rowColumn("TPPD Restriction", tppdRes.toStringAsFixed(2)),
                          rowColumn("Total TP Premium (B)", totalB.toStringAsFixed(2)),
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
                          rowColumn("Net Premium [A + B]", totalABC.toStringAsFixed(2)),
                          if(widget.data?.vehiclePurpose == "Commercial")
                          rowColumn("GST @ 5", GST5.toStringAsFixed(2)),
                          if(widget.data?.vehiclePurpose == "Commercial")
                          rowColumn("GST @ 18", GST18.toStringAsFixed(2)),
                          if(widget.data?.vehiclePurpose == "Agricultural")
                          rowColumn("CGST", CGST.toStringAsFixed(2)),
                          if(widget.data?.vehiclePurpose == "Agricultural")
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
