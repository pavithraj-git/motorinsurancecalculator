

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motorinsurancecalculator/common/api_url.dart';
import 'package:motorinsurancecalculator/utils/base_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/dashboard_screen.dart';


class RegisterController extends GetxController{
  final fullNameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final mobileController = TextEditingController().obs;
  final cityController = TextEditingController().obs;
  final mPINController = TextEditingController().obs;
  List<String> stateList = ["Andaman & Nicobar", "Andhra Predesh", "Assam & North East", "Bihar", "Chandigarh", "Chattisgarh","Dadra & Nagar Haveli", "Daman & Diu", "Delhi", "Goa", "Gujrat", "Haryana", "HP", "Jammu & Kashmir", "Jharkhand", "Karnataka", "Kerala", " Lakshadweep", "Madhya Pradesh", "Maharashtra","Orissa", "Pondicherry", "Punjab", "Rajasthan", "Sikkim", "Tamil Nadu", "Uttar Pradesh", "Uttaranchal", "West Bengal"];
  var state = "Tamil Nadu";

  static const MethodChannel _channel = MethodChannel('device_id_channel');
  Future<String?> getDeviceId() async {
    if(kIsWeb) {
      return null;
    }
    try {
      final String? deviceId = await _channel.invokeMethod('getDeviceId');
      return deviceId;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future registerAPIFun(BuildContext context) async{
    String? deviceID = await getDeviceId();
    Map<String, String> body = {
      "name": fullNameController.value.text.trim(),
      "mail": emailController.value.text.trim(),
      "phone": mobileController.value.text.trim(),
      "state": state,
      "city": cityController.value.text.trim(),
      "mpin": mPINController.value.text.trim(),
      "deviceid": deviceID ?? "0"
    };

    final result = await BaseClient().post(ApiUrl().register, body);
    if(result['status'] == true){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
        ),
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result["token"]);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        ),
            (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
        ),
      );
    }
  }

}