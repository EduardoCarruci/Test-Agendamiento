import 'package:agendamiento_canchas/src/utils/colors.dart';
import 'package:flutter/material.dart';

class Utils {
  // ignore: missing_return

  // ignore: missing_return
  Future<DateTime> pickDate(
      BuildContext context, DateTime selectedDate, String helpText) async {
    final DateTime picked = await showDatePicker(
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.black,
                onPrimary: Colors.white,
                surface: MaterialColors.colorappBar,
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: MaterialColors.colorappBar,
            ),
            child: child,
          );
        },
        context: context,
        helpText: helpText,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      return selectedDate;
    }
  }
}
