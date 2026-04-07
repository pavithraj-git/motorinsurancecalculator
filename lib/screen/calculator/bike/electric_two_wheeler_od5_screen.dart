import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/common/drap_down.dart';
import 'package:motorinsurancecalculator/common/text_field.dart';
import 'package:get/get.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';

import '../../../common/color_constant.dart';
import '../../../controller/electric_two_wheeler_od5_controller.dart';
import 'electric_two_wheeler_od5_index_screen.dart';

class ElectricTwoWheelerOD5Screen extends StatefulWidget {
  String? title;
  String? bikeCC;
  ElectricTwoWheelerOD5Screen({super.key, this.title, this.bikeCC});

  @override
  State<ElectricTwoWheelerOD5Screen> createState() => _ElectricTwoWheelerOD5ScreenState();
}

class _ElectricTwoWheelerOD5ScreenState extends State<ElectricTwoWheelerOD5Screen> {
  final ElectricTwoWheelerOD5Controller two = Get.put(ElectricTwoWheelerOD5Controller());


  @override
  void dispose() {
    Get.delete<ElectricTwoWheelerOD5Controller>(); // clear controller
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
                  CDropDown(
                    value: two.odTerm,
                    title: "OD Term (in year)",
                    items: two.odTermList.map((String e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onchage: (value){
                      setState(() {
                        two.odTerm = value;
                      });
                    },),
                  SizedBox(height: 5,),
                  CDropDown(
                    value: two.tpTerm,
                    title: "TP Term (in year)",
                    items: two.tpTermList.map((String e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onchage: (value){
                      setState(() {
                        two.tpTerm = value;
                      });
                    },),
                  SizedBox(height: 5,),
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
                          two.currentIDVController.value.text = finalcidv.toString();
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
                          two.currentIDVController.value.text = finalcidv.toString();
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
                    title: "Kilowatt",
                    controller: two.kilowattController.value,
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
                    title: "Loading on Discount Premium (%)",
                    controller: two.loadingDisPreController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Electrical Accessories",
                    controller: two.accessoriesController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.sideCar,
                      title: "Side Car",
                      items: two.sideCarList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.sideCar = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.antiTheft,
                      title: "Anti Theft",
                      items: two.antiTheftList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.antiTheft = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.handiCap,
                      title: "Handicap",
                      items: two.handiCapList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.handiCap = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.aai,
                      title: "AAI",
                      items: two.aaiList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.aai = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.volDeduct,
                      title: "Voluntary Deductible",
                      items: two.volDeductList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.volDeduct = value;
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
                    title: "Zero Depreciation (Rate)",
                    controller: two.zeroDepController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "RSA/Additional for Address (Amount)",
                    controller: two.rsaController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Other Addons Charges (Rate)",
                    controller: two.addonChargeController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Value Added Service (Rate",
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
                  CTextField(
                    title: "PA to Unnamed Passenger",
                    controller: two.paUnnameController.value,
                    keyboard: TextInputType.number,
                  ),
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
                          var value = TwoWheelerPremiumModel(
                              idv: two.idvController.value.text,
                              depreciation: two.depreciation,
                              currentIDV: two.currentIDVController.value.text,
                              ageVehicle: two.ageVehicle,
                              yearOfManufacture: two.yearManuFactureController.value.text,
                              zone: two.zone,
                              odPremiumDis: two.odPremiumController.value.text,
                              accessoriesValue: two.accessoriesController.value.text,
                              noClaimBonus: two.noClaimBonus,
                              zeroDepreciation: two.zeroDepController.value.text,
                              paOwnerDriver: two.paOwnerController.value.text,
                              llPaidDriver: two.llPayed,
                              paUnnamedPassenger: two.paUnnameController.value.text,
                              otherCess: two.otherCessController.value.text,
                              kilowatt: two.kilowattController.value.text,

                            odTerm: two.odTerm,
                            tpTerm: two.tpTerm,
                            loadingDisPre: two.loadingDisPreController.value.text,
                            electricalAcc: two.accessoriesController.value.text,
                            sideCar: two.sideCar,
                            antiTheft: two.antiTheft,
                            handicap: two.handiCap,
                            aai: two.aai,
                            volDeduct: two.volDeduct,
                            rsa: two.rsaController.value.text,
                            addonCharge: two.addonChargeController.value.text,
                            valAddService: two.valAddServiceController.value.text,
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ElectricTwoWheelerod5IndexScreen(data: value, title: widget.title, bikeCC: widget.bikeCC,)));
                        }, child: Text("Calculator", style: TextStyle(color: ColorConstant.whiteColor),)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
