import 'dart:convert';
import 'package:agendamiento_canchas/src/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherController {
  Future<Weather> getElements(String dateInicial, String dateFinal) async {
    String apiKey = "b03eafc90974445aacf3460294a6dc32";
    print(dateInicial);

    print(dateFinal);
    String _uri =
        "https://api.weatherbit.io/v2.0/history/daily?postal_code=27601&country=US&start_date=${dateInicial.toString()}&end_date=${dateFinal.toString()}&key=${apiKey.toString()}";

    print(_uri);
    final response = await http.get(
      _uri,
    );

    Weather weather = Weather.fromMap(jsonDecode(response.body));
    print("DATA: " + weather.toJson().toString());
    return weather;
  }
}
