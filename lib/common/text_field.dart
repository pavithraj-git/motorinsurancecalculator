import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import 'color_constant.dart';

class CTextField extends StatelessWidget {
  final String hint, prefix, label, title;
  final Widget? prefixIcon;
  final int max;
  final Widget? suffixicon;
  final bool enabled;
  final TextInputType keyboard;
  final bool isprefix;
  final bool ispreicon;
  final int maxlines;
  final IconData preicon;
  final bool ispass;
  final bool isvisible;
  final bool istheme;
  final double padd;
  final bool obs;
  final bool islabel;
  final VoidCallback onTapp;
  final bool secondDesign;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatter;

  final String? Function(String?)? validator;
  final VoidCallback passontap;
  final ValueChanged<dynamic>? onchage;
  final TextEditingController controller;
  static _defaultFunction() {}
  static _defaultontap() {}
  const CTextField(
      {Key? key,
      this.hint = '',
      this.prefix = '',
      this.padd = 12,
      this.maxlines = 1,
      this.obs = false,
      this.enabled = true,
      this.suffixicon,
      this.istheme = false,
      this.label = '',
      this.ispass = false,
      this.isvisible = false,
      this.title = '',
      this.passontap = _defaultFunction,
      this.onchage,
      this.preicon = Icons.person,
      this.onTapp = _defaultontap,
      this.ispreicon = false,
      this.isprefix = false,
      this.islabel = false,
      this.max = 500,
      this.secondDesign = false,
      this.prefixIcon,
      required this.controller,
      this.validator,
      this.readOnly = false,
      this.inputFormatter,
      this.keyboard = TextInputType.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(title != '')
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(title,style: TextStyle(fontWeight: FontWeight.bold, color: ColorConstant.baseColor)),
        ),
        TextFormField(
          readOnly: readOnly,
          validator: validator,
          onTap: onTapp,
          obscureText: obs ? true : false,
          focusNode: enabled ? FocusNode() : AlwaysDisabledFocusNode(),
          controller: controller,
          keyboardType: keyboard,
          inputFormatters: inputFormatter ??  [
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d*\.?\d*$'), // Digits + at most 1 decimal, no spaces
            ),
            FilteringTextInputFormatter.deny(RegExp(r'\s')), // explicitly deny spaces
          ],
          maxLength: max,
          // cursorColor: Get.theme.primaryColor,
          cursorWidth: 2,
          onChanged: onchage,
          maxLines: maxlines,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              letterSpacing: .8),
          decoration: InputDecoration(
            prefix: Text(
              prefix,
              style: TextStyle(
                  fontSize: 15, color: Colors.black, letterSpacing: .8),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixicon,
            counterText: '',
            label: Text(
              hint,
              style: TextStyle(
                  fontSize: 12, color: Colors.grey, letterSpacing: .8),
            ),
            fillColor: ColorConstant.gray104,
            filled: true,
            floatingLabelBehavior: islabel
                ? FloatingLabelBehavior.always
                : FloatingLabelBehavior.auto,
            labelStyle:
            TextStyle(fontSize: 10, color: Colors.black, letterSpacing: .8),
            hintStyle:
            TextStyle(fontSize: 10, color: Colors.grey, letterSpacing: .8),
            hintText: label,
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(5),
            //   borderSide:
            //   BorderSide(color: ColorConstant.gray104, width: 1.0),
            // ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: ColorConstant.baseColor, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: ColorConstant.red500, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: ColorConstant.red500, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: ColorConstant.baseColor, width: 1.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
              BorderSide(color: ColorConstant.gray104, width: 1.0),
            ),
            contentPadding: EdgeInsets.all(padd),
          ),
        ),
      ],
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class textfieldss extends StatelessWidget {
  final TextEditingController controller;
  const textfieldss({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon:
                Image(image: AssetImage('asset/onboarding/profile.png')),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: 'Name',
            labelStyle: new TextStyle(
              fontSize: 17,
              color: Colors.black,
            )),
      ),
    );
  }
}

RegExp emailValidator(){
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  return RegExp(pattern);
}


RegExp mobileValidator(){
  const pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  return RegExp(pattern);
}


///inputformatters
//FilteringTextInputFormatter.digitsOnly