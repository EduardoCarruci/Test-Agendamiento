import 'package:agendamiento_canchas/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String labelText;
  final String validatorText;
  CustomTextField({
    @required this.controller,
    @required this.inputType,
    @required this.labelText,
    @required this.validatorText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     
      child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value.isEmpty) {
              return validatorText;
            }
            return null;
          },
          decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: labelText,
            hintStyle: TextStyle(
                color: MaterialColors.colorappBar,
                fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true),fontWeight: FontWeight.bold),
            labelStyle: TextStyle(
                color: MaterialColors.colorappBar,
                fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true),fontWeight: FontWeight.bold),
          ),
          style: TextStyle(
              fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true),
              //fontFamily: 'Lato-Medium',
              color: MaterialColors.colorappBar),
          keyboardType: inputType),
    );
  }
}
