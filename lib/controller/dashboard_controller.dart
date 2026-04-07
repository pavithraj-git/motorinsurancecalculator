import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motorinsurancecalculator/model/dashboard_model.dart';


class DashboardController extends GetxController {
  List<DashboardModel>? dashboard1List = [
    DashboardModel(
        id: 1,
        image: "assets/bike.PNG",
        title: "Two Wheeler 1 Year OD"
    ),
    DashboardModel(
        id: 2,
        image: "assets/bike.PNG",
        title: "Two Wheeler 1 Year OD 1 Year TP"
    ),
    DashboardModel(
        id: 3,
        image: "assets/bike.PNG",
        title: "Two Wheeler 1 Year OD 5 Year TP"
    ),
    DashboardModel(
        id: 4,
        image: "assets/bike.PNG",
        title: "Electric Two Wheeler 1 Year"
    ),
    DashboardModel(
        id: 5,
        image: "assets/bike.PNG",
        title: "Electric Two Wheeler 1 Year OD 1 Year TP"
    ),
    DashboardModel(
        id: 6,
        image: "assets/bike.PNG",
        title: "Electric Two Wheeler 1 Year OD 5 Year TP"
    ),
    DashboardModel(
        id: 7,
        image: "assets/bike.PNG",
        title: "Two Wheeler Passenger Carrying"
    ),
    DashboardModel(
        id: 8,
        image: "assets/bike.PNG",
        title: "Private Car 1 Year OD"
    ),
    DashboardModel(
        id: 9,
        image: "assets/bike.PNG",
        title: "Private Car 1 Year OD 1 Year TP"
    ),
    DashboardModel(
        id: 10,
        image: "assets/bike.PNG",
        title: "Private Car 1 Year OD 3 Year TP"
    ),
    DashboardModel(
        id: 11,
        image: "assets/bike.PNG",
        title: "Private Car Complete 1 Year OD"
    ),
    DashboardModel(
        id: 12,
        image: "assets/bike.PNG",
        title: "Private Car Complete"
    ),
    DashboardModel(
        id: 13,
        image: "assets/bike.PNG",
        title: "Electric Private Car 1 Year OD"
    ),
    DashboardModel(
        id: 14,
        image: "assets/bike.PNG",
        title: "Electric Private Car 1 Year OD 1 Year TP"
    ),
    DashboardModel(
        id: 15,
        image: "assets/bike.PNG",
        title: "Electric Private Car 1 Year OD 3 Year TP"
    ),
    DashboardModel(
        id: 16,
        image: "assets/bike.PNG",
        title: "Electric Private Car Complete"
    ),
    DashboardModel(
        id: 17,
        image: "assets/bike.PNG",
        title: "Goods Carrying Vehicle - Public"
    ),
    DashboardModel(
        id: 18,
        image: "assets/bike.PNG",
        title: "Electric Goods Carrying Vehicle - Public"
    ),
    DashboardModel(
        id: 19,
        image: "assets/bike.PNG",
        title: "Goods Carrying Vehicle - Private"
    ),
    DashboardModel(
        id: 20,
        image: "assets/bike.PNG",
        title: "Electric Goods Carrying Vehicle - Private"
    ),
    DashboardModel(
        id: 21,
        image: "assets/bike.PNG",
        title: "Taxi (Upto 6 Passengers)"
    ),
    DashboardModel(
        id: 22,
        image: "assets/bike.PNG",
        title: "Electric Taxi (Upto 6 Passengers)"
    ),
    DashboardModel(
        id: 23,
        image: "assets/bike.PNG",
        title: "Bus (More than 6 Passengers)"
    ),
    DashboardModel(
        id: 24,
        image: "assets/bike.PNG",
        title: "Electric Bus (More than 6 Passengers)"
    ),
    DashboardModel(
        id: 25,
        image: "assets/bike.PNG",
        title: "School Bus (More than 6 Passengers)"
    ),
    DashboardModel(
        id: 26,
        image: "assets/bike.PNG",
        title: "Electric School Bus (More than 6 Passengers)"
    ),
    DashboardModel(
        id: 27,
        image: "assets/bike.PNG",
        title: "Three Wheeler Goods Carrying Vehicles - Public"
    ),
    DashboardModel(
        id: 28,
        image: "assets/bike.PNG",
        title: "Three Wheeler Goods Carrying Vehicles - Private"
    ),
    DashboardModel(
        id: 29,
        image: "assets/bike.PNG",
        title: "Three Wheeler PCV (upto 6 Passengers)"
    ),
    DashboardModel(
        id: 30,
        image: "assets/bike.PNG",
        title: "Three Wheeler PCV (more 6 Passengers upto 17 Passengers)"
    ),
    DashboardModel(
        id: 31,
        image: "assets/bike.PNG",
        title: "E-Rickshaw Goods Carrying Vehicle - Private"
    ),
    DashboardModel(
        id: 32,
        image: "assets/bike.PNG",
        title: "E-Rickshaw Goods Carrying Vehicle - Public"
    ),
    DashboardModel(
        id: 33,
        image: "assets/bike.PNG",
        title: "E-Rickshaw Passenger Carrying Vehicle"
    ),
    DashboardModel(
        id: 34,
        image: "assets/bike.PNG",
        title: "Ambulance"
    ),
    DashboardModel(
        id: 35,
        image: "assets/bike.PNG",
        title: "Trailer"
    ),
    DashboardModel(
        id: 36,
        image: "assets/bike.PNG",
        title: "Trailer and Others MISC"
    ),
    DashboardModel(
        id: 37,
        image: "assets/bike.PNG",
        title: "Hearses (Dead Body carry Vehicle)"
    ),
    DashboardModel(
        id: 38,
        image: "assets/bike.PNG",
        title: "Pedestrain Controlled Agricultural Tractors"
    ),
    DashboardModel(
        id: 39,
        image: "assets/bike.PNG",
        title: "MISC Vehicle"
    ),
    DashboardModel(
        id: 40,
        image: "assets/bike.PNG",
        title: "Private Car - National"
    ),
    DashboardModel(
        id: 41,
        image: "assets/bike.PNG",
        title: "Private Car - New India"
    ),
    DashboardModel(
        id: 42,
        image: "assets/bike.PNG",
        title: "Private Car - Oriental"
    ),
    DashboardModel(
        id: 43,
        image: "assets/bike.PNG",
        title: "Private Car - United"
    )
  ];

