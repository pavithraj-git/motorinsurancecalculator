import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/screen/dashboard_screen.dart';
import 'package:motorinsurancecalculator/screen/register_screen.dart';
import 'package:pinput/pinput.dart';

import '../common/color_constant.dart';
import '../common/text_field.dart';
import '../controller/login_controller.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController log = Get.put(LoginController());
  final logKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: logKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Pinput(
                      forceErrorState: true,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      // validator: (pin) {
                      //   if (pin == '2224') return null;
                      //   return 'Pin is incorrect';
                      // },
                      onCompleted: (value){
                        log.pinLoginAPIFun(context, value);
                      },
                    ),
                    SizedBox(height: 5,),
                    Text("OR"),
                    SizedBox(height: 5,),
                    CTextField(
                      title: "Registered Email ID",
                      controller: log.emailController.value,
                      keyboard: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter';
                          }
                          return null;
                        },
                        inputFormatter: []
                    ),
                    SizedBox(height: 5,),
                    CTextField(
                      title: "Registered Mobile No",
                      controller: log.mobileController.value,
                      keyboard: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter';
                          }
                          return null;
                        }
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
                            // if (logKey.currentState!.validate()) {
                            //   logKey.currentState?.save();
                            //   log.loginAPIFun(context);
                            // }
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => DashboardScreen(),
                              ),
                                  (Route<dynamic> route) => false,
                            );
                          }, child: Text("Login", style: TextStyle(color: ColorConstant.whiteColor),)),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account"),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                        }, child: Text("Register", style: TextStyle(fontWeight: FontWeight.bold)))
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
