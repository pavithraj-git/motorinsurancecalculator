import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/common/drap_down.dart';
import 'package:motorinsurancecalculator/common/text_field.dart';
import 'package:get/get.dart';
import 'package:motorinsurancecalculator/controller/private_car_new_india_controller.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/car/private_car_new_india_index_screen.dart';

import '../../../common/color_constant.dart';

class PrivateCarNewIndiaScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  PrivateCarNewIndiaScreen({super.key, this.title, this.bikeCC});

  @override
  State<PrivateCarNewIndiaScreen> createState() => _PrivateCarNewIndiaScreenState();
}

class _PrivateCarNewIndiaScreenState extends State<PrivateCarNewIndiaScreen> {
  final PrivateCarNewIndiaController two = Get.put(PrivateCarNewIndiaController());


  @override
  void dispose() {
    Get.delete<PrivateCarNewIndiaController>(); // clear controller
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
                    value: two.vehicleAge,
                    title: "Vehicle Age",
                    items: two.vehicleAgeList.map((String e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onchage: (value){
                      setState(() {
                        two.vehicleAge = value;
                      });
                    },
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
                    title: "Electrical Accessories",
                    controller: two.accessoriesController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Non Electrical Accessories",
                    controller: two.nonElectAccController.value,
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
                  CDropDown(
                      value: two.nilDep,
                      title: "Nil Depreciation",
                      items: two.nilDepList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.nilDep = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.consumablePro,
                      title: "Consumable Protect",
                      items: two.consumableProList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.consumablePro = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.ncb,
                      title: "NCB Protection (Rate)",
                      items: two.ncbList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.ncb = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.enginePro,
                      title: "Engine Protector (Rate)",
                      items: two.engineProProList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.enginePro = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Return to Invoice (Rate)",
                    controller: two.returnInvoiceController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Road Tax Cover",
                    controller: two.roadTaxCoverController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Additional Towing Charges",
                    controller: two.addTowingController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Lose of Content",
                    controller: two.lossContentController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.keyRepCover,
                      title: "Key Replacement Cover",
                      items: two.keyRepCoverList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.keyRepCover = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.paOwner,
                      title: "PA to Owner Driver",
                      items: two.paOwnerList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.paOwner = value;
                        });
                      }),
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
                              vehicleAge: two.vehicleAge,
                              zone: two.zone,
                              cubieCapacity: two.cubicController.value.text,
                              odPremiumDis: two.odPremiumController.value.text,
                              accessoriesValue: two.accessoriesController.value.text,
                              noClaimBonus: two.noClaimBonus,
                              llPaidDriver: two.llPayed,
                              paUnnamedPassenger: two.paUnnameController.value.text,
                              otherCess: two.otherCessController.value.text,
                              odTerm: two.odTerm,
                              tpTerm: two.tpTerm,
                              electricalAcc: two.accessoriesController.value.text,
                              nonElectAcce: two.nonElectAccController.value.text,
                              cngKits: two.cng,
                              cngEx: two.cngExtController.value.text,
                              nilDep: two.nilDep,
                              consumables: two.consumablePro,
                              ncb: two.ncb,
                              enginePro: two.enginePro,
                              returnInvoice: two.returnInvoiceController.value.text,
                              paOwnerDriver: two.paOwner,
                              tppd: two.tppd,
                            roadTax: two.roadTaxCoverController.value.text,
                            addTowingCover: two.addTowingController.value.text,
                            lossContent: two.lossContentController.value.text,
                            keyRepCover: two.keyRepCover
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateCarNewIndiaIndexScreen(data: value, title: widget.title, bikeCC: widget.bikeCC,)));
                        }, child: Text("Calculator", style: TextStyle(color: ColorConstant.whiteColor),)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
