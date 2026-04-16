import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorinsurancecalculator/common/text_field.dart';
import 'package:get/get.dart';
import 'package:motorinsurancecalculator/model/vehicle_info_model.dart';
import 'package:pdf/src/widgets/document.dart';
import '../../common/color_constant.dart';
import '../../common/drap_down.dart';
import '../../common/share_file.dart';
import '../../controller/two_wheeler_controller.dart';
import '../../utils/pdf_views.dart';

class VehicleInfoScreen extends StatefulWidget {
  final title;
  final vehicleInfo;
  final value;
  final calculation;
  const VehicleInfoScreen({super.key, this.value, this.calculation, this. vehicleInfo, this.title});

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
                            VehicleInfoModel vehicle = VehicleInfoModel(
                              insuranceCompany: two.insuranceCompany,
                              name: two.fullNameController.value.text,
                              make: two.vehicleMakeController.value.text,
                              model: two.vehicleModelController.value.text,
                              regNo: two.registrationNoController.value.text,
                              seatingCapacity: two.seatingCapacityController.value.text,
                              zeroDep: two.zeroDep.value,
                              rsa: two.rsa.value,
                              consumable: two.consumable.value,
                              enginCover: two.enginCover.value,
                              ncb: two.ncb.value,
                              tyreCover: two.tyreCover.value,
                              lossKey: two.lossKey.value,
                              courtesy: two.courtesy.value,
                              spare: two.spare.value,
                              returnInvoice: two.returnInvoice.value,
                              medical: two.medical.value,
                              dailyCash: two.dailyCash.value,
                              roadTax: two.roadTax.value,
                              additionalTowing: two.additionalTowing.value,
                              vas: two.vas.value,
                              otherCoverage: two.otherCoverController.value.text,
                              startDate: two.startDateController.value.text,
                              endDate: two.endDateController.value.text,
                            );
                            PDFViews pdf = PDFViews();
                            if(widget.title == "Two Wheeler Premium" || widget.title == "Five Year Two Wheeler Vehicle") {
                              pdf.twoWheelerPremiumPDF(
                                  widget.title, vehicle, widget.value,
                                  widget.calculation);
                            } else if(widget.title == "Two Wheeler Passenger Carrying") {
                              pdf.twoWheelerPassengerPDF(
                                  widget.title, vehicle, widget.value,
                                  widget.calculation);
                            } else if(widget.title == "Electric one Year Two Wheeler Vehicle" || widget.title == "Electric five year Two Wheeler Vehicle"){
                            pdf.electricTwoWheelerPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Private Car Package Policy"){
                            pdf.privateCar1ODPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Private Car 1 year OD 3 years TP"){
                            pdf.privateCar3ODPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Private Car Complete"){
                            pdf.privateCarCompletePDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Electric Private Car Complete"){
                            pdf.electricCarCompletePDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Goods Carrying Vehicle - Public" || widget.title == "Electric Goods Carrying Vehicle - Public"
                            || widget.title == "Goods Carrying Vehicle - Private" || widget.title == "Electric Goods Carrying Vehicle - Private"){
                            pdf.carryingPublicPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Taxi (Upto 6 Passengers)"){
                            pdf.taxiPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Electric Taxi (Upto 6 Passengers)"){
                            pdf.electricTaxiPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Bus (More than 6 Passengers)"){
                            pdf.busPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Electric Bus (More than 6 Passengers)"){
                            pdf.electricBusPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "School Bus (More than 6 Passengers)"){
                            pdf.schoolBusPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Electric School Bus (More than 6 Passengers)"){
                            pdf.electricSchoolBusPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Three Wheeler Goods Carrying Vehicles - Public" || widget.title == "Three Wheeler Goods Carrying Vehicles - Private"){
                            pdf.threeWheelerGoodsPublicPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Three Wheeler PCV (upto 6 Passengers)"){
                            pdf.threeWheelerPCVPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Three Wheeler PCV (more 6 Passengers upto 17 Passengers)"){
                            pdf.threeWheelerPCVMorePDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "E-Rickshaw Goods Carrying Vehicle - Private"){
                            pdf.eRickshawGoodsPrivatePDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "E-Rickshaw Goods Carrying Vehicle - Public"){
                            pdf.eRickshawGoodsPublicPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "E-Rickshaw Passenger Carrying Vehicle"){
                            pdf.eRickshawPassengerPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Ambulance"){
                            pdf.ambulancePDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Hearses (Dead Body carry Vehicle)"){
                            pdf.hearsesPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Pedestrain Controlled Agricultural Tractors"){
                            pdf.tractorPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "MISC Vehicle"){
                            pdf.miscPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Private Car - SAOD"){
                            pdf.privateCarSAODPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Private Car - Comprehensive"){
                            pdf.privateCarComprehensivePDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Private Car - Third Party"){
                            pdf.privateCarTPPDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Trailer - Comprehensive"){
                            pdf.trailerComprehensivePDF(widget.title, vehicle, widget.value, widget.calculation);
                            } else if(widget.title == "Trailer - Third Party") {
                              pdf.trailerTPPDF(
                                  widget.title, vehicle, widget.value,
                                  widget.calculation);
                            }
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
