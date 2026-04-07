import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/common/drap_down.dart';
import 'package:motorinsurancecalculator/common/text_field.dart';
import 'package:get/get.dart';
import 'package:motorinsurancecalculator/controller/heavy_vehicles_controller.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';

import '../../../common/color_constant.dart';
import 'ambulance_index_screen.dart';

class AmbulanceScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  AmbulanceScreen({super.key, this.title, this.bikeCC});

  @override
  State<AmbulanceScreen> createState() => _AmbulanceScreenState();
}

class _AmbulanceScreenState extends State<AmbulanceScreen> {

final HeavyVehiclesController two = Get.put(HeavyVehiclesController());
  @override
  void dispose() {
    Get.delete<HeavyVehiclesController>(); // clear controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  CTextField(
                    title: "IDV",
                    controller: two.idvController.value,
                    keyboard: TextInputType.number,
                    onchage: (value) {
                      if(two.depreciation != "0"){
                        setState(() {
                          double? cidv = double.parse(value) *
                              double.parse(two.depreciation.toString()) / 100;
                          double? finalcidv = double.parse(value) - cidv;
                          two.currentIDVController.value.text = cidv.toString();
                        });
                      } else {
                        two.currentIDVController.value.text = value;
                      }
                    },
                  ),
                  SizedBox(height: 5,),
                  CDropDown(
                    value: two.depreciation,
                    title: "Depreciation (%)",
                    items: two.depreciationList.map((String e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onchage: (value){
                      if(two.idvController.value.text.isNotEmpty) {
                        setState(() {
                          two.depreciation = value;
                          double? cidv = double.parse(two.idvController.value.text) *
                              double.parse(two.depreciation.toString()) / 100;
                          double? finalcidv = double.parse(two.idvController.value.text) - cidv;
                          two.currentIDVController.value.text = cidv.toString();
                          if(cidv == 0){
                            two.currentIDVController.value.text = two.idvController.value.text;
                          }
                        });
                      }
                    },),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Current IDV",
                    controller: two.currentIDVController.value,
                    keyboard: TextInputType.number,
                    readOnly: true,
                  ),
                  SizedBox(height: 5,),
                  CDropDown(
                    value: two.ageVehicle,
                    title: "Age of Vehicle",
                    items: two.ageVehicleList.map((String e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onchage: (value){
                      setState(() {
                        two.ageVehicle = value;
                      });
                    },
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Year of Manufacture",
                    controller: two.yearManuFactureController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CDropDown(
                    value: two.zone,
                    title: "Zone",
                    items: two.zoneList.map((String e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onchage: (value){
                      setState(() {
                        two.zone = value;
                      });
                    },),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Discount on OD Premium (%)",
                    controller: two.odPremiumController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Loading on Discount Premium (%)",
                    controller: two.loadingDisPreController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.cng,
                      title: "CNG/LPG Kits",
                      items: two.cngList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.cng = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "CNG/LPG Kit (Externally Fitted)",
                    controller: two.cngExtController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.imt23,
                      title: "IMT 23",
                      items: two.imt23List.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.imt23 = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.noClaimBonus,
                      title: "No Claim Bonus (%)",
                      items: two.noClaimBonusList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.noClaimBonus = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Value Added Service (Amount)",
                    controller: two.valAddServiceController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "PA to Owner Driver",
                    controller: two.paOwnerController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.llPayed,
                      title: "LL to Paid Driver",
                      items: two.llPayedList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.llPayed = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.llEmpPayed,
                      title: "LL to Employee other than Paid Driver",
                      items: two.llEmpPayedListh.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.llEmpPayed = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "LL to Passengers (Number of Passenger)",
                    controller: two.llPassengerController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.tppd,
                      title: "Restricted TP PD",
                      items: two.tppdList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.tppd = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Other Cess (%)",
                    controller: two.otherCessController.value,
                    keyboard: TextInputType.number,
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
                          two.emptyValueAssign();
                          var value = TwoWheelerPremiumModel(
                            idv: two.idvController.value.text,
                            depreciation: two.depreciation,
                            currentIDV: two.currentIDVController.value.text,
                            ageVehicle: two.ageVehicle,
                            yearOfManufacture: two.yearManuFactureController.value.text,
                            zone: two.zone,
                            odPremiumDis: two.odPremiumController.value.text,
                            noClaimBonus: two.noClaimBonus,
                            loadingDisPre: two.loadingDisPreController.value.text,
                            cngEx: two.cngExtController.value.text,
                            cngKits: two.cng,
                            valAddService: two.valAddServiceController.value.text,
                            imt23: two.imt23,
                            paOwnerDriver: two.paOwnerController.value.text,
                            llPaidDriver: two.llPayed,
                            llEmpPayed: two.llEmpPayed,
                            llPassenger: two.llPassengerController.value.text,
                            otherCess: two.otherCessController.value.text,
                            tppd: two.tppd,
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AmbulanceIndexScreen(data: value, title: widget.title, bikeCC: widget.bikeCC,)));
                        }, child: Text("Calculator", style: TextStyle(color: ColorConstant.whiteColor),)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
