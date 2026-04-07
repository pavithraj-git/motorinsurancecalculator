import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motorinsurancecalculator/screen/calculator/bike/two_wheeler_passenger_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/car/electric_car_complete_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/car/private_car_national_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/car/private_car_new_india_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/car/private_car_oriental_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/car/private_car_united_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/e_rickshaw/e_rickshaw_goods_private_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/heavy_vehicle/ambulance_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/heavy_vehicle/misc_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/heavy_vehicle/trailer_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/taxi/electric_taxi_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/taxi/taxi_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/three_wheeler/three_wheeler_goods_public_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/three_wheeler/three_wheeler_pcv_more_screen.dart';
import 'package:motorinsurancecalculator/screen/calculator/three_wheeler/three_wheeler_pcv_screen.dart';

import '../../common/color_constant.dart';
import '../../controller/dashboard_controller.dart';
import 'bike/electric_two_wheeler_screen.dart';
import 'bike/two_wheeler_premium_screen.dart';
import 'bus/bus_screen.dart';
import 'bus/electric_bus_screen.dart';
import 'bus/electric_school_bus_screen.dart';
import 'bus/school_bus_screen.dart';
import 'car/private_car_1od_1tp_screen.dart';
import 'car/private_car_1od_3tp_screen.dart';
import 'car/private_car_complete_screen.dart';
import 'car/private_car_comprehensive_screen.dart';
import 'car/private_car_saod_screen.dart';
import 'car/private_car_tp_screen.dart';
import 'e_rickshaw/e_rickshaw_goods_public_screen.dart';
import 'e_rickshaw/e_rickshaw_passenger_screen.dart';
import 'goods_carring/carrying_public_screen.dart';
import 'heavy_vehicle/hearses_screen.dart';
import 'heavy_vehicle/tractor_screen.dart';
import 'heavy_vehicle/trailer_TP_screen.dart';
import 'heavy_vehicle/trailer_comprehensive_screen.dart';
import 'heavy_vehicle/trailer_misc_screen.dart';


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final DashboardController dash = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Calculator", style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          body: ListView.builder(
              itemCount: dash.dashboardList?.length,
              itemBuilder:(context, index) {
                var item = dash.dashboardList?[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorConstant.black900, // Border color
                            width: 3,            // Border width
                          ),
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                        ),
                        padding: const EdgeInsets.all(3.0),
                        child: Image.asset("${item?.image}", width: 40, height: 40, fit: BoxFit.cover,),
                      ),
                      title: Text("${item?.title}", style: TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Icon(Icons.arrow_forward_ios, color: ColorConstant.black900,),
                      onTap: () {

                        if(item?.id == 1){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TwoWheelerPremiumScreen(title: item?.title)));
                        } else if(item?.id == 2){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TwoWheelerPremiumScreen(title: item?.title)));
                        } else if(item?.id == 3){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TwoWheelerPassengerScreen(title: item?.title)));
                        } else if(item?.id == 4){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ElectricTwoWheelerScreen(title: item?.title)));
                        } else if(item?.id == 5){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ElectricTwoWheelerScreen(title: item?.title)));
                        } else if(item?.id == 6){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateCar1OD1TPScreen(title: item?.title)));
                        } else if(item?.id == 7){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateCar1OD3TPScreen(title: item?.title)));
                        } else if(item?.id == 8){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateCarCompleteScreen(title: item?.title)));
                        } else if(item?.id == 9){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ElectricCarCompleteScreen(title: item?.title, bikeCC: "1780")));
                        }
                        // else if(item?.id == 10){
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateCarNationalScreen(title: item?.title, bikeCC:"2094")));
                        // } else if(item?.id == 11){
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateCarNewIndiaScreen(title: item?.title, bikeCC:"2094")));
                        // } else if(item?.id == 12){
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateCarOrientalScreen(title: item?.title, bikeCC:"2094")));
                        // } else if(item?.id == 13){
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateCarUnitedScreen(title: item?.title, bikeCC:"2094")));
                        // }
                        else if(item!.id! >= 14 && item.id! <= 17){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CarryingPublicScreen(title: item?.title, bikeCC: index == 13 ? "16049" : index == 14 ? "13642" : index == 15 ?"16049" : "7233")));
                        } else if(item?.id == 18){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TaxiScreen(title: item?.title, bikeCC: "6040")));
                        } else if(item?.id == 19){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ElectricTaxiScreen(title: item?.title, bikeCC: "8945")));
                        } else if(item?.id == 20){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BusScreen(title: item?.title, bikeCC: "14343")));
                        } else if(item?.id == 21){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ElectricBusScreen(title: item?.title, bikeCC: "12192")));
                        } else if(item?.id == 22){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SchoolBusScreen(title: item?.title, bikeCC: "12192")));
                        } else if(item?.id == 23){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ElectricSchoolBusScreen(title: item?.title, bikeCC: "11670")));
                        } else if(item?.id == 24 || item?.id == 25){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ThreeWheelerGoodsPublicScreen(title: item?.title, bikeCC: index == 23 ? "4492" : "3922")));
                        } else if(item?.id == 26){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ThreeWheelerPCVScreen(title: item?.title, bikeCC:"2371")));
                        } else if(item?.id == 27){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ThreeWheelerPCVMoreScreen(title: item?.title, bikeCC:"6763")));
                        } else if(item?.id == 28){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ERickshawGoodsPrivateScreen(title: item?.title, bikeCC:"3211")));
                        } else if(item?.id == 29){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ERickshawGoodsPublicScreen(title: item?.title, bikeCC:"3139")));
                        } else if(item?.id == 30){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ERickshawPassengerScreen(title: item?.title, bikeCC:"1539")));
                        } else if(item?.id == 31){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AmbulanceScreen(title: item?.title, bikeCC:"7267")));
                        }
                        // else if(item?.id == 32){
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => TrailerScreen(title: item?.title, bikeCC:"2485")));
                        // } else if(item?.id == 33){
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => TrailerMISCScreen(title: item?.title, bikeCC:"2485")));
                        // }
                        else if(item?.id == 34){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HearsesScreen(title: item?.title, bikeCC:"1645")));
                        } else if(item?.id == 35){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TractorScreen(title: item?.title, bikeCC:"1645")));
                        } else if(item?.id == 36){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MISCScreen(title: item?.title, bikeCC:"7267")));
                        } else if(item?.id == 37){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateCarSAODScreen(title: item?.title)));
                        } else if(item?.id == 38){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateCarComprehensiveScreen(title: item?.title)));
                        } else if(item?.id == 39){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateCarTPScreen(title: item?.title)));
                        } else if(item?.id == 40){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TrailerComprehensiveScreen(title: item?.title)));
                        } else if(item?.id == 41){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TrailerTPScreen(title: item?.title)));
                        }

                      },
                    ),
                    Divider()
                  ],
                );
              }
          ),
        ));
  }
}
