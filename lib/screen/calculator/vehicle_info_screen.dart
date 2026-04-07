import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorinsurancecalculator/common/text_field.dart';
import 'package:get/get.dart';
import '../../common/color_constant.dart';
import '../../common/share_file.dart';
import '../../controller/two_wheeler_controller.dart';

class VehicleInfoScreen extends StatefulWidget {
  const VehicleInfoScreen({super.key});

  @override
  State<VehicleInfoScreen> createState() => _VehicleInfoScreenState();
}

class _VehicleInfoScreenState extends State<VehicleInfoScreen> {
  final TwoWheelerController two = Get.put(TwoWheelerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Vehicle Information", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    CTextField(
                      title: "Full Name",
                      controller: two.fullNameController.value,
                      keyboard: TextInputType.text,
                        inputFormatter: []
                    ),
                    SizedBox(height: 5,),
                    CTextField(
                      title: "Vehicle Make",
                      controller: two.vehicleMakeController.value,
                      keyboard: TextInputType.text,
                      inputFormatter: []
                    ),
                    SizedBox(height: 5,),

                    CTextField(
                      title: "Vehicle Model",
                      controller: two.vehicleModelController.value,
                      keyboard: TextInputType.text,
                      inputFormatter: []
                    ),
                    SizedBox(height: 5,),

                    CTextField(
                      title: "Registration No",
                      controller: two.registrationNoController.value,
                      keyboard: TextInputType.text,
                      inputFormatter: []
                    ),
                    SizedBox(height: 5,),

                    CTextField(
                      title: "Seating Capacity",
                      controller: two.seatingCapacityController.value,
                      keyboard: TextInputType.text,
                      inputFormatter: []
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text("Addon"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Checkbox(
                          value: two.zeroDep.value,
                          onChanged: (value) {
                            setState(() {
                              two.zeroDep.value = value!;
                            });
                          },
                        ),
                        Text("Zero Depreciation"),
                        SizedBox(width: 2,),
                        Checkbox(
                          value: two.rsa.value,
                          onChanged: (value) {
                            setState(() {
                              two.rsa.value = value!;
                            });
                          },
                        ),
                        Text("RSA"),
                        SizedBox(width: 2,),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Checkbox(
                          value: two.consumable.value,
                          onChanged: (value) {
                            setState(() {
                              two.consumable.value = value!;
                            });
                          },
                        ),
                        Text("Consumable"),
                        SizedBox(width: 2,),
                        Checkbox(
                          value: two.enginCover.value,
                          onChanged: (value) {
                            setState(() {
                              two.enginCover.value = value!;
                            });
                          },
                        ),
                        Text("Engine Cover"),
                        SizedBox(width: 2,)
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Checkbox(
                          value: two.ncb.value,
                          onChanged: (value) {
                            setState(() {
                              two.ncb.value = value!;
                            });
                          },
                        ),
                        Text("NCB Protection"),
                        SizedBox(width: 2,),
                        Checkbox(
                          value: two.tyreCover.value,
                          onChanged: (value) {
                            setState(() {
                              two.tyreCover.value = value!;
                            });
                          },
                        ),
                        Text("Tyre Cover"),
                        SizedBox(width: 2,)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Checkbox(
                          value: two.lossKey.value,
                          onChanged: (value) {
                            setState(() {
                              two.lossKey.value = value!;
                            });
                          },
                        ),
                        Text("Loss of Keys"),
                        SizedBox(width: 2,),
                        Checkbox(
                          value: two.courtesy.value,
                          onChanged: (value) {
                            setState(() {
                              two.courtesy.value = value!;
                            });
                          },
                        ),
                        Text("Courtesy Car"),
                        SizedBox(width: 2,)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Checkbox(
                          value: two.spare.value,
                          onChanged: (value) {
                            setState(() {
                              two.spare.value = value!;
                            });
                          },
                        ),
                        Text("Spare Car"),
                        SizedBox(width: 2,),
                        Checkbox(
                          value: two.returnInvoice.value,
                          onChanged: (value) {
                            setState(() {
                              two.returnInvoice.value = value!;
                            });
                          },
                        ),
                        Text("Return to Invoice"),
                        SizedBox(width: 2,)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Checkbox(
                          value: two.medical.value,
                          onChanged: (value) {
                            setState(() {
                              two.medical.value = value!;
                            });
                          },
                        ),
                        Text("Medical Cover"),
                        SizedBox(width: 2,),
                        Checkbox(
                          value: two.dailyCash.value,
                          onChanged: (value) {
                            setState(() {
                              two.dailyCash.value = value!;
                            });
                          },
                        ),
                        Text("Daily Cash"),
                        SizedBox(width: 2,)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Checkbox(
                          value: two.roadTax.value,
                          onChanged: (value) {
                            setState(() {
                              two.roadTax.value = value!;
                            });
                          },
                        ),
                        Text("Road Tax Cover"),
                        SizedBox(width: 2,),
                        Checkbox(
                          value: two.additionalTowing.value,
                          onChanged: (value) {
                            setState(() {
                              two.additionalTowing.value = value!;
                            });
                          },
                        ),
                        Text("Additional Towing"),
                        SizedBox(width: 2,)
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: two.vas.value,
                          onChanged: (value) {
                            setState(() {
                              two.vas.value = value!;
                            });
                          },
                        ),
                        Text("VAS"),
                        SizedBox(width: 2,),
                      ],
                    ),

                    CTextField(
                      title: "Other Coverage",
                      controller: two.otherCoverController.value,
                      keyboard: TextInputType.text,
                      inputFormatter: []
                    ),
                    SizedBox(height: 5,),
                    CTextField(
                      title: "Policy Start Date",
                      controller: two.startDateController.value,
                      keyboard: TextInputType.text,
                      inputFormatter: [],
                      readOnly: true,
                      suffixicon: IconButton(onPressed: (){_selectDate(context, true);}, icon: Icon(Icons.date_range)),
                    ),
                    SizedBox(height: 5,),

                    CTextField(
                      title: "Policy End Date",
                      controller: two.endDateController.value,
                      keyboard: TextInputType.text,
                      inputFormatter: [],
                      readOnly: true,
                      suffixicon: IconButton(onPressed: (){_selectDate(context, false);}, icon: Icon(Icons.date_range)),
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
                            ShareFile share = ShareFile();
                            share.createAndShareFile();
                          }, child: Text("Share", style: TextStyle(color: ColorConstant.whiteColor),)),
                    )
                  ],
                ),
            ),
          ),
        )
    );
  }

  Future<void> _selectDate(BuildContext context,bool start) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1947), // Earliest selectable date
      lastDate: DateTime(2100),  // Latest selectable date
    );

    if (picked != null) {
      setState(() {
        if(start){
          two.startDateController.value.text = DateFormat('dd-MM-yyyy').format(picked!);
        } else {
          two.endDateController.value.text = DateFormat('dd-MM-yyyy').format(picked!);
        }

      });
    }
  }
}
