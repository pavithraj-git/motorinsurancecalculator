import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorinsurancecalculator/common/drap_down.dart';
import 'package:motorinsurancecalculator/common/text_field.dart';
import 'package:get/get.dart';
import 'package:motorinsurancecalculator/screen/calculator/heavy_vehicle/trailer_comprehensive_index_screen.dart';
import '../../../common/color_constant.dart';
import '../../../controller/trailer_comprehensive_controller.dart';
import '../../../model/two_wheeler_premium_model.dart';

class TrailerComprehensiveScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  TrailerComprehensiveScreen({super.key, this.title, this.bikeCC});

  @override
  State<TrailerComprehensiveScreen> createState() => _TrailerComprehensiveScreenState();
}

class _TrailerComprehensiveScreenState extends State<TrailerComprehensiveScreen> {
  final TrailerComprehensiveController two = Get.put(TrailerComprehensiveController());


  @override
  void dispose() {
    Get.delete<TrailerComprehensiveController>(); // clear controller
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
                  CDropDown(
                      value: two.vehiclePurpose,
                      title: "Vehicle Purpose",
                      items: two.vehiclePurposeList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.vehiclePurpose = value;
                        });
                      }),
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
                  CDropDown(
                      value: two.noTrailer,
                      title: "No of Trailer",
                      items: two.noTrailerList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.noTrailer = value;
                          two.trailer1Controller.value.text = "0";
                          two.trailer2Controller.value.text = "0";
                        });
                      }),
                  SizedBox(height: 5,),
                  if(two.noTrailer == "1" || two.noTrailer == "2")
                    CTextField(
                      title: "Trailer Value",
                      controller: two.trailer1Controller.value,
                      keyboard: TextInputType.number,
                    ),
                  if(two.noTrailer == "1" || two.noTrailer == "2")
                  SizedBox(height: 5,),
                  if(two.noTrailer == "2")
                    CTextField(
                      title: "Trailer Value",
                      controller: two.trailer2Controller.value,
                      keyboard: TextInputType.number,
                    ),
                  if(two.noTrailer == "2")
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
                  CTextField(
                    title: "OD Discount",
                    controller: two.odPremiumController.value,
                    keyboard: TextInputType.number,
                    onchage: (value) {
                        if (value.isEmpty) return;
                        double? number = double.tryParse(value);
                        if (number != null) {
                          if (number > 100) {
                            two.odPremiumController.value.text = "100";
                            two.odPremiumController.value.selection = TextSelection.fromPosition(
                              TextPosition(offset: two.odPremiumController.value.text.length),
                            );
                          } else if (number < 0) {
                            two.odPremiumController.value.text = "0";
                            two.odPremiumController.value.selection = TextSelection.fromPosition(
                              TextPosition(offset: two.odPremiumController.value.text.length),
                            );
                          }
                        }
                      }
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
                  CDropDown(
                      value: two.tppdRes,
                      title: "TPPD Restriction",
                      items: two.tppdResList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.tppdRes = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Special OD Discount",
                    controller: two.specialODDisController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Special TP Discount",
                    controller: two.specialTPDisController.value,
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
                          var value = TwoWheelerPremiumModel(
                            fuelType: two.fuelType,
                            zone: two.zone,
                            vehiclePurpose: two.vehiclePurpose,
                            regDate: two.regDateController.value.text,
                            noTrailer: two.noTrailer,
                            imt23: two.imt23,
                            noClaimBonus: two.noClaimBonus,
                            ODDis: two.odPremiumController.value.text,
                            claimPrePo: two.claimPrePo,
                            nameTra: two.nameTra,
                            specialNPDis: two.specialNPDisController.value.text,
                            tppd: two.tppdRes,
                            specialODDis: two.specialODDisController.value.text,
                            specialTPDis: two.specialTPDisController.value.text,
                            specialDis: two.specialDisAmtController.value.text,
                            trailer1: two.trailer1Controller.value.text,
                            trailer2: two.trailer2Controller.value.text
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TrailerComprehensiveIndexScreen(data: value, title: widget.title, bikeCC: widget.bikeCC,)));
                        }, child: Text("Calculator", style: TextStyle(color: ColorConstant.whiteColor),)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
