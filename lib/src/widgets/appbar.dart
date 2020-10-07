import 'package:agendamiento_canchas/src/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomBar extends StatefulWidget implements PreferredSizeWidget {
  final AppBar appBar;

  final Function function;

  final String title;

  const CustomBar({this.appBar, this.function, @required this.title});

  @override
  _BarraState createState() => _BarraState();

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}

// BARRA DE ESTADOS POR AHORA FALTA AGREGAR LAS NAVEGACIONES A PANTALLAS ANTERIORES.
class _BarraState extends State<CustomBar> {
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: MaterialColors.colorappBar,
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        widget.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      titleSpacing: 5,
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            widget.function();
          },
        )
      ],
    );
  }
}
