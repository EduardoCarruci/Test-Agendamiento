import 'package:agendamiento_canchas/src/controllers/db_local.dart';
import 'package:agendamiento_canchas/src/controllers/weather_controller.dart';
import 'package:agendamiento_canchas/src/models/agendamiento..dart';
import 'package:agendamiento_canchas/src/models/cancha.dart';
import 'package:agendamiento_canchas/src/models/weather.dart';
import 'package:agendamiento_canchas/src/utils/colors.dart';
import 'package:agendamiento_canchas/src/utils/provider.dart';
import 'package:agendamiento_canchas/src/utils/utils.dart';
import 'package:agendamiento_canchas/src/widgets/appbar.dart';
import 'package:agendamiento_canchas/src/widgets/textfield.dart';
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
  Cancha items = new Cancha();
  WeatherController service = new WeatherController();
  String cancha = "Juancin Football";
  TextEditingController controllername = new TextEditingController();
  final format = DateFormat("yyyy-MM-dd");
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerInfo = Provider.of<ProviderInfo>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MaterialColors.colorbackground,
      appBar: CustomBar(
        title: "Agregar reserva",
        appBar: AppBar(),
        function: addElement,
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
                              providerInfo.seleccionado = await Utils()
                                  .pickDate(context, selectedDate,
                                      "Dia del Servicio");
                              if (providerInfo.seleccionado == null) {
                                providerInfo.seleccionado = DateTime.now();
                              }
                            },
                            child: providerInfo.seleccionado == null
                                ? Text("Introduce fecha")
                                : containerRow(
                                    " " +
                                        "${providerInfo.seleccionado}"
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
                                "     " + cancha,
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
                                cancha = value.nombre;

                                setState(() {});
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    _serviceContainer(providerInfo.seleccionado),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget _serviceContainer(DateTime fecha) {
    return FutureBuilder<Weather>(
        future: service.getElements(
            format.format(DateTime.parse(fecha.toString())),
            format.format(DateTime.parse(
                DateTime(fecha.year, fecha.month, fecha.day + 1).toString()))),
        builder: (BuildContext context, AsyncSnapshot<Weather> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return _buildListView(snapshot.data);
          //mi personal widget
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

  void addElement() async {
    if (_formKey.currentState.validate()) {
      if (await ClientDatabaseProvider.db.getValueElements(
          cancha, format.format(DateTime.parse(selectedDate.toString())))) {
        Agendamiento item = new Agendamiento();
        item.nombrecancha = cancha;
        item.nombrepersona = controllername.text;
        item.fecha = format.format(DateTime.parse(selectedDate.toString()));
        ClientDatabaseProvider.db.addElement(item);
        Navigator.pushReplacementNamed(context, "/");
      } else {}

      //

    } else {}
  }
/* 
  */
}
