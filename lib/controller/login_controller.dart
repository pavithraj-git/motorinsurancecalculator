
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/api_url.dart';
import '../screen/dashboard_screen.dart';
import '../utils/base_client.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController().obs;
  final mobileController = TextEditingController().obs;

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

  Future pinLoginAPIFun(BuildContext context, String pin) async{
    String? deviceID = await getDeviceId();
    Map<String, String> body = {
      "mpin": pin,
      "deviceid": deviceID ?? "0"
    };

    final result = await BaseClient().post(ApiUrl().pinLogin, body);
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

  Future loginAPIFun(BuildContext context) async{
    Map<String, String> body = {
      "mail": emailController.value.text.trim(),
      "phone": mobileController.value.text.trim()
    };

    final result = await BaseClient().post(ApiUrl().login, body);
    if(result['status'] == true){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
        ),
      );
      emailController.value.text ="";
      mobileController.value.text ="";
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