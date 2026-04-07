import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/common/drap_down.dart';
import 'package:motorinsurancecalculator/common/text_field.dart';
import 'package:get/get.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/car/private_car_oriental_index_screen.dart';

import '../../../common/color_constant.dart';
import '../../../controller/private_car_oriental_controller.dart';

class PrivateCarOrientalScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  PrivateCarOrientalScreen({super.key, this.title, this.bikeCC});

  @override
  State<PrivateCarOrientalScreen> createState() => _PrivateCarOrientalScreenState();
}

class _PrivateCarOrientalScreenState extends State<PrivateCarOrientalScreen> {
  final PrivateCarOrientalController two = Get.put(PrivateCarOrientalController());


  @override
  void dispose() {
    Get.delete<PrivateCarOrientalController>(); // clear controller
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
                      value: two.geoGrap,
                      title: "Geographical Extn",
                      items: two.geoGrapList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.geoGrap = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.personalEffect,
                      title: "Personal Effects",
                      items: two.personalEffectList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.personalEffect = value;
                        });
                      }),
                  SizedBox(height: 5,),

                  CDropDown(
                      value: two.returnInvoice,
                      title: "Return to Invoice (Rate)",
                      items: two.returnInvoiceList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.returnInvoice = value;
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
                  CTextField(
                    title: "Discount on Nil Depreciation (%)",
                    controller: two.disNilDepontroller.value,
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
                  if(two.keyRepCover == "Yes")
                  CDropDown(
                      value: two.firstPurchase,
                      title: "Original Price at time of first purchase in indian Rupees",
                      items: two.firstPurchaseList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.firstPurchase = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.consumablePro,
                      title: "Consumable (Rate)",
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
                      value: two.addTowing,
                      title: "Additional Towing Changes (Rate)",
                      items: two.addTowingList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.addTowing = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Other Addons Charges (Rate)",
                    controller: two.otherAddonController.value,
                    keyboard: TextInputType.number,
                  ),
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
                          var value = TwoWheelerPremiumModel(
                              idv: two.idvController.value.text,
                              depreciation: two.depreciation,
                              currentIDV: two.currentIDVController.value.text,
                              ageVehicle: two.ageVehicle,
                              yearOfManufacture: two.yearManuFactureController.value.text,
                              zone: two.zone,
                              cubieCapacity: two.cubicController.value.text,
                              fuel: two.fuel,
                              odPremiumDis: two.odPremiumController.value.text,
                              geoGrap: two.geoGrap,
                              personalEff: two.personalEffect,
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
                              disNilDep: two.disNilDepontroller.value.text,
                              addonCharge: two.otherAddonController.value.text,
                              consumables: two.consumablePro,
                              enginePro: two.enginePro,
                              returnInvoice: two.returnInvoice,
                              paOwnerDriver: two.paOwner,
                              tppd: two.tppd,
                              addTowingCover: two.addTowing,
                              keyRepCover: two.keyRepCover,
                              firstPurchase: two.firstPurchase
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateCarOrientalIndexScreen(data: value, title: widget.title, bikeCC: widget.bikeCC,)));
                        }, child: Text("Calculator", style: TextStyle(color: ColorConstant.whiteColor),)),
                  )
                ],
              ),
            ),
          ),
        ));

  }
}
