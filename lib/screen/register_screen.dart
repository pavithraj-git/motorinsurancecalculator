import 'package:flutter/material.dart';
import 'package:motorinsurancecalculator/screen/login_screen.dart';

import '../common/color_constant.dart';
import '../common/drap_down.dart';
import '../common/text_field.dart';
import '../controller/register_controller.dart';
import 'package:get/get.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController reg = Get.put(RegisterController());
  final regKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: regKey,
                child: Column(
                  children: [
                    CTextField(
                      title: "Full Name",
                      controller: reg.fullNameController.value,
                      keyboard: TextInputType.text,
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
                      title: "Email ID",
                      controller: reg.emailController.value,
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
                      title: "Mobile",
                      controller: reg.mobileController.value,
                      keyboard: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 5,),
                    CDropDown(
                      title: "State",
                      value: reg.state,
                      items: reg.stateList.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onchage: (value){
                        setState(() {
                          reg.state = value;
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
                      title: "City",
                      controller: reg.cityController.value,
                      keyboard: TextInputType.text,
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
                      title: "mPIN",
                      controller: reg.mPINController.value,
                      keyboard: TextInputType.number,
                      max: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter';
                        }
                        return null;
                      },
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
                            if (regKey.currentState!.validate()) {
                              regKey.currentState?.save();
                              reg.registerAPIFun(context);
                            }
                          }, child: Text("Register", style: TextStyle(color: ColorConstant.whiteColor),)),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account"),
                        TextButton(onPressed: (){
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                                (Route<dynamic> route) => false,
                          );
                        }, child: Text("Login"))
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
