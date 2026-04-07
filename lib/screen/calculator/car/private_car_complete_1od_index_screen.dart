import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';

class PrivateCarComplete1ODIndexScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  TwoWheelerPremiumModel? data;
  PrivateCarComplete1ODIndexScreen({super.key, this.title, this.bikeCC, this.data});

  @override
  State<PrivateCarComplete1ODIndexScreen> createState() => _PrivateCarComplete1ODIndexScreenState();
}

class _PrivateCarComplete1ODIndexScreenState extends State<PrivateCarComplete1ODIndexScreen> {
  double idv = 0;
  double vehicleBasicRate = 0;
  double basicVehicle = 0;
  double disOD = 0;
  double odAfterDis = 0;
  double accessories = 0;
  double nonAccessories = 0;
  double odBeforeDedu = 0;
  double odBeforeNCB = 0;
  double netOwnDamage = 0;
  double noClaim = 0;
  double zeroDep = 0;
  double otherAddon = 0;
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
  double fiberGlass = 0;
  double drivingTution = 0;
  double antiTheft = 0;
  double handiCap = 0;
  double aai = 0;
  double volDedu = 0;
  double loadingOD = 0;
  double basicODPri = 0;
  double consumable = 0;
  double tyreCover = 0;
  double ncb = 0;
  double enginePro = 0;
  double returnInvoice = 0;
  double cngKit = 0;

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
      basicVehicle = vehicleBasicRate * double.parse(widget.data!.currentIDV.toString()) / 100;
      disOD = basicVehicle * double.parse(widget.data!.odPremiumDis.toString()) / 100;
      loadingOD = basicVehicle * double.parse(widget.data!.loadingDisPre.toString()) / 100;
      odAfterDis = vehicleBasicRate * double.parse(widget.data!.currentIDV.toString()) / 100;
      accessories = double.parse(widget.data!.accessoriesValue.toString()) * 4 / 100;
      nonAccessories = double.parse(widget.data!.nonElectAcce.toString()) * 3 / 100;
      if(widget.data?.cngKits == "Yes") {
        cngExt = double.parse(widget.data!.cngEx.toString()) * 4 / 100;
        cngKit = 60;
      }
      basicODPri = (vehicleBasicRate * double.parse(widget.data!.currentIDV.toString()) / 100) + accessories;
      if(widget.data?.fiberGlass == "Yes"){
        fiberGlass = 50;
      }
      if(widget.data?.drivingTutions == "Yes"){
        drivingTution = basicODPri * 60 / 100;
      }
      odBeforeDedu = (vehicleBasicRate * double.parse(widget.data!.currentIDV.toString()) / 100) + accessories + fiberGlass + drivingTution;
      odBeforeNCB = (vehicleBasicRate * double.parse(widget.data!.currentIDV.toString()) / 100) + accessories + fiberGlass + drivingTution;

      if(widget.data?.antiTheft == "Yes"){
        antiTheft = (basicVehicle / 4) * 0.1;
      }
      if(widget.data?.handicap == "Yes"){
        handiCap = basicVehicle / 2;
      }
      if(widget.data?.aai == "Yes"){
        aai = basicVehicle * 5 / 100;
      }
      volDedu = basicVehicle * 5 / 100;
      noClaim = odBeforeDedu * double.parse(widget.data!.noClaimBonus.toString()) / 100;
      netOwnDamage = odBeforeNCB - double.parse(widget.data!.noClaimBonus.toString());
      totalA = netOwnDamage;
      zeroDep = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.zeroDepreciation.toString()) / 100;
      consumable = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.consumables.toString()) / 100;
      tyreCover = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.tyreCover.toString()) / 100;
      ncb = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.ncb.toString()) / 100;
      enginePro = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.enginePro.toString()) / 100;
      returnInvoice = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.returnInvoice.toString()) / 100;
      otherAddon = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.addonCharge.toString()) / 100;

      totalB = zeroDep +
          double.parse(widget.data!.rsa.toString())+ tyreCover + ncb + enginePro + returnInvoice +
          double.parse(widget.data!.valAddService.toString()) + otherAddon + consumable;

      paUnnamed = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.paUnnamedPassenger.toString()) / 100;

      totalC = paUnnamed + double.parse(liability.toString()) + double.parse(widget.data!.paOwnerDriver.toString())
          + double.parse(widget.data!.llPaidDriver.toString()) + cngKit;
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
                          rowColumn("Age of Vehicle", widget.data?.ageVehicle),
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
                          rowColumn("Discount on OD Premium", disOD.toStringAsFixed(2)),
                          rowColumn("Loading on OD Premium", loadingOD.toStringAsFixed(2)),
                          rowColumn("Basic OD Premium after Discount/Loading", odAfterDis.toStringAsFixed(2)),
                          rowColumn("Electrical/Electronic Accessories", accessories.toStringAsFixed(2)),
                          rowColumn("Non Electrical Accessories", nonAccessories.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit (Externally Fitted)", cngExt.toStringAsFixed(2)),
                          rowColumn("Basic OD Premium", basicODPri.toStringAsFixed(2)),
                          rowColumn("Fiber Glass Tank", fiberGlass.toStringAsFixed(2)),
                          rowColumn("Driving Tutions", drivingTution.toStringAsFixed(2)),
                          rowColumn("Basic OD Before Deductions", odBeforeDedu.toStringAsFixed(2)),
                          rowColumn("Anti Theft", antiTheft.toStringAsFixed(2)),
                          rowColumn("Handicap", handiCap.toStringAsFixed(2)),
                          rowColumn("AAI", aai.toStringAsFixed(2)),
                          rowColumn("Voluntary Deductible", volDedu.toStringAsFixed(2)),
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
                          rowColumn("Consumables", consumable.toStringAsFixed(2)),
                          rowColumn("Tyre Cover", tyreCover.toStringAsFixed(2)),
                          rowColumn("NCB Protections", ncb.toStringAsFixed(2)),
                          rowColumn("Engine Protection", enginePro.toStringAsFixed(2)),
                          rowColumn("Return to Invoice", returnInvoice.toStringAsFixed(2)),
                          rowColumn("Other Addon Coverage", otherAddon.toStringAsFixed(2)),
                          rowColumn("Value Added Service", widget.data?.valAddService),
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
