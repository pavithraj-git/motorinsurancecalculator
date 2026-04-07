import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';

class PrivateCarNewIndiaIndexScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  TwoWheelerPremiumModel? data;
  PrivateCarNewIndiaIndexScreen({super.key, this.title, this.bikeCC, this.data});

  @override
  State<PrivateCarNewIndiaIndexScreen> createState() => _PrivateCarNewIndiaIndexScreenState();
}

class _PrivateCarNewIndiaIndexScreenState extends State<PrivateCarNewIndiaIndexScreen> {
  double idv = 0;
  double vehicleBasicRate = 0;
  double basicVehicle = 0;
  double odBeforeDis = 0;
  double disODPre = 0;
  double odAfterDis = 0;
  double accessories = 0;
  double nonAccessories = 0;
  double netOwnDamage = 0;
  double noClaim = 0;
  double liability = 0;
  double totalA = 0;
  double totalB = 0;
  double paUnnamed = 0;
  double totalC = 0;
  double totalABC = 0;
  double GST = 0;
  double cess = 0;
  double finalTotal = 0;
  double cngExt = 0;
  double consumable = 0;
  double ncb = 0;
  double enginePro = 0;
  double returnInvoice = 0;
  double cngKit = 0;
  double nilDep = 0;
  double tppd = 0;
  double keyRepCover = 0;
  double roadTax = 0;
  double addTowing = 0;
  double loseContent = 0;

  @override
  void initState() {
    initFun();
    super.initState();
  }

  initFun(){
    setState(() {
      liability = double.parse(widget.bikeCC.toString());
      if(widget.data?.tpTerm == "3"){
        liability = 6521;
      }
      idv = double.parse(widget.data!.currentIDV.toString());
      if(widget.data?.ageVehicle == "Upto 5 Year" && widget.data?.zone == "A"){
        vehicleBasicRate = 3.127;
      } else if(widget.data?.ageVehicle == "Upto 5 Year" && widget.data?.zone == "B"){
        vehicleBasicRate = 3.039;
      } else if(widget.data?.ageVehicle == "6 to 10 Year" && widget.data?.zone == "A"){
        vehicleBasicRate = 3.283;
      } else if(widget.data?.ageVehicle == "6 to 10 Year" && widget.data?.zone == "B"){
        vehicleBasicRate = 3.191;
      } else if(widget.data?.ageVehicle == "Above 10 Year" && widget.data?.zone == "A"){
        vehicleBasicRate = 3.362;
      } else{
        vehicleBasicRate = 3.267;
      }
      basicVehicle = vehicleBasicRate * idv / 100;
      accessories = double.parse(widget.data!.accessoriesValue.toString()) * 4 / 100;
      nonAccessories = double.parse(widget.data!.nonElectAcce.toString()) * 3 / 100;
      if(widget.data?.cngKits == "Yes") {
        cngExt = double.parse(widget.data!.cngEx.toString()) * odAfterDis / 100;
        cngKit = 60;
      }
      odBeforeDis = basicVehicle;
      disODPre = basicVehicle * double.parse(widget.data!.odPremiumDis.toString()) / 100;
      odAfterDis = basicVehicle  - disODPre + accessories + nonAccessories + cngExt;
      noClaim = odAfterDis * double.parse(widget.data!.noClaimBonus.toString()) / 100;
      netOwnDamage = odAfterDis - noClaim;
      totalA = netOwnDamage;
      if(widget.data?.nilDep == "Yes"){
        nilDep = idv * 0.15;
      }
      if(widget.data!.consumables == "Yes"){
        consumable = idv * 0.005;
      }
      if(widget.data!.ncb == "Yes") {
        ncb = idv * 8.5 / 100;
      }
      if(widget.data!.enginePro == "With Zero Dep Benefit on Parts") {
        enginePro = idv * 0.003;
      } else if(widget.data!.enginePro == "Without Zero Dep Benefit on Parts"){
        enginePro = idv * 0.003;
      }
      returnInvoice = double.parse(widget.data!.returnInvoice.toString()) * 0.02;
      if(widget.data?.keyRepCover == "Yes"){
        keyRepCover = 250;
      }
      roadTax = double.parse(widget.data!.roadTax.toString()) * 1.6 / 100;
      addTowing = double.parse(widget.data!.addTowingCover.toString()) * 5 / 100;
      loseContent = double.parse(widget.data!.lossContent.toString()) * 0.9 / 100;
      totalB = nilDep + ncb + enginePro + returnInvoice + consumable + roadTax + keyRepCover + addTowing + loseContent;

      if(widget.data?.tppd == "Yes"){
        tppd = 100;
      }
      paUnnamed = double.parse(widget.data!.paUnnamedPassenger.toString());

      totalC = (paUnnamed + double.parse(liability.toString()) + double.parse(widget.data!.paOwnerDriver.toString())
          + double.parse(widget.data!.llPaidDriver.toString()) + cngKit) - tppd;
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
                          rowColumn("OD Term (in year)", widget.data?.odTerm.toString()),
                          rowColumn("TP Term (in year)", widget.data?.tpTerm),
                          rowColumn("Age of Vehicle", widget.data?.vehicleAge),
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
                          Text("A - Own Damage Premium", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Vehicle Basic Rate", vehicleBasicRate.toStringAsFixed(2)),
                          rowColumn("Basic for Vehicle", basicVehicle.toStringAsFixed(2)),
                          rowColumn("Electrical/Electronic Accessories", accessories.toStringAsFixed(2)),
                          rowColumn("Non Electrical Accessories", nonAccessories.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit (Externally Fitted)", cngExt.toStringAsFixed(2)),
                          rowColumn("Basic OD Before Discount", odBeforeDis.toStringAsFixed(2)),
                          rowColumn("Discount on OD Premium", disODPre.toStringAsFixed(2)),
                          rowColumn("Basic OD after Discount", odAfterDis.toStringAsFixed(2)),
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
                          rowColumn("Nil Depreciation", nilDep.toStringAsFixed(2)),
                          rowColumn("Consumables Protect", consumable.toStringAsFixed(2)),
                          rowColumn("NCB Protections", ncb.toStringAsFixed(2)),
                          rowColumn("Engine Protection", enginePro.toStringAsFixed(2)),
                          rowColumn("Return to Invoice", returnInvoice.toStringAsFixed(2)),
                          rowColumn("Road Tax Cover", roadTax.toStringAsFixed(2)),
                          rowColumn("Additional Towing Charge", addTowing.toStringAsFixed(2)),
                          rowColumn("Loss of Content", loseContent.toStringAsFixed(2)),
                          rowColumn("Key Replacement Cover", keyRepCover.toStringAsFixed(2)),
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
                          rowColumn("Restricted TP PD", tppd.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit", cngKit.toStringAsFixed(2)),
                          rowColumn("PA to Owner Drive", widget.data?.paOwnerDriver),
                          rowColumn("LL to Paid Driver", widget.data?.llPaidDriver),
                          rowColumn("PA to Unnamed Passenger", paUnnamed.toStringAsFixed(2)),
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
