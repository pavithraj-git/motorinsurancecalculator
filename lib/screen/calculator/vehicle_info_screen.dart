import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorinsurancecalculator/common/text_field.dart';
import 'package:get/get.dart';
import '../../common/color_constant.dart';
import '../../common/drap_down.dart';
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
                    CDropDown(
                      title: "Insurance Company",
                      value: two.insuranceCompany,
                      items: two.insuranceCompanyList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          two.insuranceCompany = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'Please select';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 5,),
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
                          child: Text("Addon",style: TextStyle(fontWeight: FontWeight.bold, color: ColorConstant.baseColor)),
                        ),
                      ],
                    ),
                    Table(
                      border: TableBorder.all(),
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                      },
                      children: [

                        TableRow(
                          children: [
                            buildItem(two.zeroDep.value, "Zero Depreciation", (v) {
                              setState(() => two.zeroDep.value = v!);
                            }),
                            buildItem(two.rsa.value, "RSA", (v) {
                              setState(() => two.rsa.value = v!);
                            }),
                          ],
                        ),

                        TableRow(
                          children: [
                            buildItem(two.consumable.value, "Consumable", (v) {
                              setState(() => two.consumable.value = v!);
                            }),
                            buildItem(two.enginCover.value, "Engine Cover", (v) {
                              setState(() => two.enginCover.value = v!);
                            }),
                          ],
                        ),

                        TableRow(
                          children: [
                            buildItem(two.ncb.value, "NCB Protection", (v) {
                              setState(() => two.ncb.value = v!);
                            }),
                            buildItem(two.tyreCover.value, "Tyre Cover", (v) {
                              setState(() => two.tyreCover.value = v!);
                            }),
                          ],
                        ),

                        TableRow(
                          children: [
                            buildItem(two.lossKey.value, "Loss of Keys", (v) {
                              setState(() => two.lossKey.value = v!);
                            }),
                            buildItem(two.courtesy.value, "Courtesy Car", (v) {
                              setState(() => two.courtesy.value = v!);
                            }),
                          ],
                        ),

                        TableRow(
                          children: [
                            buildItem(two.spare.value, "Spare Car", (v) {
                              setState(() => two.spare.value = v!);
                            }),
                            buildItem(two.returnInvoice.value, "Return to Invoice", (v) {
                              setState(() => two.returnInvoice.value = v!);
                            }),
                          ],
                        ),

                        TableRow(
                          children: [
                            buildItem(two.medical.value, "Medical Cover", (v) {
                              setState(() => two.medical.value = v!);
                            }),
                            buildItem(two.dailyCash.value, "Daily Cash", (v) {
                              setState(() => two.dailyCash.value = v!);
                            }),
                          ],
                        ),

                        TableRow(
                          children: [
                            buildItem(two.roadTax.value, "Road Tax Cover", (v) {
                              setState(() => two.roadTax.value = v!);
                            }),
                            buildItem(two.additionalTowing.value, "Additional Towing", (v) {
                              setState(() => two.additionalTowing.value = v!);
                            }),
                          ],
                        ),

                        // Last row (only one item → add empty cell)
                        TableRow(
                          children: [
                            buildItem(two.vas.value, "VAS", (v) {
                              setState(() => two.vas.value = v!);
                            }),
                            SizedBox(), // empty column to maintain structure
                          ],
                        ),
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


  Widget buildItem(bool value, String text, Function(bool?) onChanged) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
          ),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
