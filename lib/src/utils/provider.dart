import 'package:flutter/material.dart';

class ProviderInfo with ChangeNotifier {
  String _seleccionado = "";

  get seleccionado {
    return _seleccionado;
  }

  set seleccionado(String item) {
    this._seleccionado = item;

    notifyListeners();
  }
}
