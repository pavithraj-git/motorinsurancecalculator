import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';

class PrivateCarUnitedIndexScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  TwoWheelerPremiumModel? data;
  PrivateCarUnitedIndexScreen({super.key, this.title, this.bikeCC, this.data});

  @override
  State<PrivateCarUnitedIndexScreen> createState() => _PrivateCarUnitedIndexScreenState();
}

class _PrivateCarUnitedIndexScreenState extends State<PrivateCarUnitedIndexScreen> {
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
  double basicODPri = 0;
  double consumable = 0;
  double tyreCover = 0;
  double ncb = 0;
  double enginePro = 0;
  double returnInvoice = 0;
  double cngKit = 0;
  double addTowing = 0;
  double autoMobile = 0;
  double nilDep = 0;
  double personalEff = 0;
  double lossKey = 0;
  double petCare = 0;
  double courtesyCar = 0;
  double medialExp = 0;


  @override
  void initState() {
    initFun();
    super.initState();
  }

  initFun(){
    setState(() {
      liability = double.parse(widget.bikeCC.toString());
      if(widget.data?.tpTerm == "1"){
        liability = 2094.0;
      } else if(widget.data?.tpTerm == "3"){
        liability = 6521.0;
      }
      idv = double.parse(widget.data!.currentIDV.toString());
      if(widget.data?.zone == "A"){
        vehicleBasicRate = 3.283;
      } else if(widget.data?.zone == "B"){
        vehicleBasicRate = 3.191;
      }
      basicVehicle = vehicleBasicRate * double.parse(widget.data!.currentIDV.toString()) / 100;
      disOD = basicVehicle * double.parse(widget.data!.odPremiumDis.toString()) / 100;
      accessories = double.parse(widget.data!.accessoriesValue.toString()) * 4 / 100;
      nonAccessories = double.parse(widget.data!.nonElectAcce.toString()) * 3.2 / 100;
      if(widget.data?.cngKits == "Yes") {
        cngExt = double.parse(widget.data!.cngEx.toString()) * 4 / 100;
        cngKit = 60;
      }
      basicODPri = (vehicleBasicRate * double.parse(widget.data!.currentIDV.toString()) / 100) + accessories;
      if(widget.data?.fiberGlass == "Yes"){
        fiberGlass = 50;
      }
      if(widget.data?.autoMobile == "Yes"){
        autoMobile = idv * 55 / 100;
      }
      addTowing = idv * double.parse(widget.data!.addTowingCover.toString());
     if(widget.data?.antiTheft == "Yes"){
        antiTheft = (idv / 0.2) / 100;
      }
      if(widget.data?.nilDep == "Yes"){
        nilDep = idv * 0.56 / 100;
      }
      if(widget.data?.returnInvoice == "Yes"){
        returnInvoice = idv * 0.3 / 100;
      }
      if(widget.data!.consumables == "Yes"){
        consumable = idv * 0.1 / 100;
      }
      if(widget.data?.personalEff == "5000"){
        personalEff = 400;
      } else if(widget.data?.personalEff == "10000"){
        personalEff = 650;
      }
      if(widget.data?.lossKey == "10000"){
        lossKey = 300;
      } else if(widget.data?.lossKey == "25000"){
        lossKey = 750;
      }

      if(widget.data?.tyreCover == "25000"){
        tyreCover = 1000;
      } else if(widget.data?.tyreCover == "50000"){
        tyreCover = 2000;
      }else if(widget.data?.tyreCover == "100000"){
        tyreCover = 4000;
      }else if(widget.data?.tyreCover == "200000"){
        tyreCover = 8000;
      }
      if(widget.data?.petCareCov == "10000"){
        petCare = 100;
      } else if(widget.data?.petCareCov == "25000"){
        petCare = 250;
      } else if(widget.data?.petCareCov == "50000"){
        petCare = 500;
      }
      if(widget.data?.enginePro == "Standard"){
        enginePro = 0;
      } else if(widget.data?.enginePro == "Platinum"){
        enginePro = 0.01;
      }
      if(widget.data?.medialExp == "50000"){
        medialExp = 200;
      } else if(widget.data?.medialExp == "100000"){
        medialExp = 275;
      }
      if(widget.data?.courtesyCar == "3 Days"){
        courtesyCar = 200;
      } else if(widget.data?.courtesyCar == "5 Days"){
        courtesyCar = 300;
      } else if(widget.data?.courtesyCar == "7 Days"){
        courtesyCar = 375;
      }





      odBeforeDedu = (vehicleBasicRate * double.parse(widget.data!.currentIDV.toString()) / 100) + accessories + nonAccessories + disOD
      + cngExt + addTowing + fiberGlass + autoMobile +antiTheft + nilDep + returnInvoice + consumable + lossKey + tyreCover
      + petCare + personalEff  + enginePro + medialExp + courtesyCar;

      noClaim = odBeforeDedu * double.parse(widget.data!.noClaimBonus.toString()) / 100;
      netOwnDamage = odBeforeDedu - double.parse(widget.data!.noClaimBonus.toString());
      totalA = netOwnDamage;
      totalB = totalA;

      paUnnamed = double.parse(widget.data!.currentIDV.toString()) * double.parse(widget.data!.paUnnamedPassenger.toString()) / 100;

      totalC = paUnnamed + double.parse(liability.toString()) + double.parse(widget.data!.paOwnerDriver.toString())
          + double.parse(widget.data!.llPaidDriver.toString()) + cngKit;
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
                          rowColumn("Electrical/Electronic Accessories", widget.data?.electricalAcc),
                          rowColumn("Non Electrical Accessories", widget.data?.nonElectAcce),
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
                          rowColumn("Vehicle Basic Rate", vehicleBasicRate.toString()),
                          rowColumn("Basic OD Premium", basicVehicle.toStringAsFixed(2)),
                          rowColumn("Non Electrical Accessories", nonAccessories.toStringAsFixed(2)),
                          rowColumn("Discount on OD Premium", disOD.toStringAsFixed(2)),
                          rowColumn("Electrical/Electronic Accessories", accessories.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit (Externally Fitted)", cngExt.toStringAsFixed(2)),
                          rowColumn("Fiber Glass Tank", fiberGlass.toStringAsFixed(2)),
                          rowColumn("Automobile Membership", autoMobile.toStringAsFixed(2)),
                          rowColumn("Anti Theft", antiTheft.toStringAsFixed(2)),
                          rowColumn("Nil Depreciation", nilDep.toStringAsFixed(2)),
                          rowColumn("Return to Invoice", returnInvoice.toStringAsFixed(2)),
                          rowColumn("Consumables", consumable.toStringAsFixed(2)),
                          rowColumn("Lose of Key", lossKey.toStringAsFixed(2)),
                          rowColumn("Tyre and Rim Protector Cover", tyreCover.toStringAsFixed(2)),
                          rowColumn("Pet Care Cover", petCare.toStringAsFixed(2)),
                          rowColumn("Personal Effect", personalEff.toStringAsFixed(2)),
                          rowColumn("No Claim Bonus", noClaim.toStringAsFixed(2)),
                          rowColumn("Engin Protection", enginePro.toStringAsFixed(2)),
                          rowColumn("Medical Expenses", medialExp.toStringAsFixed(2)),
                          rowColumn("Courtesy Car", courtesyCar.toStringAsFixed(2)),
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
                          Text("C - Total Premium", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          SizedBox(height: 5,),
                          rowColumn("Total Package Premium [A + B]", totalABC.toStringAsFixed(2)),
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
