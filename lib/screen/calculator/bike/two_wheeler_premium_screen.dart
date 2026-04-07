import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/common/drap_down.dart';
import 'package:motorinsurancecalculator/common/text_field.dart';
import 'package:motorinsurancecalculator/controller/two_wheeler_controller.dart';
import 'package:get/get.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/bike/two_wheeler_premium_index_screen.dart';

import '../../../common/color_constant.dart';

class TwoWheelerPremiumScreen extends StatefulWidget {
  String? title;
  TwoWheelerPremiumScreen({super.key, this.title});

  @override
  State<TwoWheelerPremiumScreen> createState() => _TwoWheelerPremiumScreenState();
}

class _TwoWheelerPremiumScreenState extends State<TwoWheelerPremiumScreen> {
  final TwoWheelerController two = Get.put(TwoWheelerController());

  @override
  void dispose() {
    Get.delete<TwoWheelerController>(); // clear controller
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
                                double.parse(two.depreciation.toString()) /
                                100;
                            if(widget.title == "Two Wheeler Premium") {
                              double? finalcidv = double.parse(value) - cidv;
                              two.currentIDVController.value.text =
                                  finalcidv.toString();
                            } else {
                              two.currentIDVController.value.text =
                                  cidv.toString();
                            }
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
                            if(widget.title == "Two Wheeler Premium") {
                              double? finalcidv = double.parse(
                                  two.idvController.value.text) - cidv;
                              two.currentIDVController.value.text =
                                  finalcidv.toString();
                            } else {
                              two.currentIDVController.value.text =
                                  cidv.toString();
                            }
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
                    title: "Cubic Capacity",
                    controller: two.cubicController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
            CTextField(
              title: "Discount on OD Premium (%)",
              controller: two.odPremiumController.value,
              keyboard: TextInputType.number,
            ),
            SizedBox(height: 5,),
            CTextField(
              title: "Accessories Value",
              controller: two.accessoriesController.value,
              keyboard: TextInputType.number,
            ),
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
                    title: "Zero Depreciation",
                    controller: two.zeroDepController.value,
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
                  CTextField(
                    title: "PA to Unnamed Passenger",
                    controller: two.paUnnameController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  // CDropDown(
                  //     value: two.tppd,
                  //     title: "Restricted TP PD",
                  //     items: two.tppdList.map((String e) {
                  //       return DropdownMenuItem<String>(
                  //         value: e,
                  //         child: Text(e),
                  //       );
                  //     }).toList(),
                  //     onchage: (value){
                  //       setState(() {
                  //         two.tppd = value;
                  //       });
                  //     }),
                  // SizedBox(height: 5,),
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
                            cubieCapacity: two.cubicController.value.text,
                            odPremiumDis: two.odPremiumController.value.text,
                            accessoriesValue: two.accessoriesController.value.text,
                            noClaimBonus: two.noClaimBonus,
                            zeroDepreciation: two.zeroDepController.value.text,
                            paOwnerDriver: two.paOwnerController.value.text,
                            llPaidDriver: two.llPayed,
                            paUnnamedPassenger: two.paUnnameController.value.text,
                            // tppd: two.tppd,
                            otherCess: two.otherCessController.value.text
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TwoWheelerPremiumIndexScreen(data: value, title: widget.title,)));
                        }, child: Text("Calculator", style: TextStyle(color: ColorConstant.whiteColor),)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
