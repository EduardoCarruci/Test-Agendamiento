import 'package:agendamiento_canchas/src/controllers/db_local.dart';
import 'package:agendamiento_canchas/src/models/agendamiento..dart';
import 'package:agendamiento_canchas/src/utils/colors.dart';
import 'package:agendamiento_canchas/src/widgets/appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      backgroundColor: MaterialColors.colorbackground,
      appBar: CustomBar(
        title: "Listado de Reservas",
        appBar: AppBar(),
        function: backPress,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<List<Agendamiento>>(
                  future: ClientDatabaseProvider.db.getAllReservas(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Agendamiento>> snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());

                    List<Agendamiento> list = new List<Agendamiento>();
                    list = snapshot.data;
                    if (list.length == 0) {
                      return Center(
                        child: Text("No tienes registros"),
                      );
                    } else
                      return _buildListView(snapshot.data);

                    //mi personal widget
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView(List<Agendamiento> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Agendamiento profile = list[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              elevation: 5.0,
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.nombrepersona,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      profile.nombrecancha,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      profile.fecha,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
                trailing: MaterialButton(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Colors.pink,
                      ),
                    ),
                    onPressed: () async {
                      // confirmar el delete
                      String check = await dialogshow();

                      if (check == "delete") {
                        ClientDatabaseProvider.db.deleteReserva(profile.id);
                      }

                      setState(() {});
                    },
                    child:
                        Text("Borrar", style: TextStyle(color: Colors.white)),
                    color: Colors.pinkAccent),
              ),
            ),
          );
        },
        itemCount: list.length,
      ),
    );
  }

  Future<String> dialogshow() async => await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xFF1c1b21),
            actions: <Widget>[
              Text("Deseas eliminar esta reserva?",
                  style: TextStyle(color: Colors.white)),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context, "delete");
                },
                child: Text("OK", style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );

  void backPress() {
    Navigator.pushNamed(context, "reserva");
  }
}
