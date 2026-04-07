import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';
import '../../../controller/private_car_complete_controller.dart';

class PrivateCarNationalIndexScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  TwoWheelerPremiumModel? data;
  PrivateCarNationalIndexScreen({super.key, this.title, this.bikeCC, this.data});

  @override
  State<PrivateCarNationalIndexScreen> createState() => _PrivateCarNationalIndexScreenState();
}

class _PrivateCarNationalIndexScreenState extends State<PrivateCarNationalIndexScreen> {
  double idv = 0;
  double vehicleBasicRate = 0;
  double basicVehicle = 0;
  double disODPre = 0;
  double odAfterDis = 0;
  double accessories = 0;
  double nonAccessories = 0;
  double odBeforeNCB = 0;
  double netOwnDamage = 0;
  double noClaim = 0;
  double liability = 0;
  double totalA = 0;
  double totalB = 0;
  double paUnnamed = 0;
  double totalC = 0;
  double totalABC = 0;
  double GST12 = 0;
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
  double lockKey = 0;
  PrivateCarCompleteController two = PrivateCarCompleteController();

  @override
  void initState() {
    initFun();
    super.initState();
  }

  initFun(){
    setState(() {
      liability = two.carNationalCompleteLiabilityTP(widget.data?.tpTerm, widget.data?.cubieCapacity);
      idv = double.parse(widget.data!.currentIDV.toString());
      double tp = double.parse(widget.data?.tpTerm ?? "0");
      vehicleBasicRate = two.carBasicRate(widget.data?.ageVehicle, widget.data?.zone, widget.data?.cubieCapacity);
      basicVehicle = vehicleBasicRate * idv / 100;
      disODPre = basicVehicle * double.parse(widget.data!.odPremiumDis.toString()) / 100;
      odAfterDis = basicVehicle - disODPre;
      accessories = double.parse(widget.data!.electricalAcc.toString()) * 4 / 100;
      nonAccessories = vehicleBasicRate * double.parse(widget.data!.nonElectAcce.toString()) / 100;
      if(widget.data?.cngKits == "Yes") {
        cngExt = double.parse(widget.data!.cngEx.toString()) * 4 / 100;
        if(cngExt == 0){
          cngExt = basicVehicle * 5 / 100;
        }
        cngKit = 60 * tp;
      }
      odBeforeNCB = basicVehicle  - disODPre + accessories + nonAccessories + cngExt;
      noClaim = odBeforeNCB * double.parse(widget.data!.noClaimBonus.toString()) / 100;
      netOwnDamage = odBeforeNCB - noClaim;
      totalA = netOwnDamage;
      if (widget.data!.lockKeyPro == "Yes") {
        lockKey =
            2 * double.parse(widget.data!.lockKeyAmount.toString()) / 100;
      }
      if (widget.data!.ncb == "Yes") {
        ncb = idv * 0.23 / 100;
      }
      if("2019" == widget.data?.yearOfManufacture) {
        if (widget.data?.nilDep == "Nil Dep") {
          nilDep = odBeforeNCB * 33.5 / 100;
        } else if (widget.data?.nilDep == "Nil Dep Plus") {
          nilDep = totalA * 2.64 / 100;
        }
        if (widget.data!.consumables == "Yes") {
          consumable = idv * 0.42 / 100;
        }
        if (widget.data!.enginePro == "Yes") {
          enginePro = idv * 0.0020;
        }
        if (widget.data!.returnInvoice == "Yes") {
          returnInvoice = idv * 0.0067;
        }
      } else if("2020" == widget.data?.yearOfManufacture) {
        if (widget.data?.nilDep == "Nil Dep") {
          nilDep = totalA * 2.45 / 100;
        } else if (widget.data?.nilDep == "Nil Dep Plus") {
          nilDep = totalA * 2.64 / 100;
        }
        if (widget.data!.consumables == "Yes") {
          consumable = idv * 0.42 / 100;
        }
        if (widget.data!.enginePro == "Yes") {
          enginePro = idv * 0.0020;
        }
        if (widget.data!.returnInvoice == "Yes") {
          returnInvoice = idv * 0.0067;
        }
      } else if("2021" == widget.data?.yearOfManufacture) {
        if (widget.data?.nilDep == "Nil Dep") {
          nilDep = totalA * 2.45 / 100;
        } else if (widget.data?.nilDep == "Nil Dep Plus") {
          nilDep = totalA * 2.64 / 100;
        }
        if (widget.data!.consumables == "Yes") {
          consumable = idv * 0.42 / 100;
        }
        if (widget.data!.enginePro == "Yes") {
          enginePro = idv * 0.0020;
        }
        if (widget.data!.returnInvoice == "Yes") {
          returnInvoice = idv * 0.0067;
        }
      } else if("2022" == widget.data?.yearOfManufacture) {
        if (widget.data?.nilDep == "Nil Dep") {
          nilDep = totalA * 2.45 / 100;
        } else if (widget.data?.nilDep == "Nil Dep Plus") {
          nilDep = totalA * 2.64 / 100;
        }
        if (widget.data!.consumables == "Yes") {
          consumable = idv * 0.42 / 100;
        }
        if (widget.data!.enginePro == "Yes") {
          enginePro = idv * 0.0020;
        }
        if (widget.data!.returnInvoice == "Yes") {
          returnInvoice = idv * 0.0067;
        }
      } else if("2023" == widget.data?.yearOfManufacture) {
        if (widget.data?.nilDep == "Nil Dep") {
          nilDep = totalA * 2.45 / 100;
        } else if (widget.data?.nilDep == "Nil Dep Plus") {
          nilDep = totalA * 2.64 / 100;
        }
        if (widget.data!.consumables == "Yes") {
          consumable = idv * 0.42 / 100;
        }
        if (widget.data!.enginePro == "Yes") {
          enginePro = idv * 0.0020;
        }
        if (widget.data!.returnInvoice == "Yes") {
          returnInvoice = idv * 0.0067;
        }
      }

      totalB = nilDep + ncb + enginePro + returnInvoice + consumable + lockKey;

      if(widget.data?.tppd == "Yes"){
        tppd = 100 * tp;
      }
      paUnnamed = double.parse(widget.data!.paUnnamedPassenger.toString()) * tp;

      totalC = (paUnnamed + double.parse(liability.toString()) + double.parse(widget.data!.paOwnerDriver.toString())
          + double.parse(widget.data!.llPaidDriver.toString()) + cngKit) - tppd;
      totalABC = totalA + totalB + totalC;
      GST12 = double.parse(liability.toString()) * 12 / 100;
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
                          rowColumn("Vehicle Basic Rate", vehicleBasicRate.toString()),
                          rowColumn("Basic for Vehicle", basicVehicle.toStringAsFixed(2)),
                          rowColumn("Discount on OD Premium", disODPre.toStringAsFixed(2)),
                          rowColumn("Basic OD Premium after Discount/Loading", odAfterDis.toStringAsFixed(2)),
                          rowColumn("Electrical/Electronic Accessories", accessories.toStringAsFixed(2)),
                          rowColumn("Non Electrical Accessories", nonAccessories.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit (Externally Fitted)", cngExt.toStringAsFixed(2)),
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
                          rowColumn("Nil Depreciation", nilDep.toStringAsFixed(2)),
                          rowColumn("Consumables Protect", consumable.toStringAsFixed(2)),
                          rowColumn("Lock Key Protect", lockKey.toStringAsFixed(2)),
                          rowColumn("NCB Protections", ncb.toStringAsFixed(2)),
                          rowColumn("Engine Protection", enginePro.toStringAsFixed(2)),
                          rowColumn("Return to Invoice", returnInvoice.toStringAsFixed(2)),
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
                          rowColumn("GST (12%) on Basic TP Liability", GST12.toStringAsFixed(2)),
                          rowColumn("GST (18%) on Rest Others", GST.toStringAsFixed(2)),
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
