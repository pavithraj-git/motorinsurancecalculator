import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorinsurancecalculator/common/drap_down.dart';
import 'package:motorinsurancecalculator/common/text_field.dart';
import 'package:get/get.dart';
import 'package:motorinsurancecalculator/model/two_wheeler_premium_model.dart';
import 'package:motorinsurancecalculator/screen/calculator/car/private_car_complete_1od_index_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/car/private_car_national_index_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/car/private_car_saod_index_screen.dart';

import '../../../common/color_constant.dart';
import '../../../controller/private_car_national_controller.dart';
import '../../../controller/private_car_saod_controller.dart';
import '../../../model/private_car_saod_model.dart';

class PrivateCarSAODScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  PrivateCarSAODScreen({super.key, this.title, this.bikeCC});

  @override
  State<PrivateCarSAODScreen> createState() => _PrivateCarSAODScreenState();
}

class _PrivateCarSAODScreenState extends State<PrivateCarSAODScreen> {
  final PrivateCarSAODController two = Get.put(PrivateCarSAODController());


  @override
  void dispose() {
    Get.delete<PrivateCarSAODController>(); // clear controller
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1926),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        two.regDateController.value.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
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
                    value: two.fuelType,
                    title: "Fuel Type",
                    items: two.fuelTypeList.map((String e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onchage: (value){
                      setState(() {
                        two.fuelType = value;
                      });
                    },),
                  SizedBox(height: 5,),
                  CDropDown(
                    value: two.cubicCapacitor,
                    title: "Cubic Capacitor",
                    items: two.cubicCapacitorList.map((String e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onchage: (value){
                      setState(() {
                        two.cubicCapacitor = value;
                      });
                    },),
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
                    title: "Registration Date",
                    controller: two.regDateController.value,
                    keyboard: TextInputType.number,
                    readOnly: true,
                    suffixicon: IconButton(
                      onPressed: _pickDate,
                      icon: Icon(Icons.calendar_today)),
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Vehicle Value",
                    controller: two.vehicleValueController.value,
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
                  if(two.cng == "EXTERNAL")
                  CTextField(
                    title: "CNG Kit Value",
                    controller: two.cngKitValueController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "OD Discount",
                    controller: two.odPremiumController.value,
                    keyboard: TextInputType.number,
                    validator: (value) {
                      final intValue = int.tryParse(value ?? "0");
                      if (intValue == null || intValue < 0 || intValue > 100) {
                        return 'Value must be between 0 and 100';
                      }
                      return null;
                    },
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
                      },
                    enable: two.noClaimBonusEnable,
                  ),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.claimPrePo,
                      title: "Claim in Previous Policy",
                      items: two.claimPrePoList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.claimPrePo = value;
                          if(two.claimPrePo == "Yes") {
                            two.noClaimBonus = "Nil";
                            two.noClaimBonusEnable = false;
                          } else {
                            two.noClaimBonusEnable = true;
                          }
                        });
                      }),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.nameTra,
                      title: "Name Transfer",
                      items: two.nameTraList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.nameTra = value;
                          if(two.nameTra == "Yes") {
                            two.noClaimBonus = "Nil";
                            two.noClaimBonusEnable = false;
                          } else {
                            two.noClaimBonusEnable = true;
                          }
                        });
                      }),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Nil Dep (Rating)",
                    controller: two.nilDepController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "ADD ON",
                    controller: two.addonController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Special NP Discount",
                    controller: two.specialNPDisController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Special Discount Amount",
                    controller: two.specialDisAmtController.value,
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
                          var value = PrivateCarSAODModel(
                            fuelType: two.fuelType,
                            cc: two.cubicCapacitor,
                            zone: two.zone,
                            regDate: two.regDateController.value.text,
                            vehicleValue: two.vehicleValueController.value.text,
                            eleAccess: two.accessoriesController.value.text,
                            nonEleAccess: two.nonElectAccController.value.text,
                            cngKit: two.cng,
                            cngKitValue: two.cngKitValueController.value.text,
                            noClaimBonus: two.noClaimBonus,
                            ODDis: two.odPremiumController.value.text,
                            claimPrePo: two.claimPrePo,
                            nameTra: two.nameTra,
                            nilDep: two.nilDepController.value.text,
                            addon: two.addonController.value.text,
                            specialNPDis: two.specialNPDisController.value.text,
                            specialDis: two.specialDisAmtController.value.text,
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateCarSAODIndexScreen(data: value, title: widget.title, bikeCC: widget.bikeCC,)));
                        }, child: Text("Calculator", style: TextStyle(color: ColorConstant.whiteColor),)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
