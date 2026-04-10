import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';
import '../../../controller/trailer_comprehensive_controller.dart';
import '../../../model/trailer_model.dart';

class TrailerTPIndexScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  TrailerModel? data;
  TrailerTPIndexScreen({super.key, this.title, this.bikeCC, this.data});

  @override
  State<TrailerTPIndexScreen> createState() => _TrailerTPIndexScreenState();
}

class _TrailerTPIndexScreenState extends State<TrailerTPIndexScreen> {

  String? vehicleAge = "0 Day";
  double totalB = 0.0;
  double basicTP = 0.0;
  double tppdRes = 0.0;
  double totalABC = 0.0;
  double GST5 = 0.0;
  double GST18 = 0.0;
  double CGST = 0.0;
  double SGST = 0.0;
  double finalTotal = 0.0;
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
      if(widget.data?.vehiclePurpose == "Agricultural"){
        basicTP = 910 * double.parse(widget.data!.noTrailer.toString());
      } else if(widget.data?.vehiclePurpose == "Commercial"){
        basicTP = 2485 * double.parse(widget.data!.noTrailer.toString());
      }
      if(widget.data?.tppdRes == "Yes") {
        tppdRes = 200;
      }
      totalB = basicTP - tppdRes;

      totalABC = totalB;
      if(widget.data?.vehiclePurpose == "Agricultural"){
        CGST = totalABC * 9 / 100;
        SGST = totalABC * 9 / 100;
        finalTotal = totalABC + CGST + SGST;
      } else {
        GST5 = totalABC * 5 / 100;
        GST18 = 0 * 18 / 100;
        finalTotal = totalABC + GST5 + GST18;
      }


      specialNPDis = totalABC * double.parse(widget.data!.specialNPDis.toString()) / 100;
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
                          rowColumn("Vehicle Age", vehicleAge),
                          rowColumn("Zone Type", widget.data?.zone),
                          // rowColumn("Vehicle Value", vehicleValue.toString()),
                          rowColumn("No Of Trailer", widget.data?.noTrailer.toString()),
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
                          rowColumn("Total TP Premium (A)", totalB.toStringAsFixed(2)),
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
                          rowColumn("Net Premium [A]", totalABC.toStringAsFixed(2)),
                          if(widget.data?.vehiclePurpose == "Commercial")
                            rowColumn("GST @ 5", GST5.toStringAsFixed(2)),
                          if(widget.data?.vehiclePurpose == "Commercial")
                            rowColumn("GST @ 18", GST18.toStringAsFixed(2)),
                          if(widget.data?.vehiclePurpose == "Agricultural")
                            rowColumn("CGST", CGST.toStringAsFixed(2)),
                          if(widget.data?.vehiclePurpose == "Agricultural")
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
