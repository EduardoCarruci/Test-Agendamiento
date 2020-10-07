import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//-------------------------------------------------------------------------------------------------------------
import 'package:agendamiento_canchas/src/pages/home.dart';
import 'package:agendamiento_canchas/src/pages/reservas.dart';
import 'package:provider/provider.dart';

import 'src/utils/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderInfo(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Test App',
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) => HomePage(),
            'reserva': (BuildContext context) => ReservasPage(),
          }),
    );
  }
}
