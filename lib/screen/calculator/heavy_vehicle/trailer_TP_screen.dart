import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorinsurancecalculator/common/drap_down.dart';
import 'package:motorinsurancecalculator/common/text_field.dart';
import 'package:get/get.dart';
import 'package:motorinsurancecalculator/screen/calculator/heavy_vehicle/trailer_TP_Index_screen.dart';
import '../../../common/color_constant.dart';
import '../../../controller/trailer_tp_controller.dart';
import '../../../model/trailer_model.dart';

class TrailerTPScreen extends StatefulWidget {
  String? title;
  String? bikeCC;
  TrailerTPScreen({super.key, this.title, this.bikeCC});

  @override
  State<TrailerTPScreen> createState() => _TrailerTPScreenState();
}

class _TrailerTPScreenState extends State<TrailerTPScreen> {
  final TrailerTPController two = Get.put(TrailerTPController());


  @override
  void dispose() {
    Get.delete<TrailerTPController>(); // clear controller
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
                          var value = TrailerModel(
                              fuelType: two.fuelType,
                              zone: two.zone,
                              vehiclePurpose: two.vehiclePurpose,
                              regDate: two.regDateController.value.text,
                              noTrailer: two.noTrailer,
                              specialNPDis: two.specialNPDisController.value.text,
                              tppdRes: two.tppdRes,
                              specialDis: two.specialDisAmtController.value.text,
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TrailerTPIndexScreen(data: value, title: widget.title, bikeCC: widget.bikeCC,)));
                        }, child: Text("Calculator", style: TextStyle(color: ColorConstant.whiteColor),)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
