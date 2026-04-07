import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';

class PrivateCarOrientalIndexScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  TwoWheelerPremiumModel? data;
  PrivateCarOrientalIndexScreen({super.key, this.title, this.bikeCC, this.data});

  @override
  State<PrivateCarOrientalIndexScreen> createState() => _PrivateCarOrientalIndexScreenState();
}

class _PrivateCarOrientalIndexScreenState extends State<PrivateCarOrientalIndexScreen> {
  double idv = 0;
  double vehicleBasicRate = 0;
  double basicVehicle = 0;
  double odBeforeDisNCB = 0;
  double odAfterDisNCB = 0;
  double disODPre = 0;
  double odAfterDis = 0;
  double accessories = 0;
  double nonAccessories = 0;
  double basicODPre = 0;
  double personalEff = 0;
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
  double geoExt = 0;
  double enginePro = 0;
  double returnInvoice = 0;
  double cngKit = 0;
  double nilDep = 0;
  double tppd = 0;
  double keyRepCover = 0;
  double geoGrapExt = 0;
  double addTowing = 0;
  double disEnginPro = 0;
  double nilDis = 0;
  double addonCov= 0;

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
      if(widget.data?.zone == "A"){
        vehicleBasicRate = 3.283;
      } else if(widget.data?.zone == "B"){
        vehicleBasicRate = 3.191;
      }
      basicVehicle = vehicleBasicRate * idv / 100;
      accessories = double.parse(widget.data!.accessoriesValue.toString()) * 4 / 100;
      nonAccessories = double.parse(widget.data!.nonElectAcce.toString()) * 3.2 / 100;
      if(widget.data?.cngKits == "Yes") {
        if(widget.data?.cngEx == "0"){
          cngExt = 0.08;
        } else {
          cngExt = double.parse(widget.data!.cngEx.toString()) * 4 / 100;
        }
        cngKit = 60;
      }

      basicODPre = basicVehicle + accessories + nonAccessories + cngExt;
      disODPre = basicVehicle * double.parse(widget.data!.odPremiumDis.toString()) / 100;
      odAfterDis = basicVehicle + accessories + nonAccessories + cngExt;
      geoGrapExt = double.parse(widget.data!.geoGrap.toString());
      if(geoGrapExt == 400){
        geoExt = 100;
      }
      if(widget.data?.personalEff == "5000"){
        personalEff = 400;
      } else if(widget.data?.personalEff == "10000"){
        personalEff = 650;
      }
      if(widget.data?.returnInvoice == "Yes"){
        returnInvoice = idv * 0.3 / 100;
      }
      if(widget.data?.enginePro == "Yes"){
        enginePro = idv * 0.19 / 100;
        disEnginPro = enginePro * 15 / 100;
      }
      odBeforeDisNCB = basicVehicle + accessories + nonAccessories + cngExt + geoGrapExt + personalEff + returnInvoice + enginePro - disEnginPro;
      odAfterDisNCB = basicVehicle + accessories + nonAccessories + cngExt + geoGrapExt + personalEff + returnInvoice + enginePro - disEnginPro;

      if(widget.data?.nilDep == "Yes"){
        nilDep = idv * 0.56 / 100;
        nilDis = nilDep * 5 / 100;
      }
      if(widget.data!.consumables == "Yes"){
        consumable = idv * 0.1 / 100;
      }
      if(widget.data?.addTowingCover == "10000"){
        addTowing = 500;
      } else if(widget.data?.addTowingCover == "15000"){
        addTowing = 1125;
      } else if(widget.data?.addTowingCover == "20000"){
        addTowing = 1500;
      }
        addonCov = double.parse(widget.data!.addonCharge.toString());
      returnInvoice = double.parse(widget.data!.returnInvoice.toString()) * 0.2 / 100;
      if(widget.data?.keyRepCover == "Yes"){
        if(widget.data?.firstPurchase == "Up to 600000") {
          keyRepCover = 250;
        } else if(widget.data?.firstPurchase == "600001 - 1200000"){
          keyRepCover = 300;
        } else if(widget.data?.firstPurchase == "1200001 - 2500000"){
          keyRepCover = 400;
        } else if(widget.data?.firstPurchase == "Above 2500000"){
          keyRepCover = 500;
        }
      }
      noClaim = odAfterDis * double.parse(widget.data!.noClaimBonus.toString()) / 100;
      netOwnDamage = odAfterDis - noClaim;
      totalA = netOwnDamage;
      totalB = nilDep + netOwnDamage + consumable + keyRepCover + addTowing + addonCov;

