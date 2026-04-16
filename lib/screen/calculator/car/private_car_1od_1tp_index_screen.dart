import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/vehicle_info_screen.dart';

import '../../../common/color_constant.dart';
import '../../../controller/private_car_1od_1tp_controller.dart';
import '../../../model/calculation_model.dart';

class PrivateCar1OD1TPIndexScreen extends StatefulWidget {
  String? title;
  TwoWheelerPremiumModel? data;
  PrivateCar1OD1TPIndexScreen({super.key, this.title, this.data});

  @override
  State<PrivateCar1OD1TPIndexScreen> createState() => _PrivateCar1OD1TPIndexScreenState();
}

class _PrivateCar1OD1TPIndexScreenState extends State<PrivateCar1OD1TPIndexScreen> {
  double idv = 0;
  double vehicleBasicRate = 0;
  double basicVehicle = 0;
  double disOD = 0;
  double odAfterDis = 0;
  double accessories = 0;
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
  double loadingOD = 0;
  double basODPrime = 0;
  double nonElecAcc = 0;
  double cngKit = 0;

  PrivateCar1OD1TPController two = PrivateCar1OD1TPController();

  @override
  void initState() {
    initFun();
    super.initState();
  }

  initFun(){
    setState(() {
      liability = two.carLiabilityTP(widget.data?.cubieCapacity);
      idv = double.parse(widget.data!.currentIDV.toString());
      vehicleBasicRate = two.carBasicRate(widget.data?.ageVehicle, widget.data?.zone, widget.data?.cubieCapacity);
      basicVehicle = vehicleBasicRate * double.parse(widget.data!.currentIDV.toString()) / 100;
      disOD = basicVehicle * double.parse(widget.data!.odPremiumDis.toString()) / 100;
      loadingOD = basicVehicle * double.parse(widget.data!.loadingDisPre.toString()) / 100;
      odAfterDis = basicVehicle + loadingOD - disOD;
      accessories = double.parse(widget.data!.electricalAcc.toString()) * 4 / 100;
      if(widget.data?.cngKits == "Yes") {
        cngExt = double.parse(widget.data!.cngEx.toString()) * 4 / 100;
        if(cngExt == 0){
          cngExt = odAfterDis * 5 / 100;
        }
        cngKit = 60;
      }
      nonElecAcc = vehicleBasicRate * double.parse(widget.data!.nonElectAcce.toString()) / 100;
      basODPrime = odAfterDis + accessories + cngExt + nonElecAcc;
      noClaim = basODPrime * double.parse(widget.data!.noClaimBonus.toString()) / 100;
      netOwnDamage = basODPrime - noClaim;
      totalA = netOwnDamage;
      zeroDep = idv * double.parse(widget.data!.zeroDepreciation.toString()) / 100;
      otherAddon = idv * double.parse(widget.data!.addonCharge.toString()) / 100;

      totalB = zeroDep +
          double.parse(widget.data!.rsa.toString())+
          double.parse(widget.data!.valAddService.toString()) + otherAddon;

      paUnnamed = double.parse(widget.data!.paUnnamedPassenger.toString());

      totalC = paUnnamed + cngKit + double.parse(liability.toString()) + double.parse(widget.data!.paOwnerDriver.toString())
          + double.parse(widget.data!.llPaidDriver.toString());
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
                          rowColumn("Vehicle Basic Rate", vehicleBasicRate.toString()),
                          rowColumn("Basic for Vehicle", basicVehicle.toStringAsFixed(2)),
                          rowColumn("Discount on OD Premium", disOD.toStringAsFixed(2)),
                          rowColumn("Loading on OD Premium", loadingOD.toStringAsFixed(2)),
                          rowColumn("Basic OD Premium after Discount/Loading", odAfterDis.toStringAsFixed(2)),
                          rowColumn("Electrical/Electronic Accessories", accessories.toStringAsFixed(2)),
                          rowColumn("Non Electrical Accessories", nonElecAcc.toStringAsFixed(2)),
                          rowColumn("CNG/LPG Kit (Externally Fitted)", cngExt.toStringAsFixed(2)),
                          rowColumn("Basic OD Premium", basODPrime.toStringAsFixed(2)),
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
                          rowColumn("CNG/LPG Kit", cngKit.toString()),
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
                          CalculationModel clt = CalculationModel(
                          liability: liability,
                          idv: idv,
                          vehicleBasicRate: vehicleBasicRate,
                          basicVehicle: basicVehicle,
                          disOD: disOD,
                          loadingOD: loadingOD,
                          odAfterDis: odAfterDis,
                          accessories: accessories,
                          cngExt: cngExt,
                          cngKit: cngKit,
                          nonElecAcc: nonElecAcc,
                          basODPrime: basODPrime,
                          noClaim: noClaim,
                          netOwnDamage: netOwnDamage,
                          totalA: totalA,
                          zeroDep: zeroDep,
                          otherAddon: otherAddon,
                          totalB: totalB,
                          paUnnamed: paUnnamed,
                          totalC: totalC,
                          totalABC: totalABC,
                          GST: GST,
                          cess: cess,
                          finalTotal: finalTotal,
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
