import 'package:agendamiento_canchas/src/controllers/db_local.dart';
import 'package:agendamiento_canchas/src/controllers/weather_controller.dart';
import 'package:agendamiento_canchas/src/models/agendamiento..dart';
import 'package:agendamiento_canchas/src/models/cancha.dart';
import 'package:agendamiento_canchas/src/models/weather.dart';
import 'package:agendamiento_canchas/src/utils/colors.dart';
import 'package:agendamiento_canchas/src/utils/provider.dart';
import 'package:agendamiento_canchas/src/utils/utils.dart';
import 'package:agendamiento_canchas/src/widgets/textfield.dart';
import 'package:agendamiento_canchas/src/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReservasPage extends StatefulWidget {
  @override
  _ReservasPageState createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  MsgToast toast = new MsgToast();
  Cancha items = new Cancha();
  WeatherController service = new WeatherController();
  //String cancha = "Juancin Football";
  TextEditingController controllername = new TextEditingController();
  final format = DateFormat("yyyy-MM-dd");
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final providerInfo = Provider.of<ProviderInfo>(context);
    return Scaffold(
      backgroundColor: MaterialColors.colorbackground,
      appBar: AppBar(
        title: Text("Agregar reserva"),
        centerTitle: true,
        backgroundColor: MaterialColors.colorappBar,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                addElement(providerInfo.seleccionado);
              })
        ],
      ),
      body: Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: MaterialColors.colorappBar,
                          size: 30,
                        ),
                        Expanded(
                          child: CustomTextField(
                            controller: controllername,
                            inputType: TextInputType.text,
                            labelText: "Introduce tu nombre",
                            validatorText: "Introduce tu nombre",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Fecha de reserva: ",
                          style: TextStyle(
                              color: MaterialColors.colorappBar,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(30)),
                        ),
                        Spacer(),
                        MaterialButton(
                            onPressed: () async {
                              selectedDate = await Utils().pickDate(
                                  context, selectedDate, "Dia del Servicio");
                              if (selectedDate == null) {
                                selectedDate = DateTime.now();
                              } else
                                setState(() {});
                            },
                            child: selectedDate == null
                                ? Text("Introduce fecha")
                                : containerRow(
                                    " " +
                                        "${selectedDate.toLocal()}"
                                            .split(' ')[0],
                                    Icons.calendar_today)),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Tipo de Cancha:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(30),
                                color: MaterialColors.colorappBar)),
                        Expanded(
                          child: Container(
                            height: 45,
                            //decoration: Utilidades.decorationDrownButton,
                            child: DropdownButton<Cancha>(
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(30),
                                  color: MaterialColors.colorappBar),
                              isExpanded: true,
                              itemHeight: 55,
                              underline: Container(),
                              hint: (Text(
                                "     " + providerInfo.seleccionado,
                              )),
                              items:
                                  items.creacionCanchas().map((Cancha value) {
                                return new DropdownMenuItem<Cancha>(
                                  value: value,
                                  child: new Text(
                                    value.nombre,
                                    style: TextStyle(
                                        color: MaterialColors.colorappBar),
                                  ),
                                );
                              }).toList(),
                              onChanged: (Cancha value) {
                                providerInfo.seleccionado = value.nombre;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    _serviceContainer(),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget _serviceContainer() {
    return FutureBuilder<Weather>(
        future: service.getElements(
            format.format(DateTime.parse(selectedDate.toString())),
            format.format(DateTime.parse(DateTime(
                    selectedDate.year, selectedDate.month, selectedDate.day + 1)
                .toString()))),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot<Weather> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("Ocurrio algun error",
                  style: TextStyle(color: Colors.white));
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.data == null) {
                 return Text("Intenta con otra fecha",style: TextStyle(
                        color: MaterialColors.colorappBar
                      ));
              } else
                return _buildListView(snapshot.data);
              break;
          }
        
        });
  }

  Widget _buildListView(Weather data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.cityName +
                "  -  " +
                data.countryCode +
                "  -  " +
                data.stateCode),
            ListView.builder(
                shrinkWrap: true,
                itemCount: data.data.length,
                itemBuilder: (_, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Cobertura media de nubes: " +
                          data.data[i].clouds.toString()),
                      Text("Precipitación acumulada: " +
                          data.data[i].precip.toString()),
                      Text("Temperatura promedio: " +
                          data.data[i].temp.toString()),
                      Text("Temperatura máxima: " +
                          data.data[i].maxTemp.toString()),
                      Text("Temperatura mínima: " +
                          data.data[i].minTemp.toString()),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget containerRow(String text, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: MaterialColors.colorappBar),
        Text(
          text,
          style: TextStyle(
              color: MaterialColors.colorappBar,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(30)),
        ),
      ],
    );
  }

  void addElement(String nombrecancha) async {
    if (_formKey.currentState.validate() && nombrecancha != "") {
      if (await ClientDatabaseProvider.db.getValueElements(nombrecancha,
          format.format(DateTime.parse(selectedDate.toString())))) {
        Agendamiento item = new Agendamiento();
        item.nombrecancha = nombrecancha;
        item.nombrepersona = controllername.text;
        item.fecha = format.format(DateTime.parse(selectedDate.toString()));
        await ClientDatabaseProvider.db.addElement(item);
        Navigator.pushNamed(context, "/");
      } else {
        toast?.show(
            "Los cupos para este día ya fueron tomados\nselecciona otro día",
            MaterialColors.colorappBar,
            Colors.white);
      }

      //

    } else {
      toast?.show("Completa todos los campos", MaterialColors.colorappBar,
          Colors.white);
    }
  }
/* 
  */
}