      if(widget.data?.tppd == "Yes"){
        tppd = 100;
      }
      paUnnamed = double.parse(widget.data!.paUnnamedPassenger.toString());

      totalC = (paUnnamed + double.parse(liability.toString()) + double.parse(widget.data!.paOwnerDriver.toString())
          + double.parse(widget.data!.llPaidDriver.toString()) + cngKit) - tppd;
      totalABC = totalB + totalC;
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
                          rowColumn("Fuel", widget.data?.fuel),
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
                          rowColumn("Non Electrical Accessories", nonAccessories.toStringAsFixed(2)),
                          rowColumn("Electrical/Electronic Accessories", accessories.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit (Externally Fitted)", cngExt.toStringAsFixed(2)),
                          rowColumn("Basic OD Premium", basicODPre.toStringAsFixed(2)),
                          rowColumn("Discount on OD Premium", disODPre.toStringAsFixed(2)),
                          rowColumn("Basic OD after Discount", odAfterDis.toStringAsFixed(2)),
                          rowColumn("Geographical Ext", geoGrapExt.toStringAsFixed(2)),
                          rowColumn("Personal Effects", personalEff.toStringAsFixed(2)),
                          rowColumn("Return to Invoice", returnInvoice.toStringAsFixed(2)),
                          rowColumn("Engine Protection", enginePro.toStringAsFixed(2)),
                          rowColumn("Discount on Engine Protector", disEnginPro.toStringAsFixed(2)),
                          rowColumn("Loading on Engine Protector", "0"),
                          rowColumn("Basic OD Before NCB", odBeforeDisNCB.toStringAsFixed(2)),
                          rowColumn("No Claim Bonus", noClaim.toStringAsFixed(2)),
                          rowColumn("Basic OD After NCB", odAfterDisNCB.toStringAsFixed(2)),
                          rowColumn("Nil Depreciation", nilDep.toStringAsFixed(2)),
                          rowColumn("Discount on Nil Depreciation", nilDis.toStringAsFixed(2)),
                          rowColumn("Key Replacement", keyRepCover.toStringAsFixed(2)),
                          rowColumn("Consumables", consumable.toStringAsFixed(2)),
                          rowColumn("Additional Towing Charges", addTowing.toStringAsFixed(2)),
                          rowColumn("Other Addon Coverage", addonCov.toStringAsFixed(2)),
                          rowColumn("Net Own Damage Premium (A)", totalB.toStringAsFixed(2)),
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
                          rowColumn("Liability Premium (TP)", liability.toStringAsFixed(2)),
                          rowColumn("Geographical Ext", geoExt.toStringAsFixed(2)),
                          rowColumn("Restricted TP PD", tppd.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit", cngKit.toStringAsFixed(2)),
                          rowColumn("PA to Owner Drive", widget.data?.paOwnerDriver),
                          rowColumn("LL to Paid Driver", widget.data?.llPaidDriver),
                          rowColumn("PA to Unnamed Passenger", paUnnamed.toStringAsFixed(2)),
                          rowColumn("Total Liability Premium (B)", totalC.toStringAsFixed(2)),
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
                          rowColumn("Total Package Premium [A + B]", totalABC.toStringAsFixed(2)),
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
