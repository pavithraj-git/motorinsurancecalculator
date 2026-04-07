import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorinsurancecalculator/common/drap_down.dart';
import 'package:motorinsurancecalculator/common/text_field.dart';
import 'package:get/get.dart';
import 'package:motorinsurancecalculator/screen/calculator/car/private_car_tp_index_screen.dart';
import '../../../common/color_constant.dart';
import '../../../controller/private_car_tp_controller.dart';
import '../../../model/private_car_saod_model.dart';

class PrivateCarTPScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  PrivateCarTPScreen({super.key, this.title, this.bikeCC});

  @override
  State<PrivateCarTPScreen> createState() => _PrivateCarTPScreenState();
}

class _PrivateCarTPScreenState extends State<PrivateCarTPScreen> {
  final PrivateCarTPController two = Get.put(PrivateCarTPController());


  @override
  void dispose() {
    Get.delete<PrivateCarTPController>(); // clear controller
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
                    title: "PA Owner",
                    controller: two.paOwnerController.value,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: 5,),
                  CDropDown(
                      value: two.legalLib,
                      title: "Legal Liability",
                      items: two.legalLibList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.legalLib = value;
                        });
                      }),
                  SizedBox(height: 5,),
                  CTextField(
                    title: "Unnamed PA",
                    controller: two.unnamedPAController.value,
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
                            cngKit: two.cng,
                            specialNPDis: two.specialNPDisController.value.text,
                            tppdRes: two.tppdRes,
                            paOwner: two.paOwnerController.value.text,
                            legalLib: two.legalLib,
                            unnamedPA: two.unnamedPAController.value.text,
                            specialDis: two.specialDisAmtController.value.text,
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateCarTPIndexScreen(data: value, title: widget.title, bikeCC: widget.bikeCC,)));
                        }, child: Text("Calculator", style: TextStyle(color: ColorConstant.whiteColor),)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
