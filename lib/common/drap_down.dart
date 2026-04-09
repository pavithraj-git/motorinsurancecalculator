import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import 'color_constant.dart';

class CDropDown<T> extends StatelessWidget {
 final  List<DropdownMenuItem<T>> items;
 final dynamic value;
 final String? title;
 final FormFieldValidator<Object?>? validator;
 final ValueChanged<dynamic>? onchage;
 bool enable = true;

  CDropDown(
      {Key? key,
        this.value,
        this.title = '',
        this.validator,
        required this.items,
        this.onchage,
        this.enable = true
      })
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
          child: Text(title!,style: TextStyle(fontWeight: FontWeight.bold, color: ColorConstant.baseColor)),
        ),
        DropdownButtonFormField<T>(
            value: value,
            validator: validator,
            items: items,
            onChanged: enable ? onchage : null,
            decoration: InputDecoration(
              fillColor: ColorConstant.gray104,
              filled: true,
              labelStyle:
              TextStyle(fontSize: 10, color: Colors.black, letterSpacing: .8),
              hintStyle:
              TextStyle(fontSize: 10, color: Colors.grey, letterSpacing: .8),
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                    color: ColorConstant.baseColor, width: 1.0),
              ),
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(5),
              //   borderSide:
              //   BorderSide(color: ColorConstant.gray104, width: 1.0),
              // ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                BorderSide(color: ColorConstant.gray104, width: 1.0),
              ),
              // contentPadding: EdgeInsets.all(padd),
            ),
          ),
      ],
    );
  }
}

