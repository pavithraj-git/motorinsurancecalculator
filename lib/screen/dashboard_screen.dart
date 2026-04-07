import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:motorinsurancecalculator/screen/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/color_constant.dart';
import '../controller/dashboard_controller.dart';
import '../main.dart';
import 'calculator/calculation_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  final DashboardController dash = Get.put(DashboardController());
  late AnimationController _controller;

  initFun() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    if(token == null){
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
            (Route<dynamic> route) => false,
      );
    } else {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      MyApp.userData = decodedToken;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(); // repeats indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Dashboard", style: TextStyle(fontWeight: FontWeight.bold),),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
              }, icon: Icon(Icons.person, color: ColorConstant.darkRedColor)),
              IconButton(onPressed: (){
                logoutDialog(context);
              }, icon: Icon(Icons.logout, color: ColorConstant.darkRedColor)),
          ],
          ),
          body: Column(
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
                  child: AnimatedBuilder(
                      animation: _controller,
                      child: Icon(Icons.calculate, size: 40, color: ColorConstant.darkRedColor,),
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _controller.value * 2 * 3.1416, // full rotation
                        child: child,
                      );
                    },
                  ),
                ),
                title: Text("Insurance Calculator", style: TextStyle(fontWeight: FontWeight.bold),),
                trailing: Icon(Icons.arrow_forward_ios, color: ColorConstant.black900,),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CalculatorScreen()));
                },
              ),
              Divider()
            ],
          )
        ));
  }

 void logoutDialog(BuildContext context){
      showDialog(
       context: context,
       barrierDismissible: false, // optional
       builder: (BuildContext context) {
         return AlertDialog(
           title: Text('Logout'),
           content: Text('Are you sure want to logout'),
           actions: [
             TextButton(
               onPressed: () {
                 Navigator.of(context).pop();
               },
               child: Text('CANCEL'),
             ),
             TextButton(
               onPressed: () async{
                 final prefs = await SharedPreferences.getInstance();
                 await prefs.remove('token');
                 MyApp.userData = null;
                 Navigator.of(context).pop();
                 Navigator.of(context).pushAndRemoveUntil(
                   MaterialPageRoute(
                     builder: (context) => LoginScreen(),
                   ),
                       (Route<dynamic> route) => false,
                 );
               },
               child: Text('LOGOUT'),
             ),
           ],
         );
       });
  }
}