  List<DashboardModel>? dashboardList = [
    DashboardModel(
        id: 1,
        image: "assets/bike.jfif",
        title: "Two Wheeler Premium"
    ),
    DashboardModel(
        id: 2,
        image: "assets/bike.jfif",
        title: "Five Year Two Wheeler Vehicle"
    ),
    DashboardModel(
        id: 3,
        image: "assets/bike.jfif",
        title: "Two Wheeler Passenger Carrying"
    ),
    DashboardModel(
        id: 4,
        image: "assets/bike.jfif",
        title: "Electric one Year Two Wheeler Vehicle"
    ),
    DashboardModel(
        id: 5,
        image: "assets/bike.jfif",
        title: "Electric five year Two Wheeler Vehicle"
    ),
    DashboardModel(
        id: 6,
        image: "assets/car.jfif",
        title: "Private Car Package Policy"
    ),
    DashboardModel(
        id: 7,
        image: "assets/car.jfif",
        title: "Private Car 1 year OD 3 years TP"
    ),
    DashboardModel(
        id: 8,
        image: "assets/car.jfif",
        title: "Private Car Complete"
    ),
    DashboardModel(
        id: 9,
        image: "assets/car.jfif",
        title: "Electric Private Car Complete"
    ),
    // DashboardModel(
    //     id: 10,
    //     image: "assets/bike.PNG",
    //     title: "Private Car - National"
    // ),
    // DashboardModel(
    //     id: 11,
    //     image: "assets/bike.PNG",
    //     title: "Private Car - New India"
    // ),
    // DashboardModel(
    //     id: 12,
    //     image: "assets/bike.PNG",
    //     title: "Private Car - Oriental"
    // ),
    // DashboardModel(
    //     id: 13,
    //     image: "assets/bike.PNG",
    //     title: "Private Car - United"
    // ),
    DashboardModel(
        id: 14,
        image: "assets/goods_public.jfif",
        title: "Goods Carrying Vehicle - Public"
    ),
    DashboardModel(
        id: 15,
        image: "assets/goods_public.jfif",
        title: "Electric Goods Carrying Vehicle - Public"
    ),
    DashboardModel(
        id: 16,
        image: "assets/goods_private.jfif",
        title: "Goods Carrying Vehicle - Private"
    ),
    DashboardModel(
        id: 17,
        image: "assets/goods_private.jfif",
        title: "Electric Goods Carrying Vehicle - Private"
    ),
    DashboardModel(
        id: 18,
        image: "assets/taxi.jfif",
        title: "Taxi (Upto 6 Passengers)"
    ),
    DashboardModel(
        id: 19,
        image: "assets/taxi.jfif",
        title: "Electric Taxi (Upto 6 Passengers)"
    ),
    DashboardModel(
        id: 20,
        image: "assets/bus.jfif",
        title: "Bus (More than 6 Passengers)"
    ),
    DashboardModel(
        id: 21,
        image: "assets/bus.jfif",
        title: "Electric Bus (More than 6 Passengers)"
    ),
    DashboardModel(
        id: 22,
        image: "assets/school_bus.jfif",
        title: "School Bus (More than 6 Passengers)"
    ),
    DashboardModel(
        id: 23,
        image: "assets/school_bus.jfif",
        title: "Electric School Bus (More than 6 Passengers)"
    ),
    DashboardModel(
        id: 24,
        image: "assets/3_goods.jfif",
        title: "Three Wheeler Goods Carrying Vehicles - Public"
    ),
    DashboardModel(
        id: 25,
        image: "assets/3_goods.jfif",
        title: "Three Wheeler Goods Carrying Vehicles - Private"
    ),
    DashboardModel(
        id: 26,
        image: "assets/auto.jfif",
        title: "Three Wheeler PCV (upto 6 Passengers)"
    ),
    DashboardModel(
        id: 37,
        image: "assets/auto.jfif",
        title: "Three Wheeler PCV (more 6 Passengers upto 17 Passengers)"
    ),
    DashboardModel(
        id: 28,
        image: "assets/e_rickshaw.jfif",
        title: "E-Rickshaw Goods Carrying Vehicle - Private"
    ),
    DashboardModel(
        id: 29,
        image: "assets/e_rickshaw.jfif",
        title: "E-Rickshaw Goods Carrying Vehicle - Public"
    ),
    DashboardModel(
        id: 30,
        image: "assets/e_rickshaw.jfif",
        title: "E-Rickshaw Passenger Carrying Vehicle"
    ),
    DashboardModel(
        id: 31,
        image: "assets/ambulance.jfif",
        title: "Ambulance"
    ),
    // DashboardModel(
    //     id: 32,
    //     image: "assets/bike.PNG",
    //     title: "Trailer"
    // ),
    // DashboardModel(
    //     id: 33,
    //     image: "assets/bike.PNG",
    //     title: "Trailer and Others MISC"
    // ),
    DashboardModel(
        id: 34,
        image: "assets/hearses.jfif",
        title: "Hearses (Dead Body carry Vehicle)"
    ),
    DashboardModel(
        id: 35,
        image: "assets/tractor.jfif",
        title: "Pedestrain Controlled Agricultural Tractors"
    ),
    DashboardModel(
        id: 36,
        image: "assets/misc.jfif",
        title: "MISC Vehicle"
    ),
    DashboardModel(
        id: 37,
        image: "assets/car.jfif",
        title: "Private Car - SAOD"
    ),
    DashboardModel(
        id: 38,
        image: "assets/car.jfif",
        title: "Private Car - Comprehensive"
    ),
    DashboardModel(
        id: 39,
        image: "assets/car.jfif",
        title: "Private Car - Third Party"
    ),
    DashboardModel(
        id: 40,
        image: "assets/trailer.jfif",
        title: "Trailer - Comprehensive"
    ),
    DashboardModel(
        id: 41,
        image: "assets/trailer.jfif",
        title: "Trailer - Third Party"
    ),
  ];
}