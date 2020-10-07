import 'package:flutter/material.dart';

class ProviderInfo with ChangeNotifier {
  DateTime _seleccionado;

  get seleccionado {
    return _seleccionado;
  }

  set seleccionado(DateTime item) {
    this._seleccionado = item;

    notifyListeners();
  }
}
