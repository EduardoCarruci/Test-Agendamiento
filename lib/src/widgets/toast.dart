import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MsgToast {
  void show(
    String mensaje,
    Color backgroundcolor,
    Color textcolor,
  ) {
    Fluttertoast.showToast(
      msg: mensaje,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundcolor,
      textColor: textcolor,
      fontSize: 13,
    );
  }

  cerrar() async {
    await Fluttertoast.cancel().then((isHidden) {});
  }
}
